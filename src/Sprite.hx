package;

import openfl.display.Sprite;

/**
 * ...
 * @author hug
 */
class Sprite extends openfl.display.Sprite 
{

	public function new() 
	{
		super();
		
		trace("Sprite: new");
	}
	
	
	public function dispose():Void
	{
		trace("Sprite: dispose");
		removeChildren();
	}
	
}
