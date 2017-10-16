package ui;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.PixelSnapping;

/**
 * ...
 * @author hug
 */
class Image extends UIElement 
{
	private var _bitmap:Bitmap;
	
	
	public function new(bitmapData:BitmapData) 
	{
		super();
		
		_bitmap = new Bitmap(bitmapData, PixelSnapping.AUTO, true);
		addChild(_bitmap);
		
		// TODO: set width and height properties to image size
	}
	
	
	override public function dispose():Void
	{
		if(_bitmap != null) {
			_bitmap = null;
		}
		
		super.dispose();
		
	}
	
	
	override public function setWidth(val:Float):Void
	{
		super.setWidth(val);
		width = _width;
	}
	
	override public function setHeight(val:Float):Void
	{
		super.setHeight(val);
		height = _height;
	}
}
