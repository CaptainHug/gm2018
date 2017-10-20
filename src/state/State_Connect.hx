package state;
import network.GameServer;
import network.event.GameServerEvent;
import openfl.Lib;
import openfl.text.TextFormatAlign;
import ui.Label;

/**
 * ...
 * @author hug
 */
class State_Connect extends BaseState 
{
	private var _server:GameServer;
	private var _label:Label;
	
	
	public function new() 
	{
		super();
		
		_label = new Label();
		_label.setText("Connecting...");
		_label.setAlign(TextFormatAlign.CENTER);
		_label.setVerticalAlign(Label.ALIGN_CENTER);
		_label.setWidth(Lib.current.stage.stageWidth);
		_label.setHeight(Lib.current.stage.stageHeight);
		addChild(_label);
		
		_server = Kernel.getInstance().getGameServer();
		_server.addEventListener(GameServerEvent.onConnection, onConnection);
		// TODO: _server.addEventListener(GameServerEvent.onConnectionLost, onConnectionLost);
		// TODO: handle connection errors
		_server.connect(Config.SERVER_HOST, Config.SERVER_PORT);
	}
	
	
	override public function dispose():Void
	{
		if (_server != null) {
			_server.removeEventListener(GameServerEvent.onConnection, onConnection);
			// TODO: _server.removeEventListener(GameServerEvent.onConnectionLost, onConnectionLost);
			_server = null;
		}
		
		if (_label != null) {
			_label.dispose();
			_label = null;
		}
		
		super.dispose();
	}
	
	
	private function onConnection(e:GameServerEvent):Void
	{
		Kernel.getInstance().getStateManager().switchState(new State_Login());
	}
}
