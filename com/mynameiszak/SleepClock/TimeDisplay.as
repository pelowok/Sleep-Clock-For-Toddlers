package com.mynameiszak.SleepClock {
	
	import com.mynameiszak.SleepClock.DateUtils;
	import flash.geom.*;

	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.filters.*;
	import flash.html.HTMLLoader;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	
	public class TimeDisplay {
		
		[Embed(systemFont="Arial", 
			fontName = "myFont", 
			mimeType = "application/x-font", 
			fontWeight="normal", 
			fontStyle="normal", 
			advancedAntiAliasing="true", 
			embedAsCFF="false")]
		
		private var myEmbeddedFont:Class;
		
		[Embed(systemFont="Arial", 
			fontName = "myFontBold", 
			mimeType = "application/x-font", 
			fontWeight="bold", 
			fontStyle="normal", 
			advancedAntiAliasing="true", 
			embedAsCFF="false")]
		
		private var myEmbeddedBoldFont:Class;
		
		public static var btnHourPlus:Sprite;
		public static var btnHourMinus:Sprite;
		public static var btnMinutePlus:Sprite;
		public static var btnMinuteMinus:Sprite;

		public function TimeDisplay() {
			
		}
		
		public static function makeLabel(str:String, fontSize:uint, fontColor:uint):MovieClip {
			
			var tf:TextFormat = new TextFormat( "myFontBold", fontSize );
			
			var lbl:TextField = new TextField;
			with(lbl){
				embedFonts 			= true;
				selectable			= false;
				autoSize          	= TextFieldAutoSize.LEFT;
				defaultTextFormat 	= tf;
				text 				= str;
				textColor 			= fontColor;
				visible 			= true;
			}
			
			var mc:MovieClip = new MovieClip;
			
			mc.addChild(lbl);
			
			return mc;
			
		}
		
		public static function makeLabelControls(mc:MovieClip, _label:String=""):MovieClip {
			
			var _x:uint;
			var _y:uint;
			
			// button : plus Hour
			_x = 0;
			_y = mc.getChildAt(0).y + mc.getChildAt(0).height + 10;
			btnHourPlus = makePlusButton(_x, _y);	
			mc.addChild(btnHourPlus);
			
			// button : minus Hour
			_y += btnHourPlus.height + 5;
			btnHourMinus = makeMinusButton(_x, _y);	
			mc.addChild(btnHourMinus);
			
			// button : plus Minute
			_x = 80;
			_y = mc.getChildAt(0).y + mc.getChildAt(0).height + 10;
			btnMinutePlus = makePlusButton(_x, _y);	
			mc.addChild(btnMinutePlus);
			
			// button : minus Minute
			_y += btnMinutePlus.height + 5;
			btnMinuteMinus = makeMinusButton(_x, _y);	
			mc.addChild(btnMinuteMinus);
			
			return mc;
			
		}
		
		private static function makePlusButton(_x:uint, _y:uint):Sprite {
			
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0xFFFF00, 0.75);
			s.graphics.drawRoundRect(0,0,60,60, 8,8);
			s.graphics.endFill();
			
			s.graphics.lineStyle(5, 0xFFFFFF, 1, false, "normal", "round", "round");
			s.graphics.moveTo(30, 20);		
			s.graphics.lineTo(30, 40);
			s.graphics.moveTo(20, 30);
			s.graphics.lineTo(40, 30);
			
			s.x = _x;
			s.y = _y;	
			
			return s;
			
		}
		
		private static function makeMinusButton(_x:uint, _y:uint):Sprite {
			
			var s:Sprite = new Sprite();
			s.graphics.beginFill(0xFFFF00, 0.75);
			s.graphics.drawRoundRect(0,0,60,60, 8,8);
			s.graphics.endFill();
			
			s.graphics.lineStyle(5, 0xFFFFFF, 1, false, "normal", "round", "round");
			s.graphics.moveTo(20, 30);
			s.graphics.lineTo(40, 30);
			
			s.x = _x;
			s.y = _y;	
			
			return s;
			
		}

	}  // end class code
	
}  // end package code
