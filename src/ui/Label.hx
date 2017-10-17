package ui;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author hug
 */
class Label extends UIElement 
{
	// const
	inline public static var ALIGN_TOP:String = "top";
	inline public static var ALIGN_CENTER:String = "center";
	inline public static var ALIGN_BOTTOM:String = "bottom";
	
	private var _textField:TextField;
	private var _textFormat:TextFormat;
	
	private var _fontName:String;
	private var _size:Int;
	private var _colour:Int;
	private var _bold:Bool;
	private var _italic:Bool;
	private var _align:TextFormatAlign;
	private var _verticalAlign:String;
	
	
	public function new() 
	{
		super();
		
		_fontName = Resource.FONT_DEFAULT;
		_size = 14;
		_colour = 0xffffff;
		_bold = false;
		_italic = false;
		_align = TextFormatAlign.LEFT;
		_verticalAlign = ALIGN_TOP;
		
		_textField = new TextField();
		_textField.embedFonts = true;
		_textField.selectable = false;
		addChild(_textField);
		
		setupTextFormat();
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
	
	
	public function setFontName(fontName:String):Void
	{
		_fontName = fontName;
		setupTextFormat();
	}
	public function getFontName():String
	{
		return _fontName;
	}
	
	public function setSize(size:Int):Void
	{
		_size = size;
		setupTextFormat();
	}
	public function getSize():Int
	{
		return _size;
	}
	
	public function setColour(colour:Int):Void
	{
		_colour = colour;
		setupTextFormat();
	}
	public function getColour():Int
	{
		return _colour;
	}
	
	public function setBold(val:Bool):Void
	{
		_bold = val;
		setupTextFormat();
	}
	public function getBold():Bool
	{
		return _bold;
	}
	
	public function setItalic(val:Bool):Void
	{
		_italic = val;
		setupTextFormat();
	}
	public function getItalic():Bool
	{
		return _italic;
	}
	
	public function setAlign(align:TextFormatAlign):Void
	{
		_align = align;
		setupTextFormat();
	}
	public function getAlign():TextFormatAlign
	{
		return _align;
	}
	
	public function setVerticalAlign(verticalAlign:String):Void
	{
		_verticalAlign = verticalAlign;
		layout();
	}
	public function getVerticalAlign():String
	{
		return _verticalAlign;
	}
	
	public function setWordWrap(val:Bool):Void
	{
		if (_textField != null) {
			_textField.wordWrap = val;
		}
	}
	public function getWordWrap():Bool
	{
		if (_textField != null) {
			return _textField.wordWrap;
		}
		else return false;
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
			
			switch(_verticalAlign) {
				case ALIGN_TOP:
				{
					_textField.y = 0;
				}
				case ALIGN_CENTER:
				{
					_textField.y = (_height - _textField.textHeight) / 2;
				}
				case ALIGN_BOTTOM:
				{
					_textField.y = _height - _textField.textHeight;
				}
			}
		}
	}
	
	
	private function setupTextFormat():Void
	{
		if (_textFormat == null) {
			_textFormat = new TextFormat(_fontName, _size, _colour, _bold, _italic, null, null, null, _align);
		}
		else {
			_textFormat.font = _fontName;
			_textFormat.size = _size;
			_textFormat.color = _colour;
			_textFormat.bold = _bold;
			_textFormat.italic = _italic;
			_textFormat.align = _align;
		}
		
		if(_textField != null) {
			_textField.defaultTextFormat = _textFormat;
			_textField.setTextFormat(_textFormat);
		}
		
		layout();
	}
}
