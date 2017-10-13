package background;
import ui.Sprite;

/**
 * ...
 * @author hug
 */
class Background_Test extends BaseBackground 
{

	public function new() 
	{
		super();
		
	}
	
	
	override public function init():Void
	{
		super.init();
		
		var test:ui.Sprite = new ui.Sprite();
		test.graphics.beginFill(0xff00ff);
		test.graphics.drawRect(0, 0, 32, 32);
		test.graphics.endFill();
		addChild(test);
	}
	
	
	override public function dispose():Void
	{
		super.dispose();
		
	}
	
}