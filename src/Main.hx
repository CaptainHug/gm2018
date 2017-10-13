package;

import openfl.display.StageAlign;
import openfl.display.StageQuality;
import openfl.display.StageScaleMode;
import state.State_Startup;
import ui.Sprite;

/**
 * ...
 * @author hug
 */
class Main extends ui.Sprite 
{

	public function new() 
	{
		super();
		
		stage.scaleMode = StageScaleMode.SHOW_ALL;
		stage.align = untyped "";	// center align
		stage.quality = StageQuality.BEST;
		
		addChild(Kernel.getInstance());
		Kernel.getInstance().getStateManager().switchState(new State_Startup());
	}
	
}
