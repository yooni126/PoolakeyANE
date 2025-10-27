package MainMenuPage.data {
    import starling.extensions.RTL_BitmapFont.RTLTextField;
    import starling.text.TextField;
    import starling.textures.Texture;

    /**
     * ...
     * @author Younes Mashayekhi
     */
    public class Fonts {

        [Embed(source = "../assets/fonts/PYekan.ttf", fontFamily = "Yekan", fontWeight = "normal", mimeType = "application/x-font", embedAsCFF = "true")]
        private static const YEKAN:Class;
        [Embed(source = "../assets/fonts/P NAZANIN.TTF", fontFamily = "Nazanin", fontWeight = "normal", mimeType = "application/x-font", embedAsCFF = "true")]
        private static const NAZANIN:Class;
        [Embed(source = "../assets/fonts/P NAZANINBOLD.TTF", fontFamily = "NazaninBold", fontWeight = "normal", mimeType = "application/x-font", embedAsCFF = "true")]
        private static const NAZANIN_BOLD:Class;

        public static const FONT_YEKAN:String = "Yekan";
        public static const FONT_NAZANIN:String = "Nazanin";
        public static const FONT_NAZANIN_BOLD:String = "NazaninBold";

    }

}
