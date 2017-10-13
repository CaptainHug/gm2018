package ui;

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
		
	}
	
	
	public function dispose():Void
	{
		removeChildren();
	}
	
}
