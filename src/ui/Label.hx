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
		_textField.width = 300;
		_textField.height = 100;
		_textField.selectable = false;
		_textField.text = "BALLBAGS";
		addChild(_textField);
	}
	
	
	override public function dispose():Void
	{
		if (_textField != null) {
			_textField = null;
		}
		
		super.dispose();
		
	}
}
