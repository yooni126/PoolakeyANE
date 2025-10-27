package com.doitflash.events
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Younes
	 */
	public class MyAudioEvent extends Event
	{
		public static const START_MUSIC:String = "playMusic";
		public static const PAUSE_MUSIC:String = "pauseMusic";
		public static const STOP_MUSIC:String = "stopMusic";
	
		private var _param:*;
		
		public function MyAudioEvent(type:String, data:*= null, bubbles:Boolean = false, cancelable:Boolean = false):void
		{
			_param = data;
			super(type, bubbles, cancelable);
		}

		public function get param():*
		{
			return _param;
		}
	}

}