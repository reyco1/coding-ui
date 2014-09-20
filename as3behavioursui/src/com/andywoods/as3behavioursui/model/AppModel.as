package com.andywoods.as3behavioursui.model
{
	import com.andywoods.as3behavioursui.util.Base64;
	
	import flash.text.Font;
	import flash.utils.ByteArray;

	public class AppModel
	{
		[Embed(source="../../../../../assets/font/arial.swf", symbol="myArial")]
		private static var ArialFont:Class;
		
		[Embed(source="../../../../../assets/data/config.txt", mimeType="application/octet-stream")]
		private static var ConfigData:Class;
		public  static var dataStructure:Object;
		
		public static function init():void
		{
			Font.registerFont(ArialFont);
			
			var raw:ByteArray 		= new ConfigData();
			var encoded:String 		= raw.readUTFBytes(raw.length);			
			var decoded:ByteArray 	= Base64.decodeToByteArray( encoded );
			dataStructure 			= decoded.readObject();
		}
	}
}