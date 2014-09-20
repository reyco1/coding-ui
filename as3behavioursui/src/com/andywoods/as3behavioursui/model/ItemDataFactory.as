package com.andywoods.as3behavioursui.model
{
	import com.andywoods.as3behavioursui.data.ActionObject;
	import com.andywoods.as3behavioursui.data.EventObject;
	import com.andywoods.as3behavioursui.data.ItemData;
	import com.andywoods.as3behavioursui.data.PropertyObject;
	
	import flash.utils.Dictionary;

	public class ItemDataFactory
	{
		private static var dataHash:Dictionary = new Dictionary();
		
		public static function getData( forType:String ):ItemData
		{
			var rawObject:Object = AppModel.dataStructure[ forType ];
			var returnItemData:ItemData;
			
			if( rawObject == null )
			{
				var errorMsg:String = "[ItemDataFactory] There is no object with the name " + "\"" + forType + "\".";
				throw new Error( errorMsg );
			}
			
			if( dataHash[forType] != null )
			{
				returnItemData = dataHash[forType];
			}
			else
			{
				returnItemData = generateItemData( forType, rawObject );
			}
			
			return returnItemData;
		}
		
		private static function generateItemData( forType:String, rawObject:Object ):ItemData
		{
			var returnItemData:ItemData;
			var temp:Array = [];
			var type:String;
			var a:int;
			
			if( rawObject.actions )
			{
				for (a = 0; a < rawObject.actions.length; a++) 
				{
					returnItemData.actions.push( new ActionObject(rawObject.actions[a].name) );
				}
				
				while( returnItemData.actions.length > 0 ) temp.push( returnItemData.actions.pop() );
				temp.sortOn( "name" );
				while( temp.length > 0 ) returnItemData.actions.push( temp.pop() );
			}
			
			if( rawObject.events )
			{
				for (a = 0; a < rawObject.events.length; a++) 
				{
					type = rawObject.events[a].name.substr(0, 2) == "do" || rawObject.events[a].name.substr(0, 2) == "on" ? "time" : "mouse";
					returnItemData.events.push( new EventObject(rawObject.events[a].name, type) );
				}
				
				while( returnItemData.events.length > 0 ) temp.push( returnItemData.events.pop() );
				temp.sortOn( "name" );
				while( temp.length > 0 ) returnItemData.events.push( temp.pop() );
			}
			
			if( rawObject.editableProps )
			{
				for (a = 0; a < rawObject.editableProps.length; a++) 
				{
					type = rawObject.attrsInfo[ rawObject.editableProps[a].name ] ? rawObject.attrsInfo[ rawObject.editableProps[a].name ] : "string";
					returnItemData.editableProperties.push( new PropertyObject(rawObject.editableProps[a].name, type) );
				}
				
				while( returnItemData.editableProperties.length > 0 ) temp.push( returnItemData.editableProperties.pop() );
				temp.sortOn( "name" );
				while( temp.length > 0 ) returnItemData.editableProperties.push( temp.pop() );
			}
			
			return returnItemData;
		}
	}
}