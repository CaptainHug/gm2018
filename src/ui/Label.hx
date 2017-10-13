package ui;
import openfl.text.TextField;

/**
 * ...
 * @author hug
 */
class Label extends UIElement 
{
	private var _textField:TextField;
	
	
	public function new() 
	{
		super();
		
		_textField = new TextField();
		_textField.embedFonts = true;
		_textField.defaultTextFormat = Resource.TFORM_DEFAULT;
		_textField.selectable = false;
		addChild(_textField);
	}
	
	
	override public function dispose():Void
	{
		if (_textField != null) {
			_textField = null;
		}
		
		super.dispose();
		
	}
	
	
	public function setText(text:String):Void
	{
		if (_textField != null) {
			_textField.text = text;
			layout();
		}
	}
	public function getText():String
	{
		if (_textField != null) {
			return _textField.text;
		}
		
		return null;
	}
	
	
	public function getTextField():TextField
	{
		return _textField;
	}
	
	
	override public function layout():Void
	{
		super.layout();
		
		if (_textField != null) {
			_textField.width = _width;
			_textField.height = _height;
		}
	}
}
