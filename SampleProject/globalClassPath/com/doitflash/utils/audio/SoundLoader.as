package com.doitflash.utils.audio
{
////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////// import classes
////////////////////////////////////////////////////////////////////////////////////
	import com.doitflash.events.AudioEvent;
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import flash.events.*;
	import flash.net.*;
	
	//import com.luaye.console.C;
	
	/**
	 * SoundLoader is a class to create abstract mp3 player.
	 * 
	 * @author Ali Tavakoli - 8/15/2010 5:26 PM
	 * @version 3.0
	 * @example create a completely abstract player:
	 * 
	 * <listing version="3.0">
	 * import com.doitflash.utils.audio.SoundLoader;
	 * import com.doitflash.events.AudioEvent;
	 * 
	 * var _soundLoader:SoundLoader = new SoundLoader("myMusic.mp3", false);
	 * 
	 * _soundLoader.sound.addEventListener(AudioEvent.SOUND_PROGRESS, soundProgress, false, 0, true);
	 * _soundLoader.sound.addEventListener(AudioEvent.SOUND_COMPLETED, soundCompleted, false, 0, true);
	 * _soundLoader.sound.addEventListener(AudioEvent.ID3_READY, id3Ready, false, 0, true);
	 * _soundLoader.sound.addEventListener(AudioEvent.SOUND_FINISHED, soundFinished, false, 0, true);
	 * 
	 * //_soundLoader.soundPosition = 107934; // set sound position
	 * _soundLoader.volume = .5;
	 * 
	 * //_soundLoader.play(); // play sound
	 * //_soundLoader.pause(); // pause sound
	 * //_soundLoader.stop(); // stop sound
	 * //_soundLoader.close(); // remove all of the soundLoader class settings
	 * 
	 * private function soundProgress(e:AudioEvent):void
	 * {
	 * 	trace(e.currentTarget.bytesLoaded, e.currentTarget.bytesTotal);
	 * }
	 * private function soundCompleted(e:AudioEvent):void
	 * {
	 * 	trace("sound loaded", _soundLoader.soundLength);
	 * }
	 * private function id3Ready(e:AudioEvent):void
	 * {
	 * 	trace("ID3 is ready", _soundLoader.artist, _soundLoader.songName, _soundLoader.comment);
	 * }
	 * private function soundFinished(e:AudioEvent):void
	 * {
	 * 	trace("sound finished", _soundLoader.soundPosition);
	 * }
	 * </listing>
	 */
	public class SoundLoader extends Sprite
	{
////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////// properties
////////////////////////////////////////////////////////////////////////////////////
		
	// input variables
		private var _artist:String;
		private var _songName:String;
		private var _comment:String;
		
		private var _soundPosition:Number = 0;
		private var _volume:Number = 1;
		
	// needed variables
		public var _sound:Sound;
		public var _soundChannel:SoundChannel;
		
		private var _soundTransform:SoundTransform;
		
////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////// constructor function
////////////////////////////////////////////////////////////////////////////////////
		/**
		 * constructor function.
		 */
		public function SoundLoader($path:String, $autoPlay:Boolean = true):void // path is a necessary thing to play a sound, so have it as an argue when initializing
		{
			_sound = new Sound();
			_soundChannel = new SoundChannel();
			_soundTransform = new SoundTransform();
			
			_sound.load(new URLRequest($path));
			
			_sound.addEventListener(ProgressEvent.PROGRESS, soundProgress, false, 0, true);
			_sound.addEventListener(Event.COMPLETE, soundComplete, false, 0, true);
			_sound.addEventListener(Event.ID3, id3Ready, false, 0, true);
			_sound.addEventListener(IOErrorEvent.IO_ERROR, onIoError, false, 0, true);
			
			if ($autoPlay) play();
		}
////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////// private function
////////////////////////////////////////////////////////////////////////////////////
		
		private function soundProgress(e:ProgressEvent):void
		{
			_sound.dispatchEvent(new AudioEvent(AudioEvent.SOUND_PROGRESS));
		}
		
		private function soundComplete(e:Event):void
		{
			_sound.dispatchEvent(new AudioEvent(AudioEvent.SOUND_COMPLETED));
		}
		
		private function onIoError(e:IOErrorEvent):void
		{
			_sound.dispatchEvent(new AudioEvent(AudioEvent.SOUND_IO_ERROR));
		}
		
		private function id3Ready(e:Event):void
		{
			_artist = _sound.id3.artist;
			_songName = _sound.id3.songName;
			_comment = _sound.id3.comment;
			_sound.dispatchEvent(new AudioEvent(AudioEvent.ID3_READY));
			
			
		}
		
		private function soundFinished(e:Event):void
		{
			stop();
			
			_sound.dispatchEvent(new AudioEvent(AudioEvent.SOUND_FINISHED));
		}
		
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////// methods
////////////////////////////////////////////////////////////////////////////////////
		
		public function play():void
		{
			_soundChannel = _sound.play(_soundPosition);
			
			// flash bug: we should lower the volume here instantly. because if the vloume was .1 when the sound paused and plays again... the volume is still .1 but in reality, we hear a loud sound at 1 value!
			_soundTransform.volume = _volume;
			_soundChannel.soundTransform = _soundTransform;
			
			_soundChannel.addEventListener(Event.SOUND_COMPLETE, soundFinished, false, 0, true);
		}
		
		public function pause():void
		{
			_soundPosition = _soundChannel.position;
			_soundChannel.stop();
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundFinished);
		}
		
		public function stop():void
		{
			_soundPosition = 0;
			_soundChannel.stop();
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundFinished);
		}
		
		public function close():void
		{
			stop();
			
			_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundFinished);
			_soundChannel = null;
			
			if (_sound.isBuffering) _sound.close();
			_sound.removeEventListener(ProgressEvent.PROGRESS, soundProgress);
			_sound.removeEventListener(Event.COMPLETE, soundComplete);
			_sound.removeEventListener(Event.ID3, id3Ready);
			_sound = null;
		}
		
		public function formatTime(time:Number):String
		{
        var min:String = Math.floor(time/60000).toString();
        var sec:String = (Math.floor((time/1000)%60) < 10)? "0" + Math.floor((time/1000)%60).toString() : Math.floor((time/1000)%60).toString();
		
        return(min+":"+sec);
		}
		
////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////// setter - getter
////////////////////////////////////////////////////////////////////////////////////
		
		public function get soundPosition():Number
		{
			//_soundPosition = _soundChannel.position;
			
			return _soundChannel.position;
		}
		public function set soundPosition(a:Number):void 
		{
			if(a != _soundPosition)
			{
				_soundPosition = a;
				
				_soundChannel.stop();
				_soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundFinished);
				play();
			}
		}
		
		public function get soundLength():Number
		{
			return _sound.length;
		}
		
		public function get volume():Number
		{
			return _volume;
		}
		public function set volume(a:Number):void 
		{
			if(a != _volume)
			{
				_volume = a;
				
				_soundTransform.volume = _volume;
				_soundChannel.soundTransform = _soundTransform;
			}
		}
		
		public function get sound():Sound
		{
			return _sound;
		}
		
		public function get artist():String
		{
			return _artist;
		}
		public function get songName():String
		{
			return _songName;
		}
		public function get comment():String
		{
			return _comment;
		}
		
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
	}
}