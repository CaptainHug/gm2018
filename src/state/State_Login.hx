package state;
import haxe.Json;
import network.GameServer;
import network.GameServerEvent;
import openfl.Assets;
import openfl.Lib;
import openfl.events.Event;
import openfl.text.TextFormatAlign;
import ui.Button;
import ui.Image;
import ui.Label;
import ui.TextInput;

/**
 * ...
 * @author hug
 */
class State_Login extends BaseState 
{
	private var _server:GameServer;
	
	private var _header:Label;
	private var _name:Label;
	private var _nameInput:TextInput;
	private var _password:Label;
	private var _passwordInput:TextInput;
	private var _signup:Button;
	private var _login:Button;
	
	
	public function new() 
	{
		super();
		
	}
	
	
	override public function init():Void
	{
		super.init();
		
		trace("State_Login: init");
		
		var stageWidth:Float = Lib.current.stage.stageWidth;
		var stageHeight:Float = Lib.current.stage.stageHeight;
		
		_header = new Label();
		_header.setText("Login or Create Account");
		_header.setWidth(stageWidth);
		_header.setHeight(stageHeight * 0.16);
		_header.setAlign(TextFormatAlign.CENTER);
		_header.setVerticalAlign(Label.ALIGN_CENTER);
		addChild(_header);
		
		_name = new Label();
		_name.setText("Name:");
		_name.setWidth(stageWidth);
		_name.setHeight(stageHeight * 0.16);
		_name.setAlign(TextFormatAlign.CENTER);
		_name.setVerticalAlign(Label.ALIGN_CENTER);
		_name.y = _header.y + _header.getHeight();
		addChild(_name);
		
		_nameInput = new TextInput();
		_nameInput.setWidth(stageWidth);
		_nameInput.setHeight(stageHeight * 0.08);
		_nameInput.setAlign(TextFormatAlign.CENTER);
		//_nameInput.setVerticalAlign(Label.ALIGN_CENTER);
		_nameInput.y = _name.y + _name.getHeight();
		addChild(_nameInput);
		
		_password = new Label();
		_password.setText("Password:");
		_password.setWidth(stageWidth);
		_password.setHeight(stageHeight * 0.16);
		_password.setAlign(TextFormatAlign.CENTER);
		_password.setVerticalAlign(Label.ALIGN_CENTER);
		_password.y = _nameInput.y + _nameInput.getHeight();
		addChild(_password);
		
		_passwordInput = new TextInput();
		_passwordInput.setDisplayAsPassword(true);
		_passwordInput.setWidth(stageWidth);
		_passwordInput.setHeight(stageHeight * 0.08);
		_passwordInput.setAlign(TextFormatAlign.CENTER);
		//_passwordInput.setVerticalAlign(Label.ALIGN_CENTER);
		_passwordInput.y = _password.y + _password.getHeight();
		addChild(_passwordInput);
		
		_signup = new Button(new Image(Assets.getBitmapData("img/ui/button_up.png")), "Signup");
		_signup.setWidth(stageWidth * 0.5);
		_signup.setHeight(stageHeight * 0.16);
		_signup.y = _passwordInput.y + _passwordInput.getHeight();
		_signup.addEventListener(Button.TRIGGERED, onClickSignup);
		addChild(_signup);
		
		_login = new Button(new Image(Assets.getBitmapData("img/ui/button_up.png")), "Login");
		_login.setWidth(stageWidth * 0.5);
		_login.setHeight(stageHeight * 0.16);
		_login.x = stageWidth * 0.5;
		_login.y = _passwordInput.y + _passwordInput.getHeight();
		_login.addEventListener(Button.TRIGGERED, onClickLogin);
		addChild(_login);
		
		_server = Kernel.getInstance().getGameServer();
		_server.addEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
	}
	
	
	override public function dispose():Void
	{
		trace("State_Login: dispose");
		
		if (_server != null) {
			_server.removeEventListener(GameServerEvent.onExtensionResponse, onExtensionResponse);
			_server = null;
		}
		
		if (_header != null) {
			_header.dispose();
			_header = null;
		}
		
		if (_name != null) {
			_name.dispose();
			_name = null;
		}
		
		if (_nameInput != null) {
			_nameInput.dispose();
			_nameInput = null;
		}
		
		if (_password != null) {
			_password.dispose();
			_password = null;
		}
		
		if (_passwordInput != null) {
			_passwordInput.dispose();
			_passwordInput = null;
		}
		
		if (_signup != null) {
			_signup.dispose();
			_signup = null;
		}
		
		if (_login != null) {
			_login.dispose();
			_login = null;
		}
		
		super.dispose();
		
	}
	
	
	private function onClickSignup(e:Event):Void
	{
		var name:String = _nameInput.getText();
		var password:String = _passwordInput.getText();
		
		if(name != null && name.length > 0 && password != null && password.length > 0) {
			_server.sendExtMessage("lobby", "signup", { name:name, password:password } );
		}
		else {
			// TODO: show error
			trace("no name or password provided");
		}
	}
	
	private function onClickLogin(e:Event):Void
	{
		var name:String = _nameInput.getText();
		var password:String = _passwordInput.getText();
		
		if(name != null && name.length > 0 && password != null && password.length > 0) {
			_server.sendExtMessage("lobby", "login", { name:name, password:password } );
		}
		else {
			// TODO: show error
			trace("no name or password provided");
		}
	}
	
	
	private function onExtensionResponse(e:GameServerEvent):Void
	{
		trace("onExtensionResponse: " + Json.stringify(e.data));
		
		if (e.data != null) {
			switch(e.data.cmd) {
				case "onSignupOK":
				{
					if (e.data.params != null) {
						trace("signup success: " + Json.stringify(e.data.params));
						
						// now log user in automatically
						onClickLogin(null);
					}
				}
				case "onSignupError":
				{
					if (e.data.params != null) {
						trace("signup error: " + Json.stringify(e.data.params));
					}
				}
				case "onLoginOK":
				{
					if (e.data.params != null) {
						trace("login success: " + e.data.params.name);
						
						Kernel.getInstance().getStateManager().switchState(new State_GameRoom());
					}
				}
			}
		}
	}
	
}
