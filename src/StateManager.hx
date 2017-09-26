package;
import state.BaseState;

/**
 * ...
 * @author hug
 */
class StateManager extends Sprite 
{

	public function new() 
	{
		super();
		
	}
	
	
	override public function dispose():Void
	{
		super.dispose();
		
	}
	
	
	public function switchState(state:BaseState):Void
	{
		trace("switchState: " + state.name);
		
	}
}
