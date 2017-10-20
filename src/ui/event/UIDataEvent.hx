package ui.event;

import openfl.events.Event;

/**
 * ...
 * @author hug
 */
class UIDataEvent extends Event 
{
	public var data:Dynamic;
	
	
	public function new(type:String, bubbles:Bool=false, cancelable:Bool=false, data:Dynamic=null) 
	{
		super(type, bubbles, cancelable);
		
		this.data = data;
	}
	
}
