package  {
	import flash.system.Security;
	Security.allowDomain("*");
	
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.events.MouseEvent;
	
	
	
	public class music_bars extends Sprite {
		
		private var sound:Sound //store the sound data
		private var channel:SoundChannel;//create sound channel Object
		
		public function music_bars() {
			
			//create new data store and load external sound
			sound = new Sound(new URLRequest("https://gomhaku.github.io/sound.mp3"));
			//sound = new Sound(new URLRequest("../sound.mp3"));
			play_btn.addEventListener(MouseEvent.CLICK,onPlayHandler);
			stop_btn.addEventListener(MouseEvent.CLICK,onStopHandler);
			
		}
		
		private function onPlayHandler(event:MouseEvent):void{
			channel = sound.play(0,1000);
			addEventListener(Event.ENTER_FRAME,animateBars);
		}
		
		private function onStopHandler(event:MouseEvent):void{
			removeEventListener(Event.ENTER_FRAME,animateBars);
			graphics.clear();
			channel.stop();
		}
		
		private function animateBars(event:Event):void{
			//clear existing graphics.
			graphics.clear();
			graphics.beginFill(0xAB300C,1);
			
			//sound chennel object leftPeak and rightPeak properties - left right stereo-balance
			graphics.drawRect(190,300,50,-channel.leftPeak * 160 );
			graphics.endFill();
			
			graphics.beginFill(0xAB300C,1);
			graphics.drawRect(250,300,50,-channel.rightPeak  * 160 );
			graphics.endFill(); 
		}
	}
}
