package game.objects;
import openfl.Assets;
import openfl.filters.BitmapFilterQuality;
import openfl.filters.GlowFilter;
import openfl.text.TextFormatAlign;
import ui.ChatBubble;
import ui.Image;
import ui.Label;

/**
 * ...
 * @author hug
 */
class Player extends Entity 
{
	private var _avatar:Image;
	private var _name:Label;
	private var _chat:ChatBubble;
	
	
	public function new() 
	{
		super();
		
		// TODO: allow this to be set / swapped
		_avatar = new Image(Assets.getBitmapData("img/avatars/1.png"));
		_avatar.x = -_avatar.width / 2;
		_avatar.y = -_avatar.height;
		addChild(_avatar);
		
		_name = new Label();
		_name.setAlign(TextFormatAlign.CENTER);
		_name.setVerticalAlign(Label.ALIGN_CENTER);
		_name.filters = [new GlowFilter(0x000000, 1, 6, 6, 6, BitmapFilterQuality.LOW)];
		addChild(_name);
		
		_chat = new ChatBubble();
		addChild(_chat);
		
		// position/size elements
		// TODO: move to Layout
		_name.setWidth(_avatar.width * 2);
		_name.setHeight(22);
		
		_name.x = _avatar.x + ((_avatar.width - _name.getWidth()) / 2);
		_name.y = _avatar.y + _avatar.height;
		
		_chat.x = _avatar.x + (_avatar.width / 2);
		_chat.y = _avatar.y;
	}
	
	
	override public function dispose():Void
	{
		super.dispose();
		
		if (_name != null) {
			_name.dispose();
			_name = null;
		}
		
		if (_avatar != null) {
			_avatar.dispose();
			_avatar = null;
		}
		
		if (_chat != null) {
			_chat.dispose();
			_chat = null;
		}
	}
	
	
	public function setName(name:String):Void
	{
		_name.setText(name);
	}
	public function getName():String
	{
		return _name.getText();
	}
	
	
	public function setAvatar(avatar:Image):Void
	{
		// TODO: reset the avatar image
	}
	
	
	public function chat(message:String):Void
	{
		_chat.showMessage(message);
	}
	
}
