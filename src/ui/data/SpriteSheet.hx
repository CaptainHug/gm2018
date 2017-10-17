package ui.data;
import flash.display.BitmapData;
import haxe.Json;
import openfl.geom.Point;
import openfl.geom.Rectangle;

/**
 * ...
 * @author hug
 */
class SpriteSheet 
{
	private var _frames:Map<String, BitmapData>;
	
	
	public function new(data:String, bitmapData:BitmapData) 
	{
		if (data == null || bitmapData == null) return;
		
		_frames = new Map<String, BitmapData>();
		
		var tpData:Dynamic = Json.parse(data);
		if (tpData != null && tpData.frames != null && tpData.frames.length > 0) {
			
			var i:Int;
			var frame:Dynamic;
			
			for (i in 0...tpData.frames.length) {
				
				frame = tpData.frames[i];
				var filename:String = frame.filename;
				if (StringTools.endsWith(filename.toLowerCase(), ".png")) {
					filename = filename.substring(0, filename.length - 4);
				}
				
				var bmd:BitmapData = new BitmapData(frame.sourceSize.w, frame.sourceSize.h, true, 0x00000000);
				bmd.copyPixels(bitmapData, new Rectangle(frame.frame.x, frame.frame.y, frame.frame.w, frame.frame.h), new Point(frame.spriteSourceSize.x, frame.spriteSourceSize.y));
				_frames.set(filename, bmd);
			}
		}
	}
	
	
	public function dispose():Void
	{
		// clean up all the bitmap data
		if (_frames != null) {
			
			var key:String;
			var bmd:BitmapData;
			
			for (key in _frames.keys()) {
				bmd = _frames.get(key);
				if (bmd != null) {
					bmd.dispose();
					bmd = null;
				}
				_frames.remove(key);
			}
		}
		
		_frames = null;
	}
	
	
	public function getBitmapData(id:String):BitmapData
	{
		if (_frames != null && _frames.exists(id)) {
			return _frames.get(id);
		}
		else return null;
	}
	
}
