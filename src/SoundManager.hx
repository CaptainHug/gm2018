package;
import openfl.Assets;
import openfl.media.Sound;
import openfl.media.SoundChannel;
import openfl.media.SoundTransform;

/**
 * ...
 * @author hug
 */
class SoundManager 
{
	private var _music:Sound;
	private var _musicChannel:SoundChannel;
	
	
	public function new() 
	{
		
	}
	
	
	public function dispose():Void
	{
		
	}
	
	
	public function playMusic(music:String, appendExt:Bool=true):Void
	{
		if (_musicChannel != null) {
			_musicChannel.stop();
			_musicChannel = null;
		}
		
		if (_music != null) {
			_music.close();
			_music = null;
		}
		
		if (appendExt) {
#if flash
			music += ".mp3";
#else
			music += ".ogg";
#end
		}
		
		_music = Assets.getSound(music);
		_musicChannel = _music.play();
		_musicChannel.soundTransform = new SoundTransform(1.0);
	}
	
	
	public function stopMusic():Void
	{
		if (_musicChannel != null) {
			_musicChannel.stop();
		}
		
		// TODO: forceClear param?
	}
	
	
	public function playSound(sound:String):Void
	{
		// TODO: play sound
	}
}
