package network;

import com.gemioli.io.Socket;
import com.gemioli.io.events.SocketEvent;
import haxe.Json;
import openfl.events.EventDispatcher;
import openfl.events.IEventDispatcher;

/**
 * ...
 * @author hug
 */
class GameServer extends EventDispatcher 
{
	// states
	inline public static var STATE_DISCONNECTED:String = "disconnected";
	inline public static var STATE_CONNECTING:String = "connecting";
	inline public static var STATE_CONNECTED:String = "connected";
	
	private var _socket:Socket;
	private var _state:String;
	private var _clientId:String;
	
	
	public function new() 
	{
		super(null);
		
		_socket = null;
		_state = STATE_DISCONNECTED;
	}
	
	
	// public api
	public function connect(host:String, port:Int):Void
	{
		if (_state != STATE_DISCONNECTED) return;
		if (_socket != null) return;
		
		_state = STATE_CONNECTING;
		
		_socket = new Socket("http://" + host + ":" + port);
		
		// TODO: SocketEvent.CONNECTING
		_socket.addEventListener(SocketEvent.CONNECT, onConnect);
		// TODO: SocketEvent.CONNECT_FAILED
		// TODO: SocketEvent.DISCONNECTING
		// TODO: SocketEvent.DISCONNECT
		_socket.addEventListener(SocketEvent.ERROR, onError);
		_socket.addEventListener(SocketEvent.MESSAGE, onMessage);
		// TODO: SocketEvent.RECONNECTING
		// TODO: SocketEvent.RECONNECT
		// TODO: SocketEvent.RECONNECT_FAILED
		
		_socket.connect();
	}
	
	
	public function disconnect():Void
	{
		if (_state != STATE_CONNECTED) return;
		
		if (_socket != null) {
			// disconnect from server
			_socket.disconnect();
			
			// remove listeners
			_socket.removeEventListener(SocketEvent.CONNECT, onConnect);
			_socket.removeEventListener(SocketEvent.ERROR, onError);
			_socket.removeEventListener(SocketEvent.MESSAGE, onMessage);
			
			// clean up socket
			_socket = null;
		}
		
		// change state and notify
		_state = STATE_DISCONNECTED;
		dispatchEvent(new GameServerEvent(GameServerEvent.onConnectionLost));
	}
	
	
	public function sendExtMessage(handler:String, cmd:String, params:Dynamic):Void
	{
		if (_state != STATE_CONNECTED) return;
		if (_socket == null) return;
		
		_socket.emit("message", { handler:handler, cmd:cmd, params:params } );
	}
	
	
	// event handlers
	private function onConnect(e:SocketEvent):Void 
	{
		if (_state == STATE_CONNECTED) return;
		
		// change state and notify
		_state = STATE_CONNECTED;
		dispatchEvent(new GameServerEvent(GameServerEvent.onConnection));
	}
	
	
	private function onMessage(e:SocketEvent):Void 
	{
		if (_state != STATE_CONNECTED) return;
		
		if (e != null && e.args != null) {
			dispatchEvent(new GameServerEvent(GameServerEvent.onExtensionResponse, false, false, e.args[0]));
		}
	}
	
	
	private function onError(e:SocketEvent):Void 
	{
		trace("GameServer: onError - " + Json.stringify(e.args));
	}
	
}
