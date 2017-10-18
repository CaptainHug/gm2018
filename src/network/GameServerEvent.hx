package network;

import openfl.events.Event;

/**
 * ...
 * @author hug
 */
class GameServerEvent extends Event 
{
	// events
	inline public static var onConnection:String = "onConnection";
	inline public static var onConnectionLost:String = "onConnectionLost";
	inline public static var onExtensionResponse:String = "onExtensionResponse";
	
	public var data:Dynamic;
	
	
	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false, data:Dynamic=null) 
	{
		super(type, bubbles, cancelable);
		
		this.data = data;
	}
	
}
