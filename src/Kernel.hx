package;
import openfl.errors.Error;

/**
 * ...
 * @author hug
 */
class Kernel extends Sprite 
{
	private static var _instance:Kernel = null;
	
	private var _backgroundManager:BackgroundManager;
	private var _stateManager:StateManager;
	private var _popupManager:PopupManager;
	
	
	public function new() 
	{
		super();
		
		if (_instance != null) {
			throw new Error("This is a Singleton. Please use getInstance instead!");
		}
		
		_backgroundManager = new BackgroundManager();
		addChild(_backgroundManager);
		
		_stateManager = new StateManager();
		addChild(_stateManager);
		
		_popupManager = new PopupManager();
		addChild(_popupManager);
	}
	
	
	public static function getInstance():Kernel
	{
		if (_instance == null) {
			_instance = new Kernel();
		}
		
		return _instance;
	}
	
	
	override public function dispose():Void
	{
		if (_backgroundManager != null) { _backgroundManager.dispose(); _backgroundManager = null; }
		if (_stateManager != null) { _stateManager.dispose(); _stateManager = null; }
		if (_popupManager != null) { _popupManager.dispose(); _popupManager = null; }
		
		super.dispose();
	}
	
	
	public function getBackgroundManager():BackgroundManager
	{
		return _backgroundManager;
	}
	
	public function getStateManager():StateManager
	{
		return _stateManager;
	}
	
	public function getPopupManager():PopupManager
	{
		return _popupManager;
	}
}
