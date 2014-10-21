package com.mynameiszak.SleepClock {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.mynameiszak.SleepClock.SleepClock;
	import com.mynameiszak.SleepClock.DateUtils;
	import com.mynameiszak.SleepClock.TimeDisplay;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	
	public class TimeDisplayButton extends MovieClip {

		public var clock:SleepClock;
		
		public function TimeDisplayButton() {
			// constructor code
			onInit();
		}
		
		private function onInit():void{
			
			var mc:MovieClip = new MovieClip();
			mc.graphics.beginFill(0xFFFFFF, 0.25);
			mc.graphics.drawCircle(0, 0, 50);
			mc.graphics.endFill();
			addChild(mc);
			
			mc.addEventListener(MouseEvent.CLICK, toggleCurrentTimeDisplay);
			
		}
		
		private function toggleCurrentTimeDisplay(e:MouseEvent):void{

			if(clock.txtCurrentTime.stage){
				trace("true");
				removeTimeDisplay();
			//	clock.removeWakeTimeDisplayWithControls();
				clock.wakeTimeDisplay.visible = false;
				clock.alarmOn = true;
			} else {
				trace("false");
				addTimeDisplay();
			//	clock.wakeTimeDisplay = clock.addWakeTimeDisplayWithControls(clock.wakeTimeDisplay, "wakeTimeDisplay");
				clock.wakeTimeDisplay.visible = true;
				clock.alarmOn = false;
			}
			trace("clock.alarmOn : "+clock.alarmOn);
		}
		
		public function addTimeDisplay():void{
			
			var strTimeNow:String = DateUtils.getFormattedTime(new Date);
			
			var lbl:MovieClip = TimeDisplay.makeLabel("current time:", clock.stage.stageHeight / 30, 0xFFFF00);
			var mc:MovieClip = TimeDisplay.makeLabel(strTimeNow, clock.stage.stageHeight / 15, 0xFFFF00);
			
			mc.addChild(lbl);
			lbl.y = (clock.stage.stageHeight / 30) * -1;
			
			clock.addChild(mc);

			clock.txtCurrentTime = mc.getChildAt(0) as TextField;

			mc.x = ( clock.stage.stageWidth / 2 ) - ( mc.width / 2 );
			mc.y = ( clock.stage.stageHeight / 10 ) * 1;
						
		//	clock.startTimer();
			
		}
		
		public function removeTimeDisplay():void{
			
		//	clock.stopTimer();

			var mc:MovieClip = clock.txtCurrentTime.parent as MovieClip;
			//mc.removeChild(mc.txtCurrentTime);
			clock.removeChild(mc);
			
		}

	}
	
}
