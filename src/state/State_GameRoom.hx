package state;
import game.objects.Player;
import haxe.Json;
import motion.Actuate;
import network.GameServer;
import network.event.GameServerEvent;
import openfl.Lib;
import openfl.events.MouseEvent;
import ui.ChatPanel;
import ui.Sprite;
import ui.event.UIDataEvent;

/**
 * ...
 * @author hug
 */
class State_GameRoom extends BaseState 
{
	private var _server:GameServer;
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
		
		_playArea = new Sprite();
		_playArea.graphics.beginFill(0xff00ff);
		_playArea.graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight * 0.84);
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
		_chatPanel.y = Lib.current.stage.stageHeight * 0.84;
	}
	
	
	override public function dispose():Void
	{
		trace("State_GameRoom: dispose");
		
		removeEventListener(MouseEvent.CLICK, onClick);
		
		if (_server != null) {
			_server.removeEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
		}
		
		// TODO: cleanup self
		// TODO: cleanup players
		// TODO: cleanup playArea
		
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
		
		Actuate.tween(_self, 2, {x:posX, y:posY});
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
		
		if (e.data) {
			switch(e.data.cmd) {
				
				case "onJoinRoom":
				{
					trace("onExtensionResponse: onJoinRoom");
					
					var player:Dynamic = Json.parse(e.data.params.player);
					_self.setName(player.name);
				}
				
				case "onBroadcastJoinRoom":
				{
					trace("onExtensionResponse: onBroadcastJoinRoom");
				}
				
				case "onBroadcastMove":
				{
					trace("onExtensionResponse: onBroadcastMove");
				}
				
				case "onBroadcastChat":
				{
					trace("onExtensionResponse: onBroadcastChat");
				}
				
			}
		}
	}
}
