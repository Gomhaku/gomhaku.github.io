package  {
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
	
	public class MrWhaleMain extends Sprite 
	{
	//DISABLE SPECIAL KEYS AND FOCUS STAGE
private function actionTxtFocus():void{
if (MovieClip(this.parent.parent.parent) != null){
		 MovieClip(this.parent.parent.parent).disableSpecialKeys();
		 MovieClip(this.parent.parent.parent).disableRefKeys();
		 MovieClip(this.parent.parent.parent).disableGameKeys();
	
		 trace("Special Keys Disabled.  INSIDE EXERNAL CHARACTER.");
		
		stage.addEventListener(MouseEvent.CLICK, onClickStage);
	}	
    stage.focus = action_txt;
}

//actionTxtFocus();

action_txt.addEventListener(MouseEvent.CLICK, txtFocusIn )
private function txtFocusIn( e:MouseEvent ):void{
	actionTxtFocus();		
}

//stage.addEventListener(MouseEvent.CLICK, onClickStage);
private function onClickStage(event:MouseEvent):void {
    if (event.stageX > 180) {
			MovieClip(this.parent.parent.parent).enableSpecialKeys();
			MovieClip(this.parent.parent.parent).enableRefKeys();
			MovieClip(this.parent.parent.parent).enableGameKeys();
			
			MovieClip(this.parent.parent.parent).stageFocus();
			
			trace("Special Keys Enabled. INSIDE EXERNAL CHARACTER.");	
			
			stage.removeEventListener(MouseEvent.CLICK, onClickStage);
		}
}


//MESSAGE TRANSLATION
speechBubble.alpha = 0.5;

resendMessage_btn.addEventListener(MouseEvent.CLICK, resendMessage);
private function resendMessage (e:MouseEvent):void{
	action_txt.text = dynamicTxt.text
	sendAction();
}

action_txt.text = "";
stage.focus = action_txt;

private function sendAction():void{
	private var string:String = action_txt.text;

	dynamicTxt.text = string;
	viewAction();
    
    //stage.focus = action_txt;
	action_txt.text = "";
    //action_txt.setSelection(0, 0);
	//action_txt.selectionBeginIndex;*/
	/*if (action_txt) {
    action_txt.text = "";
    action_txt.setSelection(0, 0);
    trace("Selection Begin Index: " + action_txt.selectionBeginIndex);
    stage.focus = action_txt;
}*/
	trace("sendAction COMPLETED");
}

action_txt.addEventListener(KeyboardEvent.KEY_DOWN, typedMessage);
private function typedMessage(e:KeyboardEvent):void{
	if (e.keyCode == Keyboard.ENTER){
	sendAction();
	}
}


//2. GET THE ENGISH TEXT FROM SENDER
private function viewAction():void{
	var string:String;
	string = dynamicTxt.text;

	switch (string) {	
	case "char exits":
		//char_exit();
	   trace("hhhhhhhh");
		break;
	case "iiiiiii":
		//into_headShake();
	     trace("iiiiiii");
		break;
	case "ooooooo":
		//headShrug();
	     trace("ooooooo");
		break;
	default:
	trace("default");
	newTranslation();
	}	
}	

private function newTranslation():void{
private var EnglishTxt:String;
EnglishTxt = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=en&tl=ko&dt=t&q=" + dynamicTxt.text;

private var myLoader:URLLoader = new URLLoader();
myLoader.load(new URLRequest(EnglishTxt));
myLoader.addEventListener(Event.COMPLETE, slangLoaded);	
}

private function slangLoaded(event:Event):void {
	private var result:Object = JSON.parse(event.target.data); // parse the JSON data
    private var items:Array = result[0]; // retrieve the items array
	result.splice(-2);
	//trace("result: " + result);
	trace("items[0][0]: " + items[0][0]);
	
	speechBubble.translatedTxt.text = items[0][0];
	
	playTranslation();
}

var vocals_channel:SoundChannel = new SoundChannel();

private function playTranslation():void
{
//RECEIVED KOREAN TRANSLATION.... NOW LOAD/PLAY KOREAN MP3 FROM TRANSLATE.GOOGLE
//convert korean translation into readable UTF-8 URL
 private var vars:URLVariables = new URLVariables();
//vars.param1 = "고양이가있다";
vars.q = speechBubble.translatedTxt.text;
//trace("vars.toString: " + vars.toString());

private var encodedTxt:String = vars.toString();
//var dynamicTxtString:String = vars.toString();
private var audioLeft:String = "http://translate.google.com/translate_tts?ie=UTF-8&total=1&idx=0&textlen=32&client=tw-ob&" + encodedTxt + "&tl=ko";
//trace("audioLeft: " + audioLeft);

// load vocals voice
private var vocals_bytes:ByteArray = new ByteArray();
private var vocals_isPlaying:Boolean;

private var vocals_snd:Sound = new Sound();

private var vocals_pausePosition:Number = 0;
private var vocals_req:URLRequest = new URLRequest(audioLeft);
private var vocals_context:SoundLoaderContext = new SoundLoaderContext(8000,false);
vocals_snd.load(vocals_req, vocals_context);

//vocals_channel = vocals_snd.play();
vocals_playPause();
vocals_isPlaying = false;

/*********************************************************************/
//on playback complete
/*********************************************************************/
private function vocals_onPlaybackComplete(event:Event):void {
	removeEventListener(Event.ENTER_FRAME, vocals_sync);
	vocals_channel.removeEventListener(Event.SOUND_COMPLETE, vocals_onPlaybackComplete);
	trace("removeEventListener(Event.ENTER_FRAME, vocals_sync)");
}
/*********************************************************************/
//artist voice play/pause function
/*********************************************************************/
private function vocals_playPause()
{
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


//hide frames and markers
whale.inside.head.mouthHoleMarker.visible = false;
//hide frames
whale.inside.head.jaw.frame.visible = false;
whale.inside.head.mouthHole.frame.visible = false;
whale.inside.head.skull.frame.visible = false;

//lipsync
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



private function randomRange(min:Number, max:Number):Number
{
	return Math.random() * (max - min) + min;
}


private function play_whoosh2():void
{
	MovieClip(this.parent.parent.parent).play_whoosh();
}

/*********************************************************************/
//char enters
/*********************************************************************/
private function char_enter():void
{
	//SFX
	play_whoosh2();
	
	TweenMax.to(whale.inside, 1, {y:0, ease:Strong.easeOut});
}

char_enter();

/*********************************************************************/
//remove this external swf
/*********************************************************************/
private function removeCharFromParent()
{
	MovieClip(this.parent.parent.parent).charOnOff();
}

charExit_btn.addEventListener(MouseEvent.CLICK, _charExit_btn);
private function _charExit_btn(event:MouseEvent):void
{
	//SFX
	TweenMax.to(whale, 0.5, {onComplete: play_whoosh2});
	
	TweenMax.to(whale.inside, 1, {y: 470, ease:Strong.easeIn, onComplete: removeCharFromParent});
}

/*********************************************************************/
//char random eye blink
/*********************************************************************/

private function char_blink():void
{
	whale.inside.head.eyes.inside.left.gotoAndPlay(2);
	whale.inside.head.eyes.inside.right.gotoAndPlay(2);
	
	TweenMax.fromTo(whale.inside.head,0.5,
	{scaleX: 1.01, scaleY: 0.99},
	{scaleX: 1, scaleY: 1, yoyo: true, ease:Back.easeIn});
	
	TweenMax.to(whale.inside.head.eyes,randomRange(3,8),{onComplete: char_blink});
}

char_blink();
	

}

