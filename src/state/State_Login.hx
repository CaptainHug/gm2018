package state;
import haxe.Json;
import network.GameServer;
import network.GameServerEvent;

/**
 * ...
 * @author hug
 */
class State_Login extends BaseState 
{
	private var _server:GameServer;
	
	
	public function new() 
	{
		super();
		
	}
	
	
	override public function init():Void
	{
		super.init();
		
		trace("State_Login");
		
		_server = Kernel.getInstance().getGameServer();
		_server.addEventListener(GameServerEvent.onConnection, onConnection);
		_server.addEventListener(GameServerEvent.onConnectionLost, onConnectionLost);
		_server.addEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
		_server.connect(Config.SERVER_HOST, Config.SERVER_PORT);
	}
	
	
	override public function dispose():Void
	{
		if (_server != null) {
			_server.removeEventListener(GameServerEvent.onConnection, onConnection);
			_server.removeEventListener(GameServerEvent.onConnectionLost, onConnectionLost);
			_server.removeEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
			_server = null;
		}
		
		super.dispose();
		
	}
	
	
	private function onConnection(e:GameServerEvent):Void
	{
		trace("onConnection");
		
		_server.sendExtMessage("lobby", "signup", { name:"cramwell", password:"ballbags" } );
		
		trace("boom");
	}
	
	
	private function onExtensionResponse(e:GameServerEvent):Void
	{
		trace("onExtensionResponse: " + Json.stringify(e.data));
		
		if (e.data) {
			switch(e.data.cmd) {
				case "loginOK":
				{
					if (e.data.params) {
						trace("login success: " + e.data.params.name);
						
						Kernel.getInstance().getStateManager().switchState(new State_GameRoom());
					}
				}
			}
		}
	}
	
	
	private function onConnectionLost(e:GameServerEvent):Void
	{
		trace("onConnectionLost");
	}
}
