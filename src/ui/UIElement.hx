package ui;

/**
 * ...
 * @author hug
 */
class UIElement extends Sprite 
{
	private var _width:Float;
	private var _height:Float;
	
	
	public function new() 
	{
		super();
		
		_width = 0;
		_height = 0;
	}
	
	
	override public function dispose():Void
	{
		super.dispose();
		
	}
	
	
	public function setWidth(val:Float):Void
	{
		_width = val;
		layout();
	}
	public function getWidth():Float
	{
		return _width;
	}
	
	
	public function setHeight(val:Float):Void
	{
		_height = val;
		layout();
	}
	public function getHeight():Float
	{
		return _height;
	}
	
	
	public function layout():Void
	{
		
	}
}
