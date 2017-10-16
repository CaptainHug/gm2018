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
class Scale3Image extends Image 
{
	private var _part1:Bitmap;
	private var _part2:Bitmap;
	private var _part3:Bitmap;
	
	private var _leftArea:Float;
	private var _centerArea:Float;
	private var _rightArea:Float;
	
	
	public function new(bitmapData:BitmapData, leftArea:Float, centerArea:Float) 
	{
		super(bitmapData);
		
		_leftArea = leftArea;
		_centerArea = centerArea;
		
		if(_bitmap != null) {
			
			if (contains(_bitmap)) {
				removeChild(_bitmap);
			}
			
			_rightArea = _bitmap.width - centerArea - leftArea;
			
			// split up the image
			var bmd1:BitmapData = new BitmapData(Std.int(_leftArea), Std.int(_bitmap.height));
			bmd1.copyPixels(_bitmap.bitmapData, new Rectangle(0, 0, _leftArea, _bitmap.height), new Point(0, 0));
			_part1 = new Bitmap(bmd1, PixelSnapping.AUTO, true);
			_part1.x = 0;
			addChild(_part1);
			
			var bmd2:BitmapData = new BitmapData(Std.int(_centerArea), Std.int(_bitmap.height));
			bmd2.copyPixels(_bitmap.bitmapData, new Rectangle(_leftArea, 0, _leftArea, _bitmap.height), new Point(0, 0));
			_part2 = new Bitmap(bmd2, PixelSnapping.AUTO, true);
			_part2.x = _leftArea;
			addChild(_part2);
			
			var bmd3:BitmapData = new BitmapData(Std.int(_rightArea), Std.int(_bitmap.height));
			bmd3.copyPixels(_bitmap.bitmapData, new Rectangle(_leftArea + _centerArea, 0, _rightArea, _bitmap.height), new Point(0, 0));
			_part3 = new Bitmap(bmd3, PixelSnapping.AUTO, true);
			_part3.x = _leftArea + _centerArea;
			addChild(_part3);
		}
	}
	
	
	override public function dispose():Void
	{
		super.dispose();
		
		// dispose of the parts
		if (_part1 != null) {
			if (_part1.bitmapData != null) {
				_part1.bitmapData.dispose();
			}
			_part1 = null;
		}
		
		if (_part2 != null) {
			if (_part2.bitmapData != null) {
				_part2.bitmapData.dispose();
			}
			_part2 = null;
		}
		
		if (_part3 != null) {
			if (_part3.bitmapData != null) {
				_part3.bitmapData.dispose();
			}
			_part3 = null;
		}
	}
	
	
	override public function layout():Void
	{
		// resize/position elements
		var newCenterArea:Float = _width - (_leftArea + _rightArea);
		
		_part1.x = 0;
		_part1.width = _leftArea;
		_part2.x = _part1.x + _part1.width;
		_part2.width = newCenterArea;
		_part3.x = _part2.x + _part2.width;
		_part3.width = _rightArea;
		
		_part1.height = height;
		_part2.height = height;
		_part3.height = height;
	}
}
