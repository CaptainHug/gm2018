package state;
import game.objects.Player;
import haxe.Json;
import motion.Actuate;
import motion.easing.Linear;
import network.GameServer;
import network.event.GameServerEvent;
import openfl.Assets;
import openfl.Lib;
import openfl.events.MouseEvent;
import ui.ChatPanel;
import ui.Image;
import ui.Sprite;
import ui.event.UIDataEvent;

/**
 * ...
 * @author hug
 */
class State_GameRoom extends BaseState 
{
	inline public static var MOVEMENT_SPEED:Float = 1 / 120;	// 120 pixels per second
	
	private var _server:GameServer;
	private var _bg:Image;
	private var _playArea:Sprite;
	private var _self:Player;
	private var _players:Map<String, Player>;
	private var _chatPanel:ChatPanel;
	
	
	public function new() 
	{
		super();
		
	}
	
	
	override public function init():Void
	{
		super.init();
		
		trace("State_GameRoom: init");
		
		_server = Kernel.getInstance().getGameServer();
		_server.addEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
		
		_server.sendExtMessage("game", "joinRoom", {});
		
		_bg = new Image(Assets.getBitmapData("img/maps/street.jpg"));
		addChild(_bg);
		
		_playArea = new Sprite();
		_playArea.graphics.beginFill(0xff00ff, 0);
		_playArea.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight * 0.91);
		_playArea.graphics.endFill();
		_playArea.mouseEnabled = true;
		_playArea.addEventListener(MouseEvent.CLICK, onClick);
		addChild(_playArea);
		
		_self = new Player();
		_self.mouseEnabled = false;
		_playArea.addChild(_self);
		
		_players = new Map<String, Player>();
		
		_chatPanel = new ChatPanel();
		_chatPanel.addEventListener(ChatPanel.MESSAGE_SENT, onMessageSent);
		addChild(_chatPanel);
		_chatPanel.y = Lib.current.stage.stageHeight * 0.91;
	}
	
	
	override public function dispose():Void
	{
		trace("State_GameRoom: dispose");
		
		if (_server != null) {
			_server.removeEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
		}
		
		if (_self != null) {
			_self.dispose();
			_self = null;
		}
		
		// TODO: cleanup players
		
		if (_bg != null) {
			_bg.dispose();
			_bg = null;
		}
		
		if (_playArea != null) {
			_playArea.removeEventListener(MouseEvent.CLICK, onClick);
			_playArea.dispose();
			_playArea = null;
		}
		
		if (_chatPanel != null) {
			_chatPanel.removeEventListener(ChatPanel.MESSAGE_SENT, onMessageSent);
			_chatPanel.dispose();
			_chatPanel = null;
		}
		
		super.dispose();
		
	}
	
	
	private function onClick(e:MouseEvent):Void
	{
		var posX:Int = cast(e.stageX, Int);
		var posY:Int = cast(e.stageY, Int);
		
		_server.sendExtMessage("game", "move", {posX:posX, posY:posY});
		
		var distance:Float = Math.abs(Math.sqrt(Math.pow(_self.x - posX, 2) + Math.pow(_self.y - posY, 2)));
		Actuate.tween(_self, distance * MOVEMENT_SPEED, {x:posX, y:posY}).ease(Linear.easeNone);
	}
	
	
	private function onMessageSent(e:UIDataEvent):Void
	{
		var message:String = e.data.message;
		_server.sendExtMessage("game", "chat", {message:message});
		
		_self.chat(message);
	}
	
	
	private function onExtensionResponse(e:GameServerEvent):Void
	{
		trace("onExtensionResponse: " + Json.stringify(e.data));
		
		var playerData:Dynamic;
		var playerObj:Player;
		
		if (e.data) {
			switch(e.data.cmd) {
				
				case "onJoinRoom":
				{
					trace("onExtensionResponse: onJoinRoom");
					
					playerData = Json.parse(e.data.params.player);
					_self.setName(playerData.name);
					_self.x = playerData.x;
					_self.y = playerData.y;
					
					// set up all the existing server players
					var allPlayerData:Dynamic = Json.parse(e.data.params.allPlayers);
					if (allPlayerData != null) {
						var fields:Array<String> = Reflect.fields(allPlayerData);
						var playerId:String;
						for (playerId in fields) {
							if (playerId != e.data.params.playerId) {
								playerData = Reflect.field(allPlayerData, playerId);
								if(playerData != null) {
									playerObj = new Player();
									playerObj.mouseEnabled = false;
									playerObj.setName(playerData.name);
									playerObj.x = playerData.x;
									playerObj.y = playerData.y;
									_players.set(playerId, playerObj);
									_playArea.addChild(playerObj);
								}
							}
						}
					}
				}
				
				case "onBroadcastJoinRoom":
				{
					trace("onExtensionResponse: onBroadcastJoinRoom");
					
					playerData = Json.parse(e.data.params.player);
					if(playerData != null) {
						playerObj = new Player();
						playerObj.mouseEnabled = false;
						playerObj.setName(playerData.name);
						playerObj.x = playerData.x;
						playerObj.y = playerData.y;
						_players.set(e.data.params.playerId, playerObj);
						_playArea.addChild(playerObj);
					}
				}
				
				case "onBroadcastPlayerLeft":
				{
					playerObj = _players.get(e.data.params.playerId);
					if (playerObj != null) {
						if (_playArea.contains(playerObj)) {
							_playArea.removeChild(playerObj);
						}
						playerObj.dispose();
						playerObj = null;
						_players.remove(e.data.params.playerId);
					}
				}
				
				case "onBroadcastMove":
				{
					trace("onExtensionResponse: onBroadcastMove");
					
					playerObj = _players.get(e.data.params.playerId);
					if(playerObj != null) {
						var posX:Int = e.data.params.posX;
						var posY:Int = e.data.params.posY;
						
						var distance:Float = Math.abs(Math.sqrt(Math.pow(playerObj.x - posX, 2) + Math.pow(playerObj.y - posY, 2)));
						Actuate.tween(playerObj, distance * MOVEMENT_SPEED, {x:posX, y:posY}).ease(Linear.easeNone);
					}
				}
				
				case "onBroadcastChat":
				{
					trace("onExtensionResponse: onBroadcastChat");
					
					playerObj = _players.get(e.data.params.playerId);
					if(playerObj != null) {
						var message:String = e.data.params.message;
						playerObj.chat(message);
					}
				}
				
			}
		}
	}
}
