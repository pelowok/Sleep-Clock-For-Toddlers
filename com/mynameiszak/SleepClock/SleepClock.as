package com.mynameiszak.SleepClock {
	
	import com.mynameiszak.SleepClock.DateUtils;
	import com.mynameiszak.SleepClock.TimeDisplay;
	import com.mynameiszak.SleepClock.BouncingBall;
	import com.mynameiszak.SleepClock.ExitButton;
	
	import com.mynameiszak.ExternalLoader.ExternalLoader;
	
	import flash.text.TextField;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.desktop.NativeApplication;
	import flash.desktop.SystemIdleMode;
	import flash.events.MouseEvent;
	
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import flash.events.TouchEvent;
	import flash.events.GestureEvent;
	import flash.events.TransformGestureEvent;
	import flash.events.GesturePhase;
	import flash.events.PressAndTapGestureEvent;
	
	import fl.motion.Color;
	
	
	public class SleepClock extends MovieClip {
		
		public var txtCurrentTime:TextField;
		public var txtWakeTime:TextField;
		public var timeWake:Date;
		public var timeNow:Date;
		public var numberOfBalls:int = (Math.random() * 10 ) + 5;
		public var ballAlpha:Number = 0.5;
		public var btnCurrentTime:TimeDisplayButton;
		public var btnExit:ExitButton;
		public var bg:MovieClip;
		public var wakeTimeDisplay:MovieClip;
		public var alarmOn:Boolean = false;
		private var timerCurrentTime:Timer = new Timer(1000);

		
		public function SleepClock() {
			// constructor code
			onInit();
		}
		
		private function onInit():void{
			
			// no dimming
			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;
			
			Multitouch.inputMode=MultitouchInputMode.TOUCH_POINT;
			
			addBackground();
			
			for(var i:int=0; i<numberOfBalls;i++){
				addBouncingBall();
			}	

			setChildIndex(bg, numChildren - 1);
			
			btnCurrentTime = new TimeDisplayButton();
			btnCurrentTime.clock = this;
			btnCurrentTime.addTimeDisplay();	
			bg.addChild(btnCurrentTime);
			
			btnExit = new ExitButton();
			btnExit.x = stage.stageWidth;
			bg.addChild(btnExit);

			bg.addEventListener(MouseEvent.CLICK, addBouncingBall_event);
			
			wakeTimeDisplay = addWakeTimeDisplayWithControls(wakeTimeDisplay, "wakeTimeDisplay");
			
			TimeDisplay.btnHourPlus.addEventListener(MouseEvent.CLICK, hourPlusBegin);
			TimeDisplay.btnHourMinus.addEventListener(MouseEvent.CLICK, hourMinusBegin);
			TimeDisplay.btnMinutePlus.addEventListener(MouseEvent.CLICK, minutePlusBegin);
			TimeDisplay.btnMinuteMinus.addEventListener(MouseEvent.CLICK, minuteMinusBegin);
			
			startTimer();
			
			var myLoader:Loader = ExternalLoader.tryLoad("img/icoSimon.png");
			myLoader.addEventListener(Event.COMPLETE, funPlaceIcon);
			
		}
		
		private function addBackground():void{
			
			bg = new MovieClip();
			bg.graphics.beginFill(0x000000, 0);
			bg.graphics.drawRect(0,0,stage.stageWidth, stage.stageHeight);
			bg.graphics.endFill();
			
			addChild(bg);
			
		}
		
		private function addBouncingBall_event(e:MouseEvent):void{
			addBouncingBall();
			var bb:BouncingBall = this.getChildAt(this.numChildren -1) as BouncingBall;
		//	bb.x = mouseX;
		//	bb.y = mouseY;
		}
		
		private function addBouncingBall():void{
			
			var diameter:uint = (Math.random() * 92) + 8 ;
			var color1:uint = Math.random() * 0xFFFFFF;
			var color2:uint = Math.random() * 0xFFFFFF;
		//	var color2:uint = 0x000000;
			
			var bb:BouncingBall = new BouncingBall( this, diameter, color1, color2);
				
			bb.alpha = ballAlpha;
			
			bb.x = Math.random() * bg.width;
			bb.y = Math.random() * bg.height;
			
			addChild( bb );		
			
			setChildIndex( bb, 0);
			
		}
		
		
		public function addWakeTimeDisplayWithControls(mc:MovieClip, _label:String):MovieClip {
			
			timeWake = new Date();
			timeWake.setMinutes(0);
			timeWake.setHours(6);
			
			var strTimeNow:String = DateUtils.getFormattedTime(timeWake);
			
			var lbl:MovieClip = TimeDisplay.makeLabel("wake time:", stage.stageHeight / 30, 0xFFFF00);
			lbl.y = (stage.stageHeight / 30) * -1;
			
			mc = TimeDisplay.makeLabel(strTimeNow, stage.stageHeight / 15, 0xFFFF00);
			
			txtWakeTime = mc.getChildAt(0) as TextField;
			
			mc.addChild(lbl);
			
			mc.x = ( stage.stageWidth / 2 ) - ( mc.width / 2 );
			mc.y = ( stage.stageHeight / 10 ) * 4;
			
			mc = TimeDisplay.makeLabelControls(mc, _label);
			
			bg.addChild(mc);
	
			return(mc);
		}
		
		public function removeWakeTimeDisplayWithControls():void{
			
			bg.removeChild(wakeTimeDisplay);
			
		}
		
		private function hourPlusBegin(e:MouseEvent):void{
			trace(" hour plus begin");
			
			var min:Number = 60;
			var mSecs:Number = min * 60 * 1000;
			var sum:Number = mSecs + timeWake.getTime();
			var newTime:Date = new Date(sum);
			
			timeWake = newTime;

			trace("timeWake : "+timeWake);
			txtWakeTime.text = DateUtils.getFormattedTime(timeWake);
		}
		
		private function hourMinusBegin(e:MouseEvent):void{
			trace(" hour minus begin");
			var min:Number = -60;
			var mSecs:Number = min * 60 * 1000;
			var sum:Number = mSecs + timeWake.getTime();
			var newTime:Date = new Date(sum);
			
			timeWake = newTime;

			trace("timeWake : "+timeWake);
			txtWakeTime.text = DateUtils.getFormattedTime(timeWake);
		}
		
		private function minutePlusBegin(e:MouseEvent):void{
			trace(" minute plus begin");
			var min:Number = 5;
			var mSecs:Number = min * 60 * 1000;
			var sum:Number = mSecs + timeWake.getTime();
			var newTime:Date = new Date(sum);
			
			timeWake = newTime;

			trace("timeWake : "+timeWake);
			txtWakeTime.text = DateUtils.getFormattedTime(timeWake);
		}
		
		private function minuteMinusBegin(e:MouseEvent):void{
			trace(" minute minus begin");
			var min:Number = -5;
			var mSecs:Number = min * 60 * 1000;
			var sum:Number = mSecs + timeWake.getTime();
			var newTime:Date = new Date(sum);
			
			timeWake = newTime;

			trace("timeWake : "+timeWake);
			txtWakeTime.text = DateUtils.getFormattedTime(timeWake);
		}
		
		public function startTimer():void{
			
			timerCurrentTime.addEventListener(TimerEvent.TIMER, updateCurrentTime);
			timerCurrentTime.start();
			
		}
		
		public function stopTimer():void{
			
			timerCurrentTime.removeEventListener(TimerEvent.TIMER, updateCurrentTime);
			timerCurrentTime.stop();
			
		}
		
		public function updateCurrentTime(e:TimerEvent):void{
			
			var dat:Date = new Date();
			
			txtCurrentTime.text = DateUtils.getFormattedTime(dat);
			timeNow = dat;
			
			checkAlarm();
			
		}
		
		public function checkAlarm():void{
			
			trace("timeWake : "+timeWake+"  || timeNow : "+timeNow);
			
			if(this.alarmOn == true){
				
				var diff:Number = timeWake.getTime() - timeNow.getTime();
				var i:int;
/*				
				if(diff < 0){
					var mSecs:Number = 24 * 60 * 60 * 1000; // 24 hrs * 60 min * 60 sec * 1000 ms == 1 day in ms
					var sum:Number = mSecs + timeWake.getTime();
					var newTime:Date = new Date(sum);
					
					timeWake = newTime;
				}
*/				
				if( diff < 30*60*1000 && diff > 5*60*1000){
					// 30 min * 60 sec * 1000 ms
					for( i=0;i<numChildren;i++){
						if(getChildAt(i) is BouncingBall){
							tintColor(getChildAt(i) as Sprite, 0x0000FF, 0.5);
						}
					}
				}
				
				if( diff < 5*60*1000 && diff > 0){
					// 5 min * 60 sec * 1000 ms
					
					for( i=0;i<numChildren;i++){
						if(getChildAt(i) is BouncingBall){
							tintColor(getChildAt(i) as Sprite, 0xFF0000, 0.5);
						}
					}
				}
				if(timeNow.hours == timeWake.hours && timeNow.minutes == timeWake.minutes){
					
					// keep this all in the same date range to manage duration of alarm signal
					timeWake = timeNow;
					
					for( i=0;i<numChildren;i++){
						if(getChildAt(i) is BouncingBall){
							tintColor(getChildAt(i) as Sprite, 0xFFFF00, 1);
						}
					}
					
				}
			}
		}
		
		private function funPlaceIcon(e:Event):void{

			trace("e.target : "+e.target);
			trace("e.target.parent : "+e.target.parent);
			
			var myLoader:Loader = e.target as Loader;
			trace("myLoader : "+myLoader);
			
			var str:String = "simon";
			
			switch(str){
				case "simon":
					with(myLoader.content){
						width = (stage.stageWidth / 10) * 3;
						scaleY = myLoader.content.scaleX;
						x = (stage.stageWidth / 10) * 2;
						y = (stage.stageHeight / 15) * 10;
					}
					bg.addChild(myLoader.content);
				break;
				default:
					trace("foo");
				break;
			}
					
		}
		
		public function tintColor(sprite:Sprite, colorNum:uint, alphaSet:Number):void {
			var cTint:Color = new Color();
			cTint.setTint(colorNum, alphaSet);
			sprite.transform.colorTransform = cTint;
		}
	}
	
}




