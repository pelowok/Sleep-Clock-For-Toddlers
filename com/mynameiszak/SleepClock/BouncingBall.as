package com.mynameiszak.SleepClock  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.GradientType;
	
	public class BouncingBall extends Sprite {

		private var ball:Sprite = new Sprite;
		private var startMoving:Boolean = false;
		private var movementX:Number = 1;
		private var movementY:Number = 1;
		private var maxX:Number;
		private var maxY:Number;
		private var clock:SleepClock;
		
		public function BouncingBall( sleepClock:SleepClock, diameter:uint, color1:uint, color2:uint) {
			
			clock = sleepClock;
			addChild(newBall(diameter, color1, color2));
			
		}
		
		public function newBall(diameter:uint, color1:uint, color2:uint):Sprite {
			
			var arrColors:Array = new Array(color1, color2);
			var arrAlphas:Array = new Array(0.5, 0.2);
			var arrRatios:Array = new Array(64, 192);
			ball.graphics.beginGradientFill(GradientType.RADIAL, arrColors, arrAlphas, arrRatios);
			ball.graphics.drawCircle(0, 0, diameter);
			ball.graphics.endFill();

			ball.addEventListener(Event.ENTER_FRAME, main);
			ball.addEventListener(MouseEvent.CLICK, remove);
			
			return ball;
		
		}

		private function main(event:Event):void{
			setMovement();
			bounceWalls();
		}

		private function setMovement():void{
/*
			if(startMoving == true){
				ball.x += movementX;
				ball.y += movementY;
			}else{
				ball.x -= movementX;
				ball.y -= movementY;
			}
*/
			if(startMoving == true){
				this.x += movementX;
				this.y += movementY;
			}else{
				this.x -= movementX;
				this.y -= movementY;
			}
		}
		private function bounceWalls():void{
			if(this.x < 0 || this.y < 0){
		//	if( this.x > (clock.bg.width - (ball.width/2)) || this.y > (clock.bg.height - (ball.height/2)) ) {
				getXAndY();
				startMoving = true;
			}
			if( this.x > clock.bg.width  ||  this.y > 0 + clock.bg.height ){
		//	if( this.x < ( 0 + (ball.width/2) ) || ( this.y < 0 + (ball.height/2) ) ){
				getXAndY();
				startMoving = false;
			}
		}

		private function beginMove(event:MouseEvent):void{
			if(startMoving){
				getXAndY();
				startMoving = false;
			}else{
				getXAndY();
				startMoving = true;
			}
		}

		private function getXAndY():void{
				movementX = Math.round(Math.random()*3);
				movementY = Math.round(Math.random()*3);
		}

		private function remove(e:MouseEvent):void{
			this.parent.removeChild(this);
		}
	}
	
}
