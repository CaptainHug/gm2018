package state;
import background.Background_Test;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import ui.Button;
import ui.Image;
import ui.Label;
import ui.Scale3Image;

/**
 * ...
 * @author hug
 */
class State_Startup extends BaseState 
{
	private var _button:Button;
	private var _scale3:Scale3Image;
	
	
	public function new() 
	{
		super();
		
	}
	
	
	override public function init():Void
	{
		super.init();
		
		Kernel.getInstance().getBackgroundManager().switchBackground(new Background_Test());
		
		var img:Image = new Image(Assets.getBitmapData("img/gumball.png"));
		img.x = (Lib.current.stage.stageWidth - img.width) / 2;
		img.y = (Lib.current.stage.stageHeight - img.height) / 2;
		addChild(img);
		
		var label:Label = new Label();
		label.setWidth(500);
		label.setHeight(50);
		label.setText("bodger");
		addChild(label);
		
		_button = new Button(new Image(Assets.getBitmapData("img/ui/button_up.png")), "BUTTON", new Image(Assets.getBitmapData("img/ui/button_down.png")), new Image(Assets.getBitmapData("img/ui/button_hover.png")), new Image(Assets.getBitmapData("img/ui/button_disabled.png")));
		_button.setWidth(200);
		_button.setHeight(103);
		_button.addEventListener(Button.TRIGGERED, onClickButton);
		//addChild(_button);
		
		_scale3 = new Scale3Image(Assets.getBitmapData("img/ui/button_up.png"), 80, 40);
		_scale3.setWidth(300);
		_scale3.setHeight(103);
		addChild(_scale3);
		
		// TODO: Kernel.getInstance().getPopupManager().
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
		Kernel.getInstance().getSoundManager().playMusic("audio/music");
	}
	
	
	override public function dispose():Void
	{
		Lib.current.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		
		if (_button != null) {
			_button.dispose();
			_button = null;
		}
		
		if (_scale3 != null) {
			_scale3.dispose();
			_scale3 = null;
		}
		
		super.dispose();
	}
	
	
	private function onClickButton(e:Event):Void
	{
		trace("click mo fo");
		
		if (_button != null) {
			_button.setEnabled(false);
		}
	}
	
	
	private function onKeyDown(e:KeyboardEvent):Void
	{
		switch(e.keyCode) {
			case Keyboard.RIGHT:
			{
				if (_scale3 != null) {
					_scale3.setWidth(_scale3.getWidth() + 1);
				}
			}
			case Keyboard.LEFT:
			{
				if(_scale3 != null) {
					_scale3.setWidth(_scale3.getWidth() - 1);
				}
			}
		}
	}
}
