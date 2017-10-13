package ui;
import openfl.events.Event;
import openfl.events.MouseEvent;

/**
 * ...
 * @author hug
 */
class Button extends UIElement 
{
	// events
	inline public static var TRIGGERED:String = "onTriggered";
	
	// states
	inline public static var STATE_UP:String = "up";
	inline public static var STATE_DOWN:String = "down";
	inline public static var STATE_HOVER:String = "hover";
	inline public static var STATE_DISABLED:String = "disabled";
	
	private var _skinContainer:Sprite;
	private var _upSkin:UIElement;
	private var _downSkin:UIElement;
	private var _hoverSkin:UIElement;
	private var _disabledSkin:UIElement;
	
	private var _label:Label;
	
	private var _state:String;
	
	
	public var enabled:Bool;
	
	
	public function new() 
	{
		super();
		
		_state = STATE_UP;
		
		_skinContainer = new Sprite();
		addChild(_skinContainer);
		
		_label = new Label();
		addChild(_label);
		
		// set button mode / mouse children etc
		mouseEnabled = true;
		buttonMode = true;
		mouseChildren = false;
		
		enabled = true;
		
		// add event listeners
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		addEventListener(MouseEvent.CLICK, onMouseClick);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		layout();
	}
	
	
	override public function dispose():Void
	{
		// remove event listeners
		removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		removeEventListener(MouseEvent.CLICK, onMouseClick);
		removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		// TODO: clean up skins
		
		if (_skinContainer != null) {
			_skinContainer.dispose();
			_skinContainer = null;
		}
		
		if (_label != null) {
			_label.dispose();
			_label = null;
		}
		
		_state = null;
		
		super.dispose();
		
	}
	
	
	// set / get label text
	public function setLabel(text:String):Void
	{
		if (_label != null) {
			_label.setText(text);
			layout();
		}
	}
	public function getLabel():String
	{
		if (_label != null) {
			return _label.getText();
		}
		
		return null;
	}
	
	// TODO: set / get skins
	
	// state
	public function setState(state:String):Void
	{
		if (_state == state) return;
		
		if (_skinContainer == null) return;
		
		if (!enabled) _state = STATE_DISABLED;
		
		_state = state;
		
		trace("Button: setState - " + state);
		
		switch(_state) {
			case STATE_UP:
				if (_upSkin != null) {
					_skinContainer.removeChildren();
					_skinContainer.addChild(_upSkin);
				}
				
			case STATE_DOWN:
				if (_downSkin != null) {
					_skinContainer.removeChildren();
					_skinContainer.addChild(_downSkin);
				}
			
			case STATE_HOVER:
				if (_hoverSkin != null) {
					_skinContainer.removeChildren();
					_skinContainer.addChild(_hoverSkin);
				}
			
			case STATE_DISABLED:
				if (_disabledSkin != null) {
					_skinContainer.removeChildren();
					_skinContainer.addChild(_disabledSkin);
				}
		}
	}
	public function getState():String
	{
		return _state;
	}
	
	
	// layout function to be called when properties change
	override public function layout():Void
	{
		super.layout();
		
		if (_skinContainer != null) {
			_skinContainer.graphics.beginFill(0xffff00);
			_skinContainer.graphics.drawRect(0, 0, _width, _height);
			_skinContainer.graphics.endFill();
		}
		
		if (_label != null) {
			_label.setWidth(_width);
			_label.setHeight(_height);
		}
	}
	
	
	// TODO: event handlers
	private function onMouseOver(e:MouseEvent):Void
	{
		setState(STATE_HOVER);
	}
	
	
	private function onMouseOut(e:MouseEvent):Void
	{
		setState(STATE_UP);
	}
	
	
	private function onMouseClick(e:MouseEvent):Void
	{
		setState(STATE_UP);
		
		dispatchEvent(new Event(TRIGGERED));
	}
	
	
	private function onMouseDown(e:MouseEvent):Void
	{
		setState(STATE_DOWN);
	}
	
	
	private function onMouseUp(e:MouseEvent):Void
	{
		setState(STATE_UP);
	}
	
}
