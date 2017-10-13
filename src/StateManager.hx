package;
import popup.BasePopup;
import state.BaseState;
import ui.Sprite;

/**
 * ...
 * @author hug
 */
class StateManager extends ui.Sprite 
{
	private var _state:BaseState;
	
	
	public function new() 
	{
		super();
		
		_state = null;
	}
	
	
	override public function dispose():Void
	{
		switchState(null);
		
		super.dispose();
	}
	
	
	public function switchState(state:BaseState):Void
	{
		trace("switchState: " + Type.getClassName(Type.getClass(state)));
		
		if (_state != null) {
			if (contains(_state)) {
				removeChild(_state);
			}
			
			_state.dispose();
			_state = null;
		}
		
		Kernel.getInstance().getPopupManager().popType(BasePopup);
		
		if (state != null) {
			_state = state;
			_state.init();
			addChild(_state);
		}
	}
}
