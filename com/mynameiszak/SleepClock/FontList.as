// FontList.as
package com.mynameiszak.SleepClock {
    
    import flash.text.Font;
    import flash.text.FontType;
    import flash.text.FontStyle;
    
    public class FontList {
		
        public function FontList() {
			
			

        }
        
		public static function listSystemFonts():void{
			
			trace(Font.enumerateFonts());
			
		}

    }
}
