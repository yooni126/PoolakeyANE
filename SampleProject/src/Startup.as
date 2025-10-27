package {

    import MainMenuPage.data.PubValue;
    import com.marpies.utils.Constants;
    import feathers.utils.ScreenDensityScaleFactorManager;
    import flash.display.Stage;
    import flash.display.StageOrientation;
    import flash.text.TextFormat;
    import flash.ui.Multitouch;
    import flash.ui.MultitouchInputMode;
    import flash.desktop.NativeApplication;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageDisplayState;
    import flash.display.StageScaleMode;
    import flash.display3D.Context3DProfile;
    import flash.events.Event;
    import flash.utils.clearInterval;
    import flash.utils.setTimeout;
    import starling.events.Event;
    import starling.core.Starling;


    [SWF(frameRate = "60", backgroundColor = "#ffffff")]
    public class Startup extends Sprite {
        private var mStarling:Starling;
        private var mScaler:ScreenDensityScaleFactorManager;
        private var mTimeoutId:int = -1;
        private var mainAppStarted:Boolean = false;

        public function Startup() {
            stage.align = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
            if (stage)
				initSplash()
			else
				addEventListener(flash.events.Event.ADDED_TO_STAGE, initSplash);
            
        }

        private function initSplash():void {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, initSplash);
            stage.addEventListener(flash.events.Event.RESIZE, onStageResize);
            mTimeoutId = setTimeout(initStarling, 1000);
        }
        private function onStageResize(event:flash.events.Event):void {
            stage.removeEventListener(flash.events.Event.RESIZE, onStageResize);
            if (mTimeoutId != -1) {
                clearInterval(mTimeoutId);
            }
            mTimeoutId = setTimeout(initStarling, 50);

        }

        /**
         *
         *
         * Initialization
         *
         *
         */

        private function initStarling():void {
            /* Initialize and start the Starling instance */
            mStarling = new Starling(MainApp, stage, null, null, "auto", Context3DProfile.BASELINE);
            mStarling.simulateMultitouch = true;
            mStarling.skipUnchangedFrames = true;
            mStarling.showStats = false;
            //mStarling.showStatsAt("right", "bottom");
            mScaler = new ScreenDensityScaleFactorManager(mStarling);

            /* Initialize Constants */
            Constants.init(mStarling.stage.stageWidth, mStarling.stage.stageHeight);
            mStarling.addEventListener(starling.events.Event.ROOT_CREATED, onStarlingReady);

            /* Handle application Activation & Deactivation */
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, onActivate);
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.DEACTIVATE, onDeactivate);

        }

        /**
         *
         *
         * Signal / Event handlers
         *
         *
         */

        private function onStarlingReady(event:starling.events.Event, mainApp:MainApp):void {
            mStarling.removeEventListener(starling.events.Event.ROOT_CREATED, onStarlingReady);
            /* Start Starling */
            mStarling.start();
            if (!mainAppStarted) {
                mainApp.start();
                mainAppStarted = true;
            }

        }



        /**
         *
         *
         * Application activate/deactivate handlers
         *
         *
         */

        private function onActivate(event:flash.events.Event):void {
            mStarling.start();
        }

        private function onDeactivate(event:flash.events.Event):void {

            mStarling.stop(true);
        }

    }

}
