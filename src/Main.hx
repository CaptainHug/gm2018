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
		
		addChild(Kernel.getInstance());
		Kernel.getInstance().getStateManager().switchState(new State_Startup());
	}

}
