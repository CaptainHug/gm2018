package ui.data;

import openfl.display.Bitmap;
import openfl.display.PixelSnapping;
import openfl.events.Event;
import ui.Sprite;

/**
 * ...
 * @author hug
 */
class AnimatedSprite extends Sprite 
{
	private var _spriteSheet:SpriteSheet;
	private var _states:Map<String, AnimationState>;
	private var _currentStateName:String;
	private var _currentState:AnimationState;
	private var _currentFrame:Int;
	private var _frame:Bitmap;
	private var _lastFrameTime:Float;
	private var _isPlaying:Bool;
	
	
	public function new(spriteSheet:SpriteSheet) 
	{
		super();
		
		_spriteSheet = spriteSheet;
		_states = new Map<String, AnimationState>();
		_currentStateName = "";
		_currentState = null;
		_currentFrame = 0;
		_lastFrameTime = 0;
		_isPlaying = false;
		
		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}
	
	
	override public function dispose():Void
	{
		removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		
		// TODO: cleanup
		
		super.dispose();
	}
	
	
	public function addState(name:String, animState:AnimationState):Void
	{
		if(_states != null) {
			_states.set(name, animState);
			if (_currentStateName == null || _currentStateName == "") {
				setState(name);
			}
		}
	}
	
	
	public function play():Void
	{
		_isPlaying = true;
	}
	
	
	public function stop():Void
	{
		_isPlaying = false;
	}
	
	
	public function setState(name:String):Void
	{
		if (_currentStateName == name) return;
		
		// TODO: switch playing state
		
		if (_states.exists(name)) {
			
			_currentStateName = name;
			_currentState = _states.get(_currentStateName);
			_currentFrame = 0;
			
			setupCurrentFrame();
		}
		
	}
	
	
	private function onEnterFrame(e:Event):Void
	{
		if (!_isPlaying) return;
		
		// TODO: switch current AnimationState frame if necessary
		
		if (_currentState != null) {
			
			if (!_currentState.getLoop() && _currentFrame >= _currentState.getFrameCount()) return;
			
			var currentTime:Float = Date.now().getTime();
			if((currentTime - _lastFrameTime) > ((1 / _currentState.getSpeed()) * 1000)) {
				
				_currentFrame++;
				
				setupCurrentFrame();
				
				_lastFrameTime = currentTime;
			}
		}
	}
	
	
	private function setupCurrentFrame()
	{
		// TODO: optimise
		
		if (_spriteSheet == null || _currentState == null) return;
		
		if (_frame != null && contains(_frame)) {
			removeChild(_frame);
			_frame = null;
		}
		
		_frame = new Bitmap(_spriteSheet.getBitmapData(_currentState.getFrameAt(_currentFrame)), PixelSnapping.AUTO, true);
		addChild(_frame);
	}
}
