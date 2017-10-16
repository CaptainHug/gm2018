package ui;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.PixelSnapping;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import ui.Image;

/**
 * ...
 * @author hug
 */
class Scale9Image extends Image 
{
	private var _parts:Array<Array<Bitmap>>;
	private var _scale9Rect:Rectangle;
	
	
	public function new(bitmapData:BitmapData, scale9Rect:Rectangle) 
	{
		super(bitmapData);
		
		_scale9Rect = scale9Rect;
		
		_parts = new Array<Array<Bitmap>>();
		
		if (_bitmap != null) {
			if(contains(_bitmap)) {
				removeChild(_bitmap);
			}
			
			// split up the image
			var i, j, idx:Int;
			var bmd:BitmapData;
			
			_width = _bitmap.width;
			_height = _bitmap.height;
			
			var cols:Array<Float> = [0, _scale9Rect.left, _scale9Rect.right, _bitmap.width];
			var rows:Array<Float> = [0, _scale9Rect.top, _scale9Rect.bottom, _bitmap.height];
			
			for (i in 0...3) {
				_parts[i] = new Array<Bitmap>();
				for(j in 0...3) {
					bmd = new BitmapData(Std.int(cols[j + 1] - cols[j]), Std.int(rows[i + 1] - rows[i]));
					bmd.copyPixels(_bitmap.bitmapData, new Rectangle(cols[j], rows[i], bmd.width, bmd.height), new Point(0, 0));
					_parts[i][j] = new Bitmap(bmd, PixelSnapping.AUTO, true);
					_parts[i][j].x = cols[j];
					_parts[i][j].y = rows[i];
					addChild(_parts[i][j]);
				}
			}
		}
	}
	
	
	override public function dispose():Void
	{
		// cleanup _parts and bitmapdata
		for (i in 0...3) {
			for (j in 0...3) {
				if (_parts[i][j] != null) {
					_parts[i][j].bitmapData.dispose();
					_parts[i][j] = null;
				}
			}
			_parts[i] = null;
		}
		_parts = null;
		
		super.dispose();
		
	}
	
	
	override public function layout():Void
	{
		super.layout();
		
		var newWidth:Float = _width;
		var newHeight:Float = _height;
		
		var useAltScale:Bool = false;
		if (_width < _bitmap.width) {
			newWidth = _bitmap.width;
			useAltScale = true;
		}
		if (_height < _bitmap.height) {
			newHeight = _bitmap.height;
			useAltScale = true;
		}
		
		// layout based on current dimensions
		var cols:Array<Float> = [0, _scale9Rect.left, newWidth - _scale9Rect.right, newWidth];
		var rows:Array<Float> = [0, _scale9Rect.top, newHeight - _scale9Rect.bottom, newHeight];
		
		for (i in 0...3) {
			for(j in 0...3) {
				_parts[i][j].x = cols[j];
				_parts[i][j].y = rows[i];
				_parts[i][j].width = cols[j+1] - cols[j];
				_parts[i][j].height = rows[i+1] - rows[i];
			}
		}
		
		if (useAltScale) {
			width = _width;
			height = _height;
		}
	}
}
