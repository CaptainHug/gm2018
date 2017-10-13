package;
import background.BaseBackground;

/**
 * ...
 * @author hug
 */
class BackgroundManager extends ui.Sprite 
{

	private var _background:BaseBackground;
	
	
	public function new() 
	{
		super();
		
		_background = null;
	}
	
	
	override public function dispose():Void
	{
		switchBackground(null);
		
		super.dispose();
	}
	
	
	public function switchBackground(background:BaseBackground):Void
	{
		trace("switchBackground: " + Type.getClassName(Type.getClass(background)));
		
		if (_background != null) {
			if (contains(_background)) {
				removeChild(_background);
			}
			
			_background.dispose();
			_background = null;
		}
		
		if (background != null) {
			_background = background;
			_background.init();
			addChild(_background);
		}
	}
	
}
