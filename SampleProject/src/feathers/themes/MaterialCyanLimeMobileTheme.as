/*
 Copyright 2015-2016 Marcel Piestansky, http://marpies.com
 */
package feathers.themes {

    import flash.display.Bitmap;
    import flash.display.BitmapData;

    import starling.events.Event;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    /**
     * The "Material Cyan Lime" theme for mobile Feathers apps.
     *
     * <p>This version of the theme embeds its assets. To load assets at
     * runtime, see <code>MaterialCyanLimeMobileThemeWithAssetManager</code> instead.</p>
     */
    public class MaterialCyanLimeMobileTheme extends BaseMaterialCyanLimeMobileTheme {

        [Embed(source="/../assets/xml/material_cyan_lime_mobile.xml", mimeType="application/octet-stream")]
        private static const ATLAS_XML:Class;
        [Embed(source="/../assets/images/material_cyan_lime_mobile.png")]
        private static const ATLAS_BITMAP:Class;

        public function MaterialCyanLimeMobileTheme() {
            super();

            initialize();
            dispatchEventWith( Event.COMPLETE );
        }

        override protected function initialize():void {
            initializeTextureAtlas();
            super.initialize();
        }

        protected function initializeTextureAtlas():void {
            /* UI Texture Atlas */
            var atlasBitmapData:BitmapData = Bitmap( new ATLAS_BITMAP() ).bitmapData;
            var atlasTexture:Texture = Texture.fromBitmapData( atlasBitmapData, false, false, 2 );
            atlasTexture.root.onRestore = onAtlasTextureRestore;
            atlasBitmapData.dispose();
            mAtlas = new TextureAtlas(
                    atlasTexture,
                    XML( new ATLAS_XML() )
            );
        }

        private function onAtlasTextureRestore():void {
            var atlasBitmapData:BitmapData = Bitmap( new ATLAS_BITMAP() ).bitmapData;
            mAtlas.texture.root.uploadBitmapData( atlasBitmapData );
            atlasBitmapData.dispose();
        }

    }

}
