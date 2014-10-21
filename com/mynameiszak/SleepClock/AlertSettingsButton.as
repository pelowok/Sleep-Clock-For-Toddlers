package com.mynameiszak.SleepClock {
	
	import flash.display.MovieClip;
	import fl.ImportFlashClasses;
	
	public class AlertSettingsButton {

		public function AlertSettingsButton() {
			// constructor code
		}
		
		public function addTimeDisplay():void{
			
			var strTimeNow:String = DateUtils.getFormattedTime(new Date);
			
			var mc:MovieClip = TimeDisplay.makeLabel(strTimeNow, clock.stage.stageHeight / 15, 0xFFFF00);
			
			clock.addChild(mc);

			clock.txtCurrentTime = mc.getChildAt(0) as TextField;

			mc.x = ( clock.stage.stageWidth / 2 ) - ( mc.width / 2 );
			mc.y = ( clock.stage.stageHeight / 10 ) * 1;
						
			timerCurrentTime.addEventListener(TimerEvent.TIMER, updateCurrentTime);
			timerCurrentTime.start();
			
		}

	}
	
}
