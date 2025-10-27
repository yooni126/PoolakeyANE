package com.doitflash.utils.audio
{
	////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////// import classes
	////////////////////////////////////////////////////////////////////////////////////
	import com.greensock.TweenMax;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.media.Sound;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import com.doitflash.consts.MusicEvent
	import com.doitflash.consts.MusicRepeat
	import com.doitflash.consts.MusicInformPriority
	
	/**
	 * Class Music control yek abstract classi ast ke ba estefade az motoghayerha va tavabe an mitavanid
	 * musichaye prozhe khod ra ke ba yek "object array" moshakhas shodeand be rahati va sari control konid.
	 *
	 * <b>Copyright 2012, DoItFlash. All rights reserved.</b>
	 * For seeing the preview and sample files visit <a href="http://myappsnippet.com/">http://www.myappsnippet.com/</a>
	 *
	 * @see MusicEvent;
	 * @see MusicRepeat;
	 * @see  MusicInformPriority;
	 *
	 * @author Younes Mashayekhi - 4/21/2014 4:46 PM
	 * @version 1.0
	 *
	 * @example mesale zir be shoma neshan midahad ke chegoone mitavanid az in class estefade konid
	 *
	 *
	 * import MusicControler;
	 * import MusicEvent;
	 * import flash.utils.setTimeout;
	 * import flash.events.MouseEvent;
	 * import MusicRepeat;
	 * import MusicInformPriority;
	 * var playlist:Array = new Array();
	 *
	 * playlist = [{musicAddress:"Songs/music1.mp3",musicName:"baghalam kon",artist:"ahmad zade"},
	 *{musicAddress:"Songs/music2.mp3",musicName:"gole Pamchal",artist:"bi kalam"},
	 *{musicAddress:"Songs/music3.mp3",musicName:"ki ashkata pak mikone",artist:"ebi"}];
	
	 *var myMusic:MusicControler = new MusicControler(playlist,true,false);
	 *
	 *myMusic.pan = 0;
	 *
	 *myMusic.volume=1;
	 *
	 *myMusic.repeatMode = MusicRepeat.REPEAT_ALL;
	 *
	 *myMusic.musicInformPriority = MusicInformPriority.ARRAY_OBJECT;
	 *
	 *myMusic.shuffle=true;
	 *
	 *myMusic.normal=false;
	
	 *myMusic.stopAfterCurrentTrack=true
	
	 *myMusic.fadeMusic=true;
	
	
	
	 *function initDrag(e:MouseEvent):void
	 *{
	 *removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	 *seek_mc.startDrag(false,new Rectangle(line_mc.x, seek_mc.y,line_mc.width, 0));
	 *seek_mc.addEventListener(MouseEvent.MOUSE_MOVE, onSliderMove);
	 *stage.addEventListener(MouseEvent.MOUSE_MOVE, onSliderMove);
	 *}
	 *function terminateDrag(e:MouseEvent):void
	 *{
	 *seek_mc.stopDrag();
	 *seek_mc.removeEventListener(MouseEvent.MOUSE_MOVE, onSliderMove);
	 *stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSliderMove);
	 *addEventListener(Event.ENTER_FRAME, onEnterFrame);
	 *}
	 *function onSliderMove(e:MouseEvent):void
	 *{
	 *	var a:Number = seek_mc.x - line_mc.x;
	 *	var t:Number=Math.round((myMusic.length*a)/line_mc.width);
	 *	myMusic.position = t;
	 *	currentTime.text = myMusic.positionTime;
	 *}
	 *function initDrag2(e:MouseEvent):void
	 *{
	 *	removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	 *	volume_mc.startDrag(false,new Rectangle(volLine_mc.x, volume_mc.y,50, 0));
	 *	volume_mc.addEventListener(MouseEvent.MOUSE_MOVE, onVolumeMove);
	 *	stage.addEventListener(MouseEvent.MOUSE_MOVE, onVolumeMove);
	 *}
	 *function terminateDrag2(e:MouseEvent):void
	 *{
	 *	volume_mc.stopDrag();
	 *	volume_mc.removeEventListener(MouseEvent.MOUSE_MOVE, onVolumeMove);
	 *	stage.removeEventListener(MouseEvent.MOUSE_MOVE, onVolumeMove);
	 *}
	 *function onVolumeMove(e:MouseEvent):void
	 *{
	 *myMusic.volume=((Math.round(volume_mc.x-volLine_mc.x))*2)/100;
	 *volume_mc.vol_txt.text=String(myMusic.volume*100);
	 *}
	 *function id3(e:MusicEvent):void
	 *{
	 *	songName.text = myMusic.artist + " : " + myMusic.songName;
	 *}
	 *
	 *	myMusic.pan = -1;
	
	 *	myMusic.pan = 0;
	
	 *	myMusic.pan = 1;
	
	
	 *	myMusic.prevMusic();
	 *	currentSong.text = String(myMusic.currentSong);
	 *	songName.text = myMusic.songName;
	
	 *	myMusic.nextMusic();
	 *	currentSong.text = String(myMusic.currentSong);
	 *	songName.text = myMusic.songName;
	
	
	 *	myMusic.forward_track_seconds = 5;
	 *	currentTime.text = myMusic.positionTime;
	
	 *	myMusic.backward_track_seconds = 5;
	 *	currentTime.text = myMusic.positionTime;
	
	 *function volumeF(e:MouseEvent):void
	 *{
	 *	if (mute_mc.currentFrame == 1)
	 *	{
	 *		mute_mc.gotoAndStop(2);
	 *		myMusic.volume = 0;
	 *	}
	 *	else
	 *	{
	 *		mute_mc.gotoAndStop(1);
	 *		myMusic.volume = ((Math.round(volume_mc.x-volLine_mc.x))*2)/100;;
	 *	}
	 *}
	 *function playF(e:MouseEvent):void
	 *{
	 *	if (play_mc.currentFrame == 1)
	 *	{
	 *		play_mc.gotoAndStop(2);
	 *		addEventListener(Event.ENTER_FRAME, onEnterFrame);
	 *		myMusic.playMusic();
	 *	}
	 *	else
	 *	{
	 *		play_mc.gotoAndStop(1);
	 *		pauseF();
	 *	}
	 *}
	 *function stopF(e:MouseEvent):void
	 *{
	 *	myMusic.stopMusic();
	 *}
	 *function pauseF():void
	 *{
	 *	removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	 *	myMusic.pauseMusic();
	 *}
	 *function lengthMusic(e:MusicEvent):void
	 *{
	 *	totalTime.text = myMusic.lengthTime;
	 *}
	 *function onEnterFrame(event:Event):void
	 *{
	 *	seek_mc.x=line_mc.x + myMusic.position/myMusic.length*(line_mc.width);
	 *	currentTime.text = myMusic.positionTime;
	 *	totalSong.text = String(myMusic.totalSong);
	 *	currentSong.text = String(myMusic.currentSong);
	 *}*/
	
	public class MusicControler extends EventDispatcher
	{
		// ----------------------------------------------------------------------------------------------------------------------- vars
		// input vars
		
		private var _musicPosition:Number = 0;
		private var _musicVolume:Number = 1;
		private var _artist:String = "";
		private var _songName:String = "";
		private var _comment:String = "";
		private var _albumName:String = "";
		private var _volume:Number = 1;
		private var _length:Number = 0;
		private var _totalSongs:Number = 0;
		private var _currentSong:Number = 1;
		private var _repeatMode:String = "No_Repeat";
		private var _musicInformPriority:String = "id3"
		private var _shuffle:Boolean = false;
		private var _normal:Boolean = true;
		private var _autoPlay:Boolean = false;
		private var _stopAfterCurrent:Boolean = false;
		private var _fadeMusic:Boolean = true;
		
		//needed vars
		private var _musicArray:Array;
		private var _orginalMusicArray:Array = new Array();
		private var _isPlaying:Boolean = false;
		private var _isNext:Boolean = false;
		private var _isPrev:Boolean = false;
		private var _music:Sound;
		private var _musicTransform:SoundTransform;
		private var _musicChannel:SoundChannel;
		private var _volumeKeeper:Number;
		
		/**
		 * sanzade class ke 3 parameter be tartib zir be onvane vorodi migirad:
		 * 1- $playlist:Array
		 * yek array object ke bayad ghabl az farakhani class be an maghadir zir ra dad:
		 * musicAddress: address music
		 * songName: name music
		 * artist: khanande music
		 * for example: playlist:Array = [{musicAddress:"Songs/music1.mp3",musicName:"baghalam kon",artist:"ahmad zade"},
		 * {musicAddress:"Songs/music2.mp3",musicName:"gole Pamchal",artist:"bi kalam"},
		 * {musicAddress:"Songs/music3.mp3",musicName:"ki ashkata pak mikone",artist:"ebi"}];
		 * 2-@autoPlay:Boolean
		 * pakhashe khodkar music
		 * 3-@shuffle:Boolean
		 * pakhshe random music
		 */
		
		// ----------------------------------------------------------------------------------------------------------------------- constructor function
		public function MusicControler($playList:Array, $autoPlay:Boolean = true, $shuffle:Boolean = false, $volume:Number = 1):void
		{
			_music = new Sound();
			//negahdarande seda baraye mute va unmute
			
			_musicChannel = new SoundChannel();
			_musicTransform = new SoundTransform();
			_totalSongs = $playList.length;
			_musicArray = $playList;
			_autoPlay = $autoPlay
			_volumeKeeper = $volume;
			_orginalMusicArray = copyArray(_musicArray);
			if ($shuffle)
				// bara randomize kardane music ha be tori ke tekrari nabashad
			{
				_shuffle = true;
				_normal = false;
				_musicArray = shuffleMusic();
			}
			else
			{
				_shuffle = false;
				_normal = true;
			}
			_music.load(new URLRequest(_musicArray[0].musicAddress));
			_music.addEventListener(ProgressEvent.PROGRESS, musicProgress, false, 0, true);
			_music.addEventListener(Event.ID3, id3, false, 0, true);
			_music.addEventListener(IOErrorEvent.IO_ERROR, errorIo, false, 0, true);
			_music.addEventListener(Event.COMPLETE, musicLoadCompelete, false, 0, true);
			
			if (_autoPlay)
			{
				_musicTransform.volume = 0;
				playMusic();
				
			}
		
		}
		
		// ----------------------------------------------------------------------------------------------------------------------- Methods
		/**
		 * ejraye music badi ke barasase meghdar <code>repeteMode</code> amal mikonad
		 */
		public function nextMusic():void
		{
			// ham suffle va ham normal ra tarif kardim ta dar ebtedaye ejraye in function yekbar shuffle konad.
			if (_shuffle)
			{
				_musicArray = shuffleMusic();
				_shuffle = false;
			}
			
			if (_normal)
			{
				_musicArray = copyArray(_orginalMusicArray);
				_normal = false;
			}
			if (_currentSong > _totalSongs)
				_currentSong = _totalSongs;
			fadeMusic ? fadeOut() : _musicChannel.stop();
			_musicPosition = 0;
			_music = new Sound();
			switch (_repeatMode)
			{
			case (MusicRepeat.NO_REPEAT): 
			{
				if (_currentSong < _totalSongs)
				{
					_currentSong++;
					_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
					if (_isPlaying)
					{
						_isNext = true;
						if (!fadeMusic)
						{
							_isPlaying = false;
							playMusic();
						}
					}
					
				}
				else
				{
					//hengami ke be akharin music residim va repeatMode= No_REPEAT bood in dastoorat ejra mishavad
					_isPlaying = false;
					_currentSong = 1;
					_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
					this.dispatchEvent(new MusicEvent(MusicEvent.STOP_MUSIC));
				}
				break;
			}
			case (MusicRepeat.REPEAT_THIS): 
			{
				_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
				if (_isPlaying)
				{
					_isNext = true;
					if (!fadeMusic)
					{
						_isPlaying = false;
						playMusic();
					}
				}
				break;
			}
			case (MusicRepeat.REPEAT_ALL): 
			{
				if (_currentSong < _totalSongs)
				{
					_currentSong++;
					_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
					if (_isPlaying)
					{
						_isNext = true;
						if (!fadeMusic)
						{
							_isPlaying = false;
							playMusic();
						}
					}
				}
				else
				{
					_currentSong = 1;
					_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
					if (_isPlaying)
					{
						_isNext = true;
						if (!fadeMusic)
						{
							_isPlaying = false;
							playMusic();
						}
					}
				}
				break;
			}
			}
			_music.addEventListener(ProgressEvent.PROGRESS, musicProgress, false, 0, true);
			_music.addEventListener(Event.ID3, id3, false, 0, true);
			_music.addEventListener(IOErrorEvent.IO_ERROR, errorIo, false, 0, true);
			_music.addEventListener(Event.COMPLETE, musicLoadCompelete, false, 0, true);
		}
		
		/**
		 * ejraye music ghabli ke barasase meghdar <code>repeteMode</code> amal mikonad
		 */
		public function prevMusic():void
		{
			if (_shuffle)
			{
				_musicArray = shuffleMusic();
				_shuffle = false;
			}
			if (_normal)
			{
				_musicArray = copyArray(_orginalMusicArray);
				_normal = false;
			}
			if (_currentSong < 1)
				_currentSong = 1;
			fadeMusic ? fadeOut() : _musicChannel.stop();
			_musicPosition = 0;
			_music = new Sound();
			
			switch (_repeatMode)
			{
			case (MusicRepeat.NO_REPEAT): 
			{
				if (_currentSong > 1)
				{
					_currentSong--;
					
					_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
					if (_isPlaying)
					{
						_isPrev = true;
						if (!fadeMusic)
						{
							_isPlaying = false;
							playMusic();
						}
					}
				}
				else
				{
					_isPlaying = false;
					_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
					this.dispatchEvent(new MusicEvent(MusicEvent.STOP_MUSIC));
				}
				break;
			}
			case (MusicRepeat.REPEAT_THIS): 
			{
				_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
				if (_isPlaying)
				{
					_isPrev = true;
					if (!fadeMusic)
					{
						_isPlaying = false;
						playMusic();
					}
				}
				break;
			}
			case (MusicRepeat.REPEAT_ALL): 
			{
				if (_currentSong > 1)
				{
					_currentSong--;
					_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
					if (_isPlaying)
					{
						_isPrev = true;
						if (!fadeMusic)
						{
							_isPlaying = false;
							playMusic();
						}
					}
				}
				else
				{
					_currentSong = _totalSongs;
					_music.load(new URLRequest(_musicArray[_currentSong - 1].musicAddress));
					if (_isPlaying)
					{
						_isPrev = true;
						if (!fadeMusic)
						{
							_isPlaying = false;
							playMusic();
						}
					}
				}
				break;
			}
				
			}
			_music.addEventListener(ProgressEvent.PROGRESS, musicProgress, false, 0, true);
			_music.addEventListener(Event.ID3, id3, false, 0, true);
			_music.addEventListener(IOErrorEvent.IO_ERROR, errorIo, false, 0, true);
			_music.addEventListener(Event.COMPLETE, musicLoadCompelete, false, 0, true);
		}
		
		/**
		 * play Music
		 */
		public function playMusic():void
		{
			_music.addEventListener(ProgressEvent.PROGRESS, musicProgress, false, 0, true);
			_music.addEventListener(Event.ID3, id3, false, 0, true);
			_music.addEventListener(IOErrorEvent.IO_ERROR, errorIo, false, 0, true);
			_music.addEventListener(Event.COMPLETE, musicLoadCompelete, false, 0, true);
			_isPlaying = true;
			_musicChannel.stop();
			_musicChannel = _music.play(_musicPosition)
			if (fadeMusic)
			{
				if (_musicTransform.volume != _volumeKeeper)
				{
					_musicTransform.volume = 0
					TweenMax.to(_musicTransform, 2, {volume: _volumeKeeper, onUpdate: updateChannel});
				}
			}
			_musicChannel.soundTransform = _musicTransform;
			
			_musicChannel.addEventListener(Event.SOUND_COMPLETE, musicCompelete, false, 0, true);
		
		}
		
		/**
		 * pause Muic
		 */
		public function pauseMusic():void
		{
			_musicPosition = _musicChannel.position;
			
			if (fadeMusic)
			{
				fadeOut();
			}
			else
			{
				_musicChannel.stop();
				_isPlaying = false;
			}
			fadeMusic ? fadeOut() : _musicChannel.stop();
		}
		
		/**
		 * stop Music
		 */
		public function stopMusic():void
		{
			_musicPosition = 0;
			if (fadeMusic && _isPlaying)
			{
				fadeOut();
			}
			else
			{
				_musicChannel.stop();
				_isPlaying = false;
			}
			this.dispatchEvent(new MusicEvent(MusicEvent.STOP_MUSIC));
		}
		
		/**
		 * stop Music & delete this class from memory
		 */
		public function closeMusic():void
		{
			stopMusic();
			_musicChannel = null;
			_musicTransform = null;
			_musicArray = null;
			_orginalMusicArray = null;
			if (_music.isBuffering)
				_music.close();
			_music.removeEventListener(Event.SOUND_COMPLETE, musicCompelete);
			_music.removeEventListener(Event.ID3, id3);
			_music.removeEventListener(ProgressEvent.PROGRESS, musicProgress);
			_music.removeEventListener(Event.COMPLETE, musicCompelete);
			_music = null;
		
		}
		
		// ----------------------------------------------------------------------------------------------------------------------- function
		private function copyArray($sourceArray:Array):Array
		{
			var $destinationArray:Array = new Array();
			for (var i:Number = 0; i < $sourceArray.length; i++)
			{
				$destinationArray.push($sourceArray[i]);
			}
			return $destinationArray;
		}
		
		private function shuffleMusic():Array
		{
			var j:uint = _musicArray.length;
			if (j == 0)
			{
				return _musicArray;
			}
			while (--j)
			{
				var k:uint = Math.floor(Math.random() * _musicArray.length);
				var tmp1:Object = _musicArray[j];
				var tmp2:Object = _musicArray[k];
				_musicArray[j] = tmp2;
				_musicArray[k] = tmp1;
				
			}
			return _musicArray;
		}
		
		private function fadeIn():void
		{
			_musicTransform.volume = 0;
			TweenMax.to(_musicTransform, 1, {volume: _volumeKeeper, onUpdate: updateChannel, onComplete: fadeInComplete});
			playMusic();
		}
		
		private function fadeInComplete():void
		{
		
		}
		
		private function fadeOut():void
		{
			if (_isPlaying)
			{
				_musicTransform.volume = _volumeKeeper;
				TweenMax.to(_musicTransform, 1, {volume: 0, onUpdate: updateChannel, onComplete: fadeOutComplete});
			}
		
		}
		
		private function updateChannel():void
		{
			_musicChannel.soundTransform = _musicTransform;
		}
		
		private function fadeOutComplete():void
		{
			_musicChannel.stop();
			_isPlaying = false;
			if (_isNext)
			{
				_isNext = false;
				playMusic();
			}
			if (_isPrev)
			{
				_isPrev = false;
				playMusic();
			}
		}
		
		private function errorIo(e:IOErrorEvent):void
		{
			//dar soorati ke I/O moshkeli dasht az in function estefade mikonim
			this.dispatchEvent(new MusicEvent(MusicEvent.IO_ERROR));
		}
		
		private function musicProgress(e:ProgressEvent):void
		{
			//baraye estefade az byteLoaded ya totalByte az in function estefade mikonim
			this.dispatchEvent(new MusicEvent(MusicEvent.PROGESS_MUSIC));
		}
		
		private function musicCompelete(e:Event):void
		{
			if (!_stopAfterCurrent)
				nextMusic();
			else
			{
				stopMusic();
			}
			this.dispatchEvent(new MusicEvent(MusicEvent.COMPLETE_MUSIC));
		}
		
		private function musicLoadCompelete(e:Event):void
		{
			_length = _music.length;
			this.dispatchEvent(new MusicEvent(MusicEvent.COMPLETE_LOAD_MUSIC));
		}
		
		private function id3(e:Event):void
		{
			//agar musicInformPriority==id3 bashad ,name ahang,artist,... ra az id3 migirid dar gheyre in soorat az object array migirad
			if (_musicInformPriority == "id3")
			{
				_artist = _music.id3.artist;
				_songName = _music.id3.songName;
				_comment = _music.id3.comment;
				_albumName = _music.id3.album;
			}
			else
			{
				_songName = _musicArray[_currentSong - 1].musicName;
				_artist = _musicArray[_currentSong - 1].artist;
			}
			if (_songName == "")
				_songName = "Unknown";
			if (_artist == "")
				_artist = "Unknown";
			if (_comment == "")
				_comment = "Unknown";
			if (_albumName == "")
				_albumName = "";
			this.dispatchEvent(new MusicEvent(MusicEvent.ID3_MUSIC));
		
		}
		
		// ----------------------------------------------------------------------------------------------------------------------- Properties
		/**
		 * indicates the fade music
		 */
		public function get fadeMusic():Boolean
		{
			return _fadeMusic;
		}
		
		public function set fadeMusic($fade:Boolean):void
		{
			_fadeMusic = $fade;
		}
		
		/**
		 * indicates the autoPlay Music
		 */
		public function get autoPlay():Boolean
		{
			return _autoPlay
		}
		
		/**
		 * taeen in ke musicName,Artist,.... ra az id3 migirad ya object array?
		 * @default id3
		 */
		public function get musicInformPriority():String
		{
			return _musicInformPriority
		}
		
		/**
		 * taeen in ke musicName,Artist,.... ra az id3 begirad ya object array
		 * @default id3
		 * @see MusicInformPriority
		 */
		public function set musicInformPriority($priority:String):void
		{
			_musicInformPriority = $priority;
		}
		
		/**
		 * taeen an ke music aya shuffle ast
		 * @default false
		 */
		public function get shuffle():Boolean
		{
			return _shuffle;
		}
		
		public function set shuffle($shuffle:Boolean):void
		{
			_shuffle = $shuffle;
		}
		
		/**
		 * taeen an ke music aya normal ast
		 * @default false
		 */
		public function get normal():Boolean
		{
			return _normal
		}
		
		public function set normal($normal:Boolean):void
		{
			_normal = $normal;
		}
		
		/**
		 * gereftane tedade kolle music ha
		 */
		public function get totalSong():Number
		{
			return _totalSongs;
		}
		
		/**
		 * gereftane shomare track music feli
		 */
		public function get currentSong():Number
		{
			return _currentSong;
		}
		
		/**
		 * gereftane name khanande
		 */
		public function get artist():String
		{
			return _artist;
		}
		
		/**
		 * gereftane comment ahang az id3
		 */
		public function get comment():String
		{
			return _comment;
		}
		
		/**
		 * gereftane name music
		 */
		public function get songName():String
		{
			return _songName;
		}
		
		/**
		 * gereftane name music album
		 */
		public function get albumName():String
		{
			return _albumName
		}
		
		/**
		 * gereftane halate repeat ahang
		 * @default "No_Repeat"
		 */
		public function get repeatMode():String
		{
			return _repeatMode;
		}
		
		/**
		 * taeen halate tekrare music
		 * @see MusicRepeat
		 */
		public function set repeatMode($repeat:String):void
		{
			_repeatMode = $repeat;
		}
		
		/**
		 * gereftane mogheyate feli music be soorate milisecond
		 */
		public function get position():Number
		{
			if (_isPlaying)
			{
				return _musicChannel.position;
			}
			else
			{
				return _musicPosition;
			}
		}
		
		/**
		 * taghire position music ba komake seekbar
		 */
		public function set position($position:Number):void
		{
			_musicPosition = $position;
			if (_musicPosition < 0)
			{
				_musicPosition = 0
			}
			if (_musicPosition > _music.length)
			{
				_musicPosition = _music.length;
			}
			if (_isPlaying)
			{
				_musicChannel.stop();
				_isPlaying = false;
				playMusic();
			}
		
		}
		
		/**
		 * gereftane mogheyate feli music be soorate Min:Sec
		 */
		public function get positionTime():String
		{
			var min:String
			var sec:String
			if (_isPlaying)
			{
				min = Math.floor(_musicChannel.position / 60000).toString();
				sec = (Math.floor((_musicChannel.position / 1000) % 60) < 10) ? "0" + Math.floor((_musicChannel.position / 1000) % 60).toString() : Math.floor((_musicChannel.position / 1000) % 60).toString();
				return min + ":" + sec;
			}
			else
			{
				min = Math.floor(_musicPosition / 60000).toString();
				sec = (Math.floor((_musicPosition / 1000) % 60) < 10) ? "0" + Math.floor((_musicPosition / 1000) % 60).toString() : Math.floor((_musicPosition / 1000) % 60).toString();
				return min + ":" + sec;
			}
		}
		
		/**
		 * gereftane toole music be soorate milisecond
		 */
		public function get length():Number
		{
			return _length;
		}
		
		/**
		 * gereftane toole music be soorate Min:Sec
		 */
		public function get lengthTime():String
		{
			var min:String = Math.floor(_length / 60000).toString();
			var sec:String = (Math.floor((_length / 1000) % 60) < 10) ? "0" + Math.floor((_length / 1000) % 60).toString() : Math.floor((_length / 1000) % 60).toString();
			return min + ":" + sec;
		}
		
		/**
		 * gereftane meghdar volume music
		 */
		public function get volume():Number
		{
			return _volume;
		}
		
		/**
		 * set kardane volume music
		 */
		public function set volume($vol:Number):void
		{
			if ($vol != _volume)
				_volume = $vol
			_volumeKeeper = _volume;
			_musicTransform.volume = _volume;
			_musicChannel.soundTransform = _musicTransform;
		}
		
		/**
		 * set kardane Music Pan( speaker chap ya speaker rast)
		 */
		public function set pan($pan:Number):void
		{
			_musicTransform.pan = $pan;
			_musicChannel.soundTransform = _musicTransform
		}
		
		/**
		 * forward  kardane music be tedad saniye moshakhas
		 */
		public function set forward_track_seconds($fw:Number):void
		{
			$fw = Math.floor($fw * 1000);
			if (_isPlaying)
			{
				_musicPosition = _musicChannel.position;
			}
			_musicPosition += $fw;
			if (_musicPosition < 0)
			{
				_musicPosition = 0
			}
			if (_musicPosition > _music.length)
			{
				_musicPosition = _music.length;
			}
			if (_isPlaying)
			{
				_musicChannel.stop();
				_musicChannel = _music.play(_musicPosition);
				_musicTransform.volume = _volumeKeeper;
				_musicChannel.soundTransform = _musicTransform;
				_musicChannel.addEventListener(Event.SOUND_COMPLETE, musicCompelete, false, 0, true);
			}
		}
		
		/**
		 * backward kardane music be tedad saniye moshakhas
		 */
		public function set backward_track_seconds($bw:Number):void
		{
			$bw = Math.floor($bw * 1000);
			if (_isPlaying)
			{
				_musicPosition = _musicChannel.position;
			}
			_musicPosition -= $bw;
			if (_musicPosition < 0)
			{
				_musicPosition = 0
			}
			if (_musicPosition > _music.length)
			{
				_musicPosition = _music.length;
			}
			if (_isPlaying)
			{
				_musicChannel.stop();
				_musicChannel = _music.play(_musicPosition);
				_musicTransform.volume = _volumeKeeper;
				_musicChannel.soundTransform = _musicTransform;
				_musicChannel.addEventListener(Event.SOUND_COMPLETE, musicCompelete, false, 0, true);
			}
		}
		
		/**
		 * gereftane meghdare inke aya music bad az in track stop mikonad?
		 */
		public function get stopAfterCurrentTrack():Boolean
		{
			return _stopAfterCurrent
		}
		
		/**
		 * taeen meghdare inke music bad az in track stop konad ya kheyr.
		 */
		public function set stopAfterCurrentTrack($stopAfter:Boolean):void
		{
			_stopAfterCurrent = $stopAfter;
		}
		////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////
		////////////////////////////////////////////////////////////////////////////////////
	}

}