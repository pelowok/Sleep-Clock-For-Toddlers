package com.mynameiszak.ExternalLoader {
	
	import flash.display.Loader;
	import flash.system.LoaderContext;
	import flash.net.URLRequest;
	import flash.events.AsyncErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.ErrorEvent;
	
	public class ExternalLoader {
		
		public static var context:LoaderContext = new LoaderContext();
		public static var url:URLRequest;
		public static var loader:Loader = new Loader();
		
		public static function tryLoad(_url:String):Loader {
			
			context.checkPolicyFile = true; 
			
			url = new URLRequest(_url);
			
			loader.addEventListener(AsyncErrorEvent.ASYNC_ERROR, errorHandlerAsyncErrorEvent);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandlerIOErrorEvent);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerSecurityErrorEvent);
			loader.contentLoaderInfo.addEventListener(Event.INIT, initHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, infoIOErrorEvent);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressListener);
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
			
			loader.load( url,context );
			loader.load( url);
			
			return loader;
			
		}

		private static function progressListener (e:ProgressEvent):void{
		   trace("Downloaded " + e.bytesLoaded + " out of " + e.bytesTotal + " bytes");
		}
		private static function initHandler( e:Event ):void{
		  trace( 'load init' );
		}
		private static function errorHandlerErrorEvent( e:ErrorEvent ):void{
		  trace( 'errorHandlerErrorEvent ' + e.toString() );
		}
		private static function infoIOErrorEvent( e:IOErrorEvent ):void{
		  trace( 'infoIOErrorEvent ' + e.toString() );
		}
		private static function errorHandlerIOErrorEvent( e:IOErrorEvent ):void{
		  trace( 'errorHandlerIOErrorEvent ' + e.toString() );
		}
		private static function errorHandlerAsyncErrorEvent( e:AsyncErrorEvent ) :void{
		  trace( 'errorHandlerAsyncErrorEvent ' + e.toString() );
		}
		private static function errorHandlerSecurityErrorEvent( e:SecurityErrorEvent ):void{
		  trace( 'errorHandlerSecurityErrorEvent ' + e.toString(
																) );
		}
		private static function onLoadComplete( e:Event ):void{
		  trace( 'onLoadComplete' );
			
			loader.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, errorHandlerAsyncErrorEvent);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, errorHandlerIOErrorEvent);
			loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandlerSecurityErrorEvent);
			loader.contentLoaderInfo.removeEventListener(Event.INIT, initHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, infoIOErrorEvent);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, progressListener);
			
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoadComplete);
			
		}

	}
	
}
