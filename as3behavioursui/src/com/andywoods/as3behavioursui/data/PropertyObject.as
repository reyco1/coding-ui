package com.andywoods.as3behavioursui.data
{
	public class PropertyObject
	{
		public static const FIXED 	  : String = "fixed";
		public static const EDITABLE  : String = "editable";
		
		public var name:String;
		public var type:String;
		public var value:String;
		
		public function PropertyObject( name:String, type:String, value:String = null )
		{
			this.name 	= name;
			this.type 	= type;
			this.value 	= value;
		}
	}
}