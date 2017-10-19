package ui;
import openfl.text.TextField;
import openfl.text.TextFieldType;

/**
 * ...
 * @author hug
 */
class TextInput extends Label 
{
	
	public function new() 
	{
		super();
		
		_textField.selectable = true;
		_textField.type = TextFieldType.INPUT;
		_textField.border = true;
		_textField.borderColor = 0x000000;
		_textField.background = true;
		_textField.backgroundColor = 0xffffff;
		
		setColour(0x000000);
	}
	
	
	override public function dispose():Void
	{
		super.dispose();
	}
	
	
	public function setDisplayAsPassword(val:Bool):Void
	{
		if (_textField != null) {
			_textField.displayAsPassword = val;
		}
	}
	
}
