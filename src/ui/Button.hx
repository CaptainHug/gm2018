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
	private var _currentSkin:UIElement;
	private var _upSkin:UIElement;
	private var _downSkin:UIElement;
	private var _hoverSkin:UIElement;
	private var _disabledSkin:UIElement;
	
	private var _label:Label;
	
	private var _state:String;
	
	
	public function new(upSkin:UIElement, label:String = "", downSkin:UIElement = null, hoverSkin:UIElement = null, disabledSkin:UIElement = null) 
	{
		super();
		
		_state = "";
		
		_skinContainer = new Sprite();
		addChild(_skinContainer);
		
		_upSkin = upSkin;
		_downSkin = downSkin;
		_hoverSkin = hoverSkin;
		_disabledSkin = disabledSkin;
		
		_label = new Label();
		_label.setText(label);
		addChild(_label);
		
		// set button mode / mouse children etc
		mouseEnabled = true;
		buttonMode = true;
		mouseChildren = false;
		
		// add event listeners
		addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		addEventListener(MouseEvent.CLICK, onMouseClick);
		addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		
		setState(STATE_UP);
		
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
		
		if (_skinContainer != null) {
			_skinContainer.dispose();
			_skinContainer = null;
		}
		
		if (_upSkin != null) {
			_upSkin.dispose();
			_upSkin = null;
		}
		
		if (_downSkin != null) {
			_downSkin.dispose();
			_downSkin = null;
		}
		
		if (_hoverSkin != null) {
			_hoverSkin.dispose();
			_hoverSkin = null;
		}
		
		if (_disabledSkin != null) {
			_disabledSkin.dispose();
			_disabledSkin = null;
		}
		
		if (_label != null) {
			_label.dispose();
			_label = null;
		}
		
		_state = null;
		_currentSkin = null;
		
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
		
		if (!_enabled) _state = STATE_DISABLED;
		
		_state = state;
		
		trace("Button: setState - " + state);
		
		switch(_state) {
			case STATE_UP:
				if (_upSkin != null) {
					_skinContainer.removeChildren();
					_skinContainer.addChild(_upSkin);
					_currentSkin = _upSkin;
				}
				
			case STATE_DOWN:
				if (_downSkin != null) {
					_skinContainer.removeChildren();
					_skinContainer.addChild(_downSkin);
					_currentSkin = _downSkin;
				}
			
			case STATE_HOVER:
				if (_hoverSkin != null) {
					_skinContainer.removeChildren();
					_skinContainer.addChild(_hoverSkin);
					_currentSkin = _hoverSkin;
				}
			
			case STATE_DISABLED:
				if (_disabledSkin != null) {
					_skinContainer.removeChildren();
					_skinContainer.addChild(_disabledSkin);
					_currentSkin = _disabledSkin;
				}
		}
		
		// TODO: only trigger if something changed
		layout();
	}
	public function getState():String
	{
		return _state;
	}
	
	
	// layout function to be called when properties change
	override public function layout():Void
	{
		super.layout();
		
		if (_currentSkin != null) {
			_currentSkin.setWidth(_width);
			_currentSkin.setHeight(_height);
		}
		
		if (_label != null) {
			_label.setWidth(_width);
			_label.setHeight(_height);
		}
	}
	
	
	override public function setEnabled(val:Bool):Void
	{
		super.setEnabled(val);
		
		if (_enabled) {
			setState(STATE_UP);
			
			mouseEnabled = true;
			buttonMode = true;
		}
		else {
			setState(STATE_DISABLED);
			
			mouseEnabled = false;
			buttonMode = false;
		}
	}
	
	
	// TODO: event handlers
	private function onMouseOver(e:MouseEvent):Void
	{
		if (!_enabled) return;
		
		setState(STATE_HOVER);
	}
	
	
	private function onMouseOut(e:MouseEvent):Void
	{
		if (!_enabled) return;
		
		setState(STATE_UP);
	}
	
	
	private function onMouseClick(e:MouseEvent):Void
	{
		if (!_enabled) return;
		
		setState(STATE_UP);
		
		dispatchEvent(new Event(TRIGGERED));
	}
	
	
	private function onMouseDown(e:MouseEvent):Void
	{
		if (!_enabled) return;
		
		setState(STATE_DOWN);
	}
	
	
	private function onMouseUp(e:MouseEvent):Void
	{
		if (!_enabled) return;
		
		setState(STATE_UP);
	}
	
}
