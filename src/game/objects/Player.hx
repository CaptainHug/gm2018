package game.objects;
import openfl.Assets;
import openfl.text.TextFormatAlign;
import ui.Image;
import ui.Label;

/**
 * ...
 * @author hug
 */
class Player extends Entity 
{
	private var _name:Label;
	private var _avatar:Image;
	private var _chat:Label;
	
	
	public function new() 
	{
		super();
		
		_name = new Label();
		_name.setAlign(TextFormatAlign.CENTER);
		_name.setVerticalAlign(Label.ALIGN_CENTER);
		addChild(_name);
		
		// TODO: allow this to be set / swapped
		_avatar = new Image(Assets.getBitmapData("img/avatars/1.png"));
		addChild(_avatar);
		
		_chat = new Label();
		_chat.setAlign(TextFormatAlign.CENTER);
		_chat.setVerticalAlign(Label.ALIGN_CENTER);
		addChild(_chat);
		
		// position/size elements
		// TODO: move to Layout and use screensize percentages for scaling support
		_name.setWidth(_avatar.width);
		_name.setHeight(30);
		
		_avatar.y = _name.y + _name.getHeight();
		
		_chat.setWidth(_avatar.width);
		_chat.setHeight(30);
		_chat.y = _avatar.y + _avatar.height;
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
		// TODO: fade out after so many seconds?
		_chat.setText(message);
	}
	
}
