package;
import popup.BasePopup;

/**
 * ...
 * @author hug
 */
class PopupManager extends Sprite 
{
	private var _popups:Array<BasePopup>;
	
	
	public function new() 
	{
		super();
		
		_popups = [];
	}
	
	
	override public function dispose():Void
	{
		// clear popups array properly
		if (_popups != null) {
			while (_popups.length > 0) {
				pop();
			}
			_popups = null;
		}
		
		super.dispose();
		
	}
	
	
	public function push(popup:BasePopup):Void
	{
		if (popup == null) return;
		if (_popups == null) return;
		
		popup.init();
		_popups.push(popup);
		addChild(popup);
	}
	
	
	// removes a specific popup, or top most popup if none specified
	public function pop(popup:BasePopup=null):BasePopup
	{
		if (_popups == null || _popups.length <= 0) return null;
		
		var p:BasePopup;
		
		// if no popup passed in, remove the top one
		if (popup == null) {
			p = _popups.pop();
			if (p != null) {
				removePopup(p, false);
				return p;
			}
			return null;
		}
		// else remove the specified popup
		else {
			for (p in _popups) {
				if (p == popup) {
					
					if (p != null) {
						removePopup(p);
						return p;
					}
				}
			}
			return null;
		}
	}
	
	
	// removes all popups deriving from a specific class
	public function popType(type:String):Void
	{
		if (_popups == null || _popups.length <= 0) {
			return;
		}
		
		// TODO: this won't work for base type, sub types, etc...
		// TODO: need to clone the AS3 "is" keyword behaviour
		
		var i = _popups.length;
		while (i-- > 0) {
			var p:BasePopup = _popups[i];
			if (Type.getClassName(Type.getClass(p)) == type) {
				removePopup(p);
				p = null;
			}
		}
	}
	
	
	private function removePopup(popup:BasePopup, removeFromArray:Bool=true):Void 
	{
		if (popup != null) {
			if(contains(popup)) removeChild(popup);
			popup.dispose();
			if (removeFromArray) {
				_popups.remove(popup);
			}
		}
	}
	
	public function containsType(type:String):Bool
	{
		var i:Int;
		for (i in 0..._popups.length) {
			var p:BasePopup = _popups[i];
			if (Type.getClassName(Type.getClass(p)) == type) {
				
				return true;
			}
		}
		
		return false;
	}
	
	
	public function getType(type:String):BasePopup
	{
		var i:Int;
		for (i in 0..._popups.length) {
			var p:BasePopup = _popups[i];
			if (Type.getClassName(Type.getClass(p)) == type) {
				
				return p;
			}
		}
		
		return null;
	}
}
