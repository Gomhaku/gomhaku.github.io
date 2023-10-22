package {
    import flash.system.Security;
    Security.allowDomain("*");
	
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.events.MouseEvent;
	
	import com.greensock.*;
    import com.greensock.easing.*;  


    public class MrWhaleMain extends Sprite {
		trace("HELLO 01");

		public function MrWhaleMain() {
           whale.inside.head.mouthHoleMarker.visible = false;
			whale.inside.head.jaw.frame.visible = false;
			whale.inside.head.mouthHole.frame.visible = false;
			whale.inside.head.skull.frame.visible = false; 
			char_enter();
			yellowCover.addEventListener(MouseEvent.CLICK, onStopHandler);
			charExit_btn.addEventListener(MouseEvent.CLICK, _charExit_btn);
        }
		
		private function whooshSFX() {
				MovieClip(this.parent.parent.parent).play_whoosh();
			}
		
		private function char_enter() {
			TweenMax.to(whale, 0.2, {onComplete: whooshSFX});
			TweenMax.to(whale.inside, 1, {y:0, ease:Strong.easeOut});
			}
			
		private function removeCharFromParent() {
				MovieClip(this.parent.parent.parent).charOnOff();
			}
			
		private function _charExit_btn(event:MouseEvent):void {
			TweenMax.to(whale, 0.5, {onComplete: whooshSFX});
			TweenMax.to(whale.inside, 1, {y: 470, ease:Strong.easeIn, onComplete: removeCharFromParent});
			}


		private function onStopHandler(event:MouseEvent):void {
            trace("HELLO 02");
            }

	
		
       trace("HELLO 03");
    }
}
