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
	
}
