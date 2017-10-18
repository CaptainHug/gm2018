package state;
import haxe.Json;
import network.GameServer;
import network.GameServerEvent;

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
		
		trace("State_GameRoom");
		
		_server = Kernel.getInstance().getGameServer();
		_server.addEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
	}
	
	
	override public function dispose():Void
	{
		if (_server != null) {
			_server.removeEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
		}
		
		super.dispose();
		
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
