package com.andywoods.as3behavioursui.view.ui.buttons
{
	import com.andywoods.as3behavioursui.view.AbstractView;
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class RoundedButton extends AbstractView
	{
		protected var label:TextField;
		protected var background:Sprite;
		protected var properties:Object;
		
		public  var onClick:Function;
		
		private var _width:Number  = 0;
		private var _height:Number = 0;		
		
		public function RoundedButton(labelStr:String, properties:Object = null)
		{
			super();
			
			this.properties = properties;
			
			mouseChildren 	= true;
			buttonMode 		= true;
			
			label 					= new TextField();
			label.mouseEnabled 		= false;
			label.embedFonts 		= true;
			label.autoSize 			= TextFieldAutoSize.LEFT;
			label.antiAliasType 	= AntiAliasType.ADVANCED;
			label.defaultTextFormat = new TextFormat( "myArial", 10, properties.textColor );
			label.text 				= labelStr;
			addChild( label );
			
			background = new Sprite();
			addChildAt( background, 0 );
			
			width  = properties.width;
			height = properties.height;
			
			background.addEventListener( MouseEvent.MOUSE_DOWN, handleClick );
		}
		
		public function show():TweenMax
		{
			return TweenMax.to( this, 0.15, {scaleX:1, scaleY:1, ease:Back.easeOut} );
		}
		
		protected function handleClick(event:MouseEvent):void
		{
			if( onClick != null )
				onClick.call();
						
			stage.addEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			background.alpha = 0.75;
		}
		
		protected function handleMouseUp(event:MouseEvent):void
		{
			stage.removeEventListener( MouseEvent.MOUSE_UP, handleMouseUp );
			background.alpha = 1.0;
		}
		
		protected function invalidate():void
		{
			background.graphics.clear();
			background.graphics.beginFill( properties.color, 1 );
			background.graphics.drawRoundRect( -_width * 0.5, -_height * 0.5, _width, _height, properties.elipse, properties.elipse );
			background.graphics.endFill();
			
			label.x = -label.width  * 0.5;
			label.y = (-label.height * 0.5) - 1;
		}
		
		override public function get width():Number{ return _width }
		override public function set width(value:Number):void
		{
			_width = value <  label.width + 2 ?  label.width + 2 : value;
			invalidate();
		}
		
		override public function get height():Number{ return _height }
		override public function set height(value:Number):void
		{
			_height = value <  label.height + 2 ?  label.height + 2 : value;
			invalidate();
		}
	}
}