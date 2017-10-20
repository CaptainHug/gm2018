package ui;
import openfl.Assets;
import openfl.Lib;
import openfl.events.Event;
import ui.event.UIDataEvent;

/**
 * ...
 * @author hug
 */
class ChatPanel extends UIElement 
{
	// events
	inline public static var MESSAGE_SENT:String = "onMessageSent";
	
	private var _textInput:TextInput;
	private var _send:Button;
	
	
	public function new() 
	{
		super();
		
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		_textInput = new TextInput();
		_textInput.setWidth(stageWidth * 0.8);
		_textInput.setHeight(stageHeight * 0.16);
		addChild(_textInput);
		
		_send = new Button(new Image(Assets.getBitmapData("img/ui/button_up.png")), "Send");
		_send.setWidth(stageWidth * 0.2);
		_send.setHeight(stageHeight * 0.16);
		_send.x = stageWidth - _send.getWidth();
		_send.addEventListener(Button.TRIGGERED, onClickSend);
		addChild(_send);
	}
	
	
	override public function dispose():Void
	{
		if (_textInput != null) {
			_textInput.dispose();
			_textInput = null;
		}
		
		if (_send != null) {
			_send.removeEventListener(Button.TRIGGERED, onClickSend);
			_send.dispose();
			_send = null;
		}
		
		super.dispose();
	}
	
	
	private function onClickSend(e:Event):Void
	{
		var message:String = "";
		message = _textInput.getText();
		
		// TODO: validate message
		
		if (message != null && message.length > 0) {
			// clear UI
			_textInput.setText("");
			dispatchEvent(new UIDataEvent(MESSAGE_SENT, false, false, {message:message}));
		}
	}
}
