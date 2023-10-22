package {
    import flash.system.Security;
    Security.allowDomain("*");

    import flash.display.Sprite;
    import flash.media.Sound;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.media.SoundChannel;
    import flash.events.MouseEvent;

    public class music_bars extends Sprite {

        private var sound:Sound; // Store the sound data
        private var channel:SoundChannel; // Create sound channel Object
        private var isPlaying:Boolean = false; // Track the play/pause state

        public function music_bars() {
            // Create new data store and load external sound
            sound = new Sound(new URLRequest("https://gomhaku.github.io/sound.mp3"));

            play_btn.addEventListener(MouseEvent.CLICK, onPlayHandler);
            stop_btn.addEventListener(MouseEvent.CLICK, onStopHandler);
        }

        private function onPlayHandler(event:MouseEvent):void {
            if (isPlaying) {
                // If currently playing, pause
                channel.stop();
                isPlaying = false;
            } else {
                // If not playing, start playing
                channel = sound.play();
                isPlaying = true;
                addEventListener(Event.ENTER_FRAME, animateBars);
            }
        }

        private function onStopHandler(event:MouseEvent):void {
            removeEventListener(Event.ENTER_FRAME, animateBars);
            graphics.clear();
            channel.stop();
            isPlaying = false;
        }

        private function animateBars(event:Event):void {
            // Clear existing graphics.
            graphics.clear();
            graphics.beginFill(0xAB300C, 1);

            // Sound channel object leftPeak and rightPeak properties - left right stereo-balance
            graphics.drawRect(190, 300, 50, -channel.leftPeak * 160);
            graphics.endFill();

            graphics.beginFill(0xAB300C, 1);
            graphics.drawRect(250, 300, 50, -channel.rightPeak * 160);
            graphics.endFill();
        }
    }
}
