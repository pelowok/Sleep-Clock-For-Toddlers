package com.mynameiszak.SleepClock {
	
	import flash.desktop.NativeApplication;	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
		import flash.display.GradientType;
	
	public class ExitButton extends MovieClip {

		public function ExitButton() {
			// constructor code
			onInit();
		}
		
		private function onInit():void{
			
			var mc:MovieClip = new MovieClip();
			with(mc){
				graphics.beginFill(0xFFFFFF,0.25);
				graphics.drawCircle(0, 0, 50);
				graphics.endFill();
			}
			
			addChild(mc);
			
			mc.addEventListener(MouseEvent.CLICK, exitHandler );
			
		}
     

		private function exitHandler (event:MouseEvent):void {
			
		  NativeApplication.nativeApplication.exit(); 
			
		}
		
	} // close class
	
} // close package
