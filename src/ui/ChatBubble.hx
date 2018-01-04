package ui;
import motion.Actuate;
import openfl.Assets;
import openfl.geom.Rectangle;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author hug
 */
class ChatBubble extends UIElement 
{
	private var _bubble:Scale9Image;
	private var _text:Label;
	private var _delayedCall:Dynamic;
	
	
	public function new() 
	{
		super();
		
		_bubble = new Scale9Image(Assets.getBitmapData("img/ui/speech_bubble.png"), new Rectangle(26, 23, 126, 57));
		addChild(_bubble);
		
		_text = new Label();
		_text.setColour(0x000000);
		_text.setWordWrap(true);
		_text.setAlign(TextFormatAlign.CENTER);
		_text.setVerticalAlign(Label.ALIGN_CENTER);
		addChild(_text);
		
		// position
		_bubble.x = -_bubble.width / 2;
		_bubble.y = -_bubble.height;
		
		_text.x = _bubble.x + 15;
		_text.y = _bubble.y + 11;
		_text.setWidth(149);
		_text.setHeight(78);
		
		visible = false;
	}
	
	
	override public function dispose():Void
	{
		clearDelayedCall();
		
		if (_bubble != null) {
			_bubble.dispose();
			_bubble = null;
		}
		
		if (_text != null) {
			_text.dispose();
			_text = null;
		}
		
		super.dispose();
	}
	
	
	public function showMessage(message:String):Void
	{
		clearDelayedCall();
		
		_text.setText(message);
		
		// TODO: resize bubble
		
		visible = true;
		
		// remove after 5 seconds
		_delayedCall = Actuate.timer(5).onComplete(hideMessage);
	}
	
	
	public function hideMessage():Void
	{
		_text.setText("");
		visible = false;
	}
	
	
	private function clearDelayedCall():Void
	{
		// kill delayed calls to hide current message
		if (_delayedCall != null) {
			Actuate.stop(_delayedCall, null, false, false);
			_delayedCall = null;
		}
	}
}
