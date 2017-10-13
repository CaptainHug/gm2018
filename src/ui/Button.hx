package ui;
import openfl.events.MouseEvent;

/**
 * ...
 * @author hug
 */
class Button extends UIElement 
{
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
	
	
	public function new() 
	{
		super();
		
		_state = STATE_UP;
		
		_skinContainer = new Sprite();
		_skinContainer.graphics.beginFill(0xffff00);
		_skinContainer.graphics.drawRect(0, 0, 400, 100);
		_skinContainer.graphics.endFill();
		addChild(_skinContainer);
		
		_label = new Label();
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
	
	
	// TODO: set / get label text
	
	// TODO: set / get dimensions
	
	// TODO: set / get skins
	
	
	// TODO: event handlers
	private function onMouseOver(e:MouseEvent):Void
	{
		trace("onMouseOver");
	}
	
	
	private function onMouseOut(e:MouseEvent):Void
	{
		trace("onMouseOut");
	}
	
	
	private function onMouseClick(e:MouseEvent):Void
	{
		trace("onMouseClick");
	}
	
	
	private function onMouseDown(e:MouseEvent):Void
	{
		trace("onMouseDown");
	}
	
	
	private function onMouseUp(e:MouseEvent):Void
	{
		trace("onMouseUp");
	}
	
}
