package ui.data;

/**
 * ...
 * @author hug
 */
class AnimationState 
{
	private var _frames:Array<String>;
	private var _speed:Float;
	private var _loop:Bool;
	
	
	public function new(frames:Array<String>, speed:Float, loop:Bool) 
	{
		_frames = frames;
		_speed = speed;
		_loop = loop;
	}
	
	
	public function setSpeed(speed:Float):Void
	{
		_speed = speed;
	}
	public function getSpeed():Float
	{
		return _speed;
	}
	
	
	public function setLoop(loop:Bool):Void
	{
		_loop = loop;
	}
	public function getLoop():Bool
	{
		return _loop;
	}
	
	
	public function getFrameCount():Int
	{
		return _frames.length;
	}
	public function getFrameAt(idx:Int):String
	{
		idx %= getFrameCount();
		return _frames[idx];
	}
}
