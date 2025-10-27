package com.doitflash.consts
{
	import flash.events.Event;
	
	/**
	 * MusicEvent class shows all the events being dispatched by the MusicControler.
	 * @author Younes Mashayekhi 4/17/2014 4:52 PM
	 */
	public class MusicEvent extends Event
	{
		/**
		 * Dispatches when pause button is clicked.
		 */
		public static const PAUSE_MUSIC:String = "pauseMusic";
		/**
		 * Dispatches when stop button is clicked.
		 */
		public static const STOP_MUSIC:String = "stopMusic";
		/**
		 * Dispatches when the music ID3 is ready.
		 */
		public static const ID3_MUSIC:String = "id3";
		/**
		 * Dispatches when the music loading is on progress.
		 */
		public static const PROGESS_MUSIC:String = "progressMusic";
		/**
		 * Dispatches if there's an IOError
		 */
		public static const IO_ERROR:String = "ioError";
		/**
		 * Dispatches when the music is finished.
		 */
		public static const COMPLETE_MUSIC:String = "completeMusic";
		/**
		 * Dispatches when the music loading is completed.
		 */
		public static const COMPLETE_LOAD_MUSIC:String = " completeLoadMusic";

		private var _param:*;
		
		/**
		 * @private
		 * @param	type
		 * @param	data
		 * @param	bubbles
		 * @param	cancelable
		 */
		public function MusicEvent(type:String, param:*=null, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_param = param;
			super(type, bubbles, cancelable);
		
		}
		/**
		 * @private
		 */
		public function get param():*
		{
			return _param;
		}
		public override function clone():Event
		{
			return new MusicEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("MusicEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}