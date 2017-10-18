package state;
import haxe.Json;
import network.GameServer;
import network.GameServerEvent;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.events.MouseEvent;

/**
 * ...
 * @author hug
 */
class State_GameRoom extends BaseState 
{
	private var _server:GameServer;
	
	
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
		
		
		graphics.beginFill(0xff00ff);
		graphics.drawRect(0, 0, Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
		graphics.endFill();
		mouseEnabled = true;
		mouseChildren = false;
		addEventListener(MouseEvent.CLICK, onClick);
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
	}
	
	
	override public function dispose():Void
	{
		trace("State_GameRoom: dispose");
		
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		removeEventListener(MouseEvent.CLICK, onClick);
		
		if (_server != null) {
			_server.removeEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
		}
		
		super.dispose();
		
	}
	
	
	private function onClick(e:MouseEvent):Void
	{
		var posX:Int = cast(e.stageX, Int);
		var posY:Int = cast(e.stageY, Int);
		
		_server.sendExtMessage("game", "move", {posX:posX, posY:posY});
	}
	
	
	private function onKeyDown(e:KeyboardEvent):Void
	{
		_server.sendExtMessage("game", "chat", {message:e.keyCode});
	}
	
	
	private function onExtensionResponse(e:GameServerEvent):Void
	{
		trace("onExtensionResponse: " + Json.stringify(e.data));
		
		if (e.data) {
			switch(e.data.cmd) {
				case "onJoinRoom":
				{
					trace("onExtensionResponse: onJoinRoom");
					
					/*
					if (e.data.params) {
						trace("login success: " + e.data.params.name);
						
						Kernel.getInstance().getStateManager().switchState(new State_GameRoom());
					}
					*/
				}
				case "onMove":
				{
					trace("onExtensionResponse: onMove");
				}
				case "onChat":
				{
					trace("onExtensionResponse: onChat");
				}
			}
		}
	}
}
