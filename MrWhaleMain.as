package {
    import flash.system.Security;
    Security.allowDomain("*");
	
	import flash.display.Sprite;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.events.Event;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.events.MouseEvent;
	
	import flash.display.MovieClip;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
	
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
			action_txt.addEventListener(MouseEvent.CLICK, actionTxtFocus);
			
        }
				
		private function actionTxtFocus(event:MouseEvent):void{
			    stage.focus = action_txt;
				MovieClip(this.parent.root).disableSpecialKeys();
				MovieClip(this.parent.root).disableRefKeys();
				MovieClip(this.parent.root).disableGameKeys();
				trace("Special Keys Disabled.  INSIDE EXERNAL CHARACTER.");
			
				stage.addEventListener(MouseEvent.CLICK, onClickStage);
				action_txt.removeEventListener(MouseEvent.CLICK, actionTxtFocus);
				action_txt.addEventListener(KeyboardEvent.KEY_DOWN, typedMessage);
				}
				
		private function onClickStage(event:MouseEvent):void {
			if (event.stageX > 180) {
				MovieClip(this.parent.root).enableSpecialKeys();
				MovieClip(this.parent.root).enableRefKeys();
				MovieClip(this.parent.root).enableGameKeys();
				MovieClip(this.parent.root).stageFocus();
				
				trace("Special Keys Enabled. INSIDE EXERNAL CHARACTER.");
				
				stage.removeEventListener(MouseEvent.CLICK, onClickStage);
				action_txt.addEventListener(MouseEvent.CLICK, actionTxtFocus);
				action_txt.removeEventListener(KeyboardEvent.KEY_DOWN, typedMessage);
				}
			}
				
				
		private function sendAction():void {
			
			var string:String = action_txt.text;
			dynamicTxt.text = string;
			viewAction();
			action_txt.text = "";
			trace("sendAction COMPLETED");
			}
			
		private function typedMessage(e:KeyboardEvent):void{
				if (e.keyCode == Keyboard.ENTER){
					sendAction();
					}
			}	
				
		private function viewAction():void{
			
			var string:String;
			string = dynamicTxt.text;

	        switch (string) {	
	            case "char exits":
	            trace("hhhhhhhh");
		        break;
	            case "iiiiiii":
	            trace("iiiiiii");
				break;
				case "ooooooo":
				trace("ooooooo");
				break;
				default:
				trace("viewAction = default");
				newTranslation();
				}	
			}	
				
			
		private function newTranslation():void{
			var EnglishTxt:String;
			EnglishTxt = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=ko&dt=t&q=" + dynamicTxt.text;
			
			var myLoader:URLLoader = new URLLoader();
			myLoader.load(new URLRequest(EnglishTxt));
			myLoader.addEventListener(Event.COMPLETE, slangLoaded);	
			}

        private function slangLoaded(event:Event):void {
			var result:Object = JSON.parse(event.target.data);
			var items:Array = result[0];
			result.splice(-2);
			trace("items[0][0]: " + items[0][0]);
			speechBubble.translatedTxt.text = items[0][0];
			playTranslation();
}
			
        public var vocals_channel:SoundChannel = new SoundChannel();
			

        private function playTranslation():void{
			var vars:URLVariables = new URLVariables();
			vars.q = speechBubble.translatedTxt.text;
			
            var encodedTxt:String = vars.toString();
            var audioLeft:String = "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&" + encodedTxt + "&tl=ko";

            var vocals_isPlaying:Boolean;

            var vocals_snd:Sound = new Sound();

            var vocals_pausePosition:Number = 0;
            var vocals_req:URLRequest = new URLRequest(audioLeft);
			var vocals_context:SoundLoaderContext = new SoundLoaderContext(8000,false);
            vocals_snd.load(vocals_req, vocals_context);

            vocals_playPause();
            vocals_isPlaying = false;

                 function vocals_onPlaybackComplete(event:Event):void {
	                 removeEventListener(Event.ENTER_FRAME, vocals_sync);
	                 vocals_channel.removeEventListener(Event.SOUND_COMPLETE, vocals_onPlaybackComplete);
	                 trace("removeEventListener(Event.ENTER_FRAME, vocals_sync)");
                     }

                 function vocals_playPause() {
	                 if (vocals_isPlaying == true){
					     vocals_pausePosition = vocals_channel.position;
		                 vocals_channel.stop();
					     vocals_isPlaying = false;
					     vocals_channel.removeEventListener(Event.SOUND_COMPLETE, vocals_onPlaybackComplete);
		                 trace("vocals paused");
	                }else{
		                 addEventListener(Event.ENTER_FRAME, vocals_sync);
		                 trace("addEventListener(Event.ENTER_FRAME, vocals_sync)");
		                 vocals_channel = vocals_snd.play(vocals_pausePosition);
		                 vocals_isPlaying = true;
		                 vocals_channel.addEventListener(Event.SOUND_COMPLETE, vocals_onPlaybackComplete);
						 trace("vocals played");
						 }
                     }
}


	    private function vocals_sync(event:Event):void{
	        whale.inside.head.jaw.width = ( Math.round(vocals_channel.leftPeak * -30) ) + whale.inside.head.jaw.frame.width;
	        whale.inside.head.jaw.height = ( Math.round(vocals_channel.leftPeak * -100) ) + whale.inside.head.jaw.frame.height;
	
	        whale.inside.head.mouthHole.width = ( Math.round(vocals_channel.leftPeak * -90) ) + whale.inside.head.mouthHole.frame.width;
	        whale.inside.head.mouthHole.height = ( Math.round(vocals_channel.leftPeak * 100) ) + whale.inside.head.mouthHole.frame.height;
	        whale.inside.head.mouthHole.y = ( Math.round(vocals_channel.leftPeak * 50) ) + whale.inside.head.mouthHoleMarker.y;
	
	        whale.inside.head.skull.width = ( Math.round(vocals_channel.leftPeak * -10) ) + whale.inside.head.skull.frame.width;
	        whale.inside.head.skull.height = ( Math.round(vocals_channel.leftPeak * 10) ) + whale.inside.head.skull.frame.height;
	
	        whale.inside.body.inside.y = ( Math.round(vocals_channel.leftPeak * -10) ) + 0;
            }

		
		private function whooshSFX() {
			MovieClip(this.parent.root).play_whoosh();
			}
		
		private function char_enter() {
			TweenMax.to(whale, 0.2, {onComplete: whooshSFX});
			TweenMax.to(whale.inside, 1, {y:0, ease:Strong.easeOut});
			}
			
		private function removeCharFromParent() {
				MovieClip(this.parent.root).charOnOff();
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
