package state;
import background.Background_Test;
import openfl.Assets;
import openfl.display.Bitmap;

/**
 * ...
 * @author hug
 */
class State_Startup extends BaseState 
{

	public function new() 
	{
		super();
		
	}
	
	
	override public function init():Void
	{
		super.init();
		
		Kernel.getInstance().getBackgroundManager().switchBackground(new Background_Test());
		
		var img:Bitmap = new Bitmap(Assets.getBitmapData("img/gumball.png"));
		addChild(img);
		
		// TODO: Kernel.getInstance().getPopupManager().
		
		Kernel.getInstance().getSoundManager().playMusic("audio/music");
	}
	
	
	override public function dispose():Void
	{
		super.dispose();
		
	}
	
}
