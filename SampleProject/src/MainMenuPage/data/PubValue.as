package MainMenuPage.data
{
	import flash.data.EncryptedLocalStore;
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.desktop.NativeApplication;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import flash.system.Capabilities;

	import com.distriqt.extension.application.Application;
	
	/**
	 * ...
	 * @author Younes Mashayekhi
	 */
	public class PubValue
	{
		public function PubValue()
		{
		
		}

		
		public static function setEncryptedLocalStore($key:String, $value:String):void
		{
			var bytes:ByteArray = new ByteArray();
			bytes.writeUTFBytes($value);
			
			EncryptedLocalStore.setItem($key, bytes);
		}
		
		public static function getEncryptedLocalStore($key:String):String
		{
			var value:ByteArray = EncryptedLocalStore.getItem($key);
			
			if (!value)
				return null;
			
			return value.readUTFBytes(value.length);
		}
		
		public static function removeEncryptedLocalStore($key:String):void
		{
			EncryptedLocalStore.removeItem($key);
		}
		
		public static function resetEncryptedLocalStore():void
		{
			EncryptedLocalStore.reset();
		}
	
	}

}