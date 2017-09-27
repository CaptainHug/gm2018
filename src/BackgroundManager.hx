package;
import background.BaseBackground;

/**
 * ...
 * @author hug
 */
class BackgroundManager extends Sprite 
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
		trace("switchBackground: " + background.name);
		
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
