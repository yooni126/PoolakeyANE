package {
    import starling.display.Sprite;
    import feathers.controls.ScreenNavigator;
    import feathers.themes.MaterialCyanLimeMobileThemeWithIcons;
    import feathers.controls.ScreenNavigatorItem;
    import feathers.motion.Slide;
    import MainMenuPage.screens.inAppProducts;
    import MainMenuPage.screens.InAppProducts;

    /**
     * ...
     * @author Younes Mashayekhi
     */
    public class MainApp extends Sprite {
        private var _navigator:ScreenNavigator;

        public function MainApp() {
            super();
        }

        public function start():void {
            new MaterialCyanLimeMobileThemeWithIcons();
            _navigator = new ScreenNavigator();


            var mainMenuPage:ScreenNavigatorItem = new ScreenNavigatorItem(InAppProducts);
            this._navigator.addScreen("mainMenu", mainMenuPage);
            _navigator.showScreen("mainMenu");
            this.addChild(_navigator)

        }

    }

}
