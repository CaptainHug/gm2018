package;
import network.GameServer;
import openfl.Lib;
import openfl.errors.Error;
import ui.Sprite;

/**
 * ...
 * @author hug
 */
class Kernel extends ui.Sprite 
{
	private static var _instance:Kernel = null;
	
	private var _backgroundManager:BackgroundManager;
	private var _stateManager:StateManager;
	private var _popupManager:PopupManager;
	
	private var _soundManager:SoundManager;
	private var _gameServer:GameServer;
	
	
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
		
		_soundManager = new SoundManager();
		_gameServer = new GameServer();
		
		Lib.current.stage.application.onExit.add(onApplicationExit);
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
		
		if (_soundManager != null) { _soundManager.dispose(); _soundManager = null; }
		if (_gameServer != null) { _gameServer.disconnect(); _gameServer = null; }
		
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
	
	public function getSoundManager():SoundManager
	{
		return _soundManager;
	}
	
	public function getGameServer():GameServer
	{
		return _gameServer;
	}
	
	
	private function onApplicationExit(exitCode:Int)
	{
		trace("onApplicationExit: exitCode = " + exitCode);
		dispose();
	}
}
