package;

import openfl.display.StageAlign;
import openfl.display.StageScaleMode;
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
		
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		addChild(Kernel.getInstance());
		Kernel.getInstance().getStateManager().switchState(new State_Startup());
	}
	
}
