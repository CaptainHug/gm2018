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
	
	private var _panel:Image;
	private var _textInput:TextInput;
	private var _send:Button;
	
	
	public function new() 
	{
		super();
		
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;
		
		_panel = new Image(Assets.getBitmapData("img/ui/chat_panel.png"));
		addChild(_panel);
		
		_textInput = new TextInput(false);
		_textInput.x = 22;
		_textInput.y = 13;
		_textInput.setWidth(358);
		_textInput.setHeight(24);
		addChild(_textInput);
		
		_send = new Button(new Image(Assets.getBitmapData("img/ui/send_norm.png")), "", new Image(Assets.getBitmapData("img/ui/send_over.png")), new Image(Assets.getBitmapData("img/ui/send_over.png")));
		_send.addEventListener(Button.TRIGGERED, onClickSend);
		addChild(_send);
		
		_send.x = 398;
		_send.y = 9;
		
		_width = _panel.width;
		_height = _panel.height;
	}
	
	
	override public function dispose():Void
	{
		if (_panel != null) {
			_panel.dispose();
			_panel = null;
		}
		
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
