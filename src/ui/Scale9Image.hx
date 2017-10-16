package ui;
import openfl.display.BitmapData;
import openfl.geom.Rectangle;
import ui.Image;

/**
 * ...
 * @author hug
 */
class Scale9Image extends Image 
{

	public function new(bitmapData:BitmapData, scale9Rect:Rectangle) 
	{
		super(bitmapData);
		
		removeChild(_bitmap);
		
		// TODO: split up the image
	}
	
	
	override public function dispose():Void
	{
		super.dispose();
		
	}
	
	
	override public function setWidth(val:Float):Void
	{
		super.setWidth(val);
		
		// TODO: resize/position elements
	}
	
	override public function setHeight(val:Float):Void
	{
		super.setHeight(val);
		
		// TODO: resize/position elements
	}
}
