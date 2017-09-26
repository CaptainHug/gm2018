package;

import openfl.Assets;
import openfl.display.Bitmap;
import openfl.Lib;
import state.State_Startup;

/**
 * ...
 * @author hug
 */
class Main extends Sprite 
{

	public function new() 
	{
		super();
		
		// Assets:
		// openfl.Assets.getBitmapData("img/assetname.jpg");
		
		/*
		var test:Sprite = new Sprite();
		test.graphics.beginFill(0xff00ff);
		test.graphics.drawRect(0, 0, 32, 32);
		test.graphics.endFill();
		addChild(test);
		
		var img:Bitmap = new Bitmap(Assets.getBitmapData("img/gumball.png"));
		test.addChild(img);
		
		trace("done!");
		*/
		
		addChild(Kernel.getInstance());
		Kernel.getInstance().getStateManager().switchState(new State_Startup());
	}

}
