package com.mynameiszak.SleepClock  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.GradientType;
	
	public class BouncingBall {

		private static var ball:Sprite = new Sprite;
		private static var startMoving:Boolean = false;
		private static var movementX:Number = 1;
		private static var movementY:Number = 1;
		private static var maxX:Number;
		private static var maxY:Number;
		
		
		public static function newBall(diameter:uint, color1:uint, color2:uint, maximumX:Number, maximumY:Number):Sprite {
			
			maxX = maximumX;
			maxY = maximumY;
			
			var arrColors:Array = new Array(color1, color2);
			var arrAlphas:Array = new Array(0.5, 0.2);
			var arrRatios:Array = new Array(64, 192);
			ball.graphics.beginGradientFill(GradientType.RADIAL, arrColors, arrAlphas, arrRatios);
			ball.graphics.drawCircle(0, 0, diameter);
			ball.graphics.endFill();

			ball.addEventListener(Event.ENTER_FRAME, main);
			ball.addEventListener(MouseEvent.CLICK, beginMove);
			
			return ball;
		
		}

		private static function main(event:Event):void{
			setMovement();
			bounceWalls();
		}

		private static function setMovement():void{
			if(startMoving == true){
				ball.x += movementX;
				ball.y += movementY;
			}else{
				ball.x -= movementX;
				ball.y -= movementY;
			}
		}
		private static function bounceWalls():void{
			if(ball.x < 5 || ball.y < 5){
				getXAndY();
				startMoving = true;
			}
			if(ball.x > maxX - ball.width - 5 || ball.y > maxY - ball.height - 5 ){
				getXAndY();
				startMoving = false;
			}
		}

		private static function beginMove(event:MouseEvent):void{
			if(startMoving){
				getXAndY();
				startMoving = false;
			}else{
				getXAndY();
				startMoving = true;
			}
		}

		private static function getXAndY():void{
				movementX = Math.round(Math.random()*5);
				movementY = Math.round(Math.random()*5);
		}

	}
	
}
