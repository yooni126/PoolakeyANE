// =================================================================================================
//
//	MyFLashLab Team www.myflashlabs.com
//	Copyright 2014 All Rights Reserved.
//
//	Based on Starling Framework BitmapFont TextField 
//
//	This program is free software. You can redistribute and/or modify it
//	in accordance with the terms of the accompanying license agreement.
//
// =================================================================================================

package starling.extensions.RTL_BitmapFont
{
    import flash.geom.Rectangle;
    import flash.utils.Dictionary;

    import starling.display.Image;
    import starling.display.MeshBatch;
    import starling.display.Sprite;
    import starling.textures.Texture;
    import starling.textures.TextureSmoothing;
    import starling.utils.Align;

    
    public class RTLBitmapFont
    {
        
        public static const NATIVE_SIZE:int = -1;
        
       
        public static const MINI:String = "mini";
        
        private static const CHAR_SPACE:int           = 32;
        private static const CHAR_TAB:int             =  9;
        private static const CHAR_NEWLINE:int         = 10;
        private static const CHAR_CARRIAGE_RETURN:int = 13;
        
        private var mTexture:Texture;
        private var mChars:Dictionary;
        private var mName:String;
        private var mSize:Number;
        private var mLineHeight:Number;
        private var mBaseline:Number;
        private var mOffsetX:Number;
        private var mOffsetY:Number;
        private var mHelperImage:Image;
        private var mCharLocationPool:Vector.<CharLocation>;
        
		private var _rightToLeft:Boolean = true;/**/
		
       
        public function RTLBitmapFont(texture:Texture=null, fontXml:XML=null)
        {
           
            if (texture == null && fontXml == null)
            {
                texture = MiniBitmapFont.texture;
                fontXml = MiniBitmapFont.xml;
            }
            
            mName = "unknown";
            mLineHeight = mSize = mBaseline = 14;
            mOffsetX = mOffsetY = 0.0;
            mTexture = texture;
            mChars = new Dictionary();
            mHelperImage = new Image(texture);
            mCharLocationPool = new <CharLocation>[];
            
            if (fontXml) parseFontXml(fontXml);
        }
        
    
        public function dispose():void
        {
            if (mTexture)
                mTexture.dispose();
        }
        
        private function parseFontXml(fontXml:XML):void
        {
            var scale:Number = mTexture.scale;
            var frame:Rectangle = mTexture.frame;
            var frameX:Number = frame ? frame.x : 0;
            var frameY:Number = frame ? frame.y : 0;
            
            mName = fontXml.info.attribute("face");
            mSize = parseFloat(fontXml.info.attribute("size")) / scale;
            mLineHeight = parseFloat(fontXml.common.attribute("lineHeight")) / scale;
            mBaseline = parseFloat(fontXml.common.attribute("base")) / scale;
            
            if (fontXml.info.attribute("smooth").toString() == "0")
                smoothing = TextureSmoothing.NONE;
            
            if (mSize <= 0)
            {
                trace("[Starling] Warning: invalid font size in '" + mName + "' font.");
                mSize = (mSize == 0.0 ? 16.0 : mSize * -1.0);
            }
            
            for each (var charElement:XML in fontXml.chars.char)
            {
                var id:int = parseInt(charElement.attribute("id"));
                var xOffset:Number = parseFloat(charElement.attribute("xoffset")) / scale;
                var yOffset:Number = parseFloat(charElement.attribute("yoffset")) / scale;
                var xAdvance:Number = parseFloat(charElement.attribute("xadvance")) / scale;
                
                var region:Rectangle = new Rectangle();
                region.x = parseFloat(charElement.attribute("x")) / scale + frameX;
                region.y = parseFloat(charElement.attribute("y")) / scale + frameY;
                region.width  = parseFloat(charElement.attribute("width")) / scale;
                region.height = parseFloat(charElement.attribute("height")) / scale;
                
                var texture:Texture = Texture.fromTexture(mTexture, region);
                var bitmapChar:BitmapChar = new BitmapChar(id, texture, xOffset, yOffset, xAdvance); 
                addChar(id, bitmapChar);
            }
            
            for each (var kerningElement:XML in fontXml.kernings.kerning)
            {
                var first:int = parseInt(kerningElement.attribute("first"));
                var second:int = parseInt(kerningElement.attribute("second"));
                var amount:Number = parseFloat(kerningElement.attribute("amount")) / scale;
                if (second in mChars) getChar(second).addKerning(first, amount);
            }
        }
        
        
        public function getChar(charID:int):BitmapChar
        {
            return mChars[charID];   
        }
        
      
        public function addChar(charID:int, bitmapChar:BitmapChar):void
        {
            mChars[charID] = bitmapChar;
        }
        
       
        public function createSprite(width:Number, height:Number, text:String,
                                     fontSize:Number=-1, color:uint=0xffffff, 
                                     hAlign:String="center", vAlign:String="center",      
                                     autoScale:Boolean=true, 
                                     kerning:Boolean=true):Sprite
        {
            var charLocations:Vector.<CharLocation> = arrangeChars(width, height, text, fontSize, 
                                                                   hAlign, vAlign, autoScale, kerning);
            var numChars:int = charLocations.length;
            var sprite:Sprite = new Sprite();
            
            for (var i:int=0; i<numChars; ++i)
            {
                var charLocation:CharLocation = charLocations[i];
                var char:Image = charLocation.char.createImage();
                char.x = charLocation.x;
                char.y = charLocation.y;
                char.scaleX = char.scaleY = charLocation.scale;
                char.color = color;
                sprite.addChild(char);
            }
            
            return sprite;
        }
        
        
        public function fillMeshBatch(meshBatch:MeshBatch, width:Number, height:Number, text:String,
                                      fontSize:Number=-1, color:uint=0xffffff, 
                                      hAlign:String="center", vAlign:String="center",      
                                      autoScale:Boolean=true, 
                                      kerning:Boolean = true,
									  spaceLine:Number = 0):void
        {
            var charLocations:Vector.<CharLocation> = arrangeChars(width, height, text, fontSize, 
                                                                   hAlign, vAlign, autoScale, kerning, spaceLine);/**/
            var numChars:int = charLocations.length;
            mHelperImage.color = color;
            
            if (numChars > 8192)
                throw new ArgumentError("Bitmap Font text is limited to 8192 characters.");

            for (var i:int=0; i<numChars; ++i)
            {
                var charLocation:CharLocation = charLocations[i];
                mHelperImage.texture = charLocation.char.texture;
                mHelperImage.readjustSize();
                mHelperImage.x = charLocation.x;
                mHelperImage.y = charLocation.y;
                mHelperImage.scaleX = mHelperImage.scaleY = charLocation.scale;
                meshBatch.addMesh(mHelperImage);
            }
        }
        
        
        private function arrangeChars(width:Number, height:Number, text:String, fontSize:Number=-1,
                                      hAlign:String="center", vAlign:String="center",
                                      autoScale:Boolean=true, kerning:Boolean=true, spaceLine:Number = 0):Vector.<CharLocation>
        {
            if (text == null || text.length == 0) return new <CharLocation>[];
			
			text = getChangeCharCode.changeNumber(text);
			
			var charCodeArr:Array = getChangeCharCode.charCode(text);
			
            if (fontSize < 0) fontSize *= -mSize;
            
            var lines:Array = [];
            var finished:Boolean = false;
            var charLocation:CharLocation;
            var numChars:int;
            var containerWidth:Number;
            var containerHeight:Number;
            var newMLineHeight:Number = mLineHeight + spaceLine;
            var scale:Number;
            
            while (!finished)
            {
                lines.length = 0;
                scale = fontSize / mSize;
                containerWidth  = width / scale;
                containerHeight = height / scale;
                
                if (newMLineHeight <= containerHeight)
                {
                    var lastWhiteSpace:int = -1;
                    var lastCharID:int = -1;
                    var currentX:Number = containerWidth;
                    var currentY:Number = 0;
                    var currentLine:Vector.<CharLocation> = new <CharLocation>[];
                    
                     numChars = charCodeArr.length;
                    for (var i:int=0; i<numChars; ++i)
                    {
                        var lineFull:Boolean = false;
                        var charID:int = charCodeArr[i];
                        var char:BitmapChar = getChar(charID);
                        
                        if (charID == CHAR_NEWLINE || charID == CHAR_CARRIAGE_RETURN)
                        {
                            lineFull = true;
                        }
                        else if (char == null)
                        {
                            trace("[Starling] Missing character: null: " + charID);
                        }
                        else
                        {
                            if (charID == CHAR_SPACE || charID == CHAR_TAB)
                                lastWhiteSpace = i;
                            
                            if (kerning)
                                currentX -= char.getKerning(charID) + char.xOffset + char.xAdvance;/**/
                            
                            charLocation = mCharLocationPool.length ?
                                mCharLocationPool.pop() : new CharLocation(char);
                            
                            charLocation.char = char;
                            charLocation.x = currentX;
                            charLocation.y = currentY + char.yOffset;
                            currentLine.push(charLocation);
                            
                            
                            lastCharID = charID;
                            
                            if (charLocation.x < 0)
                            {
                               
                                if (autoScale && lastWhiteSpace == -1)
                                    break;

                                
                                var numCharsToRemove1:int = lastWhiteSpace == -1 ? 1 : i - lastWhiteSpace;/**/
                                var removeIndex1:int = currentLine.length - numCharsToRemove1;
                                
                                currentLine.splice(removeIndex1, numCharsToRemove1);
                                
                                if (currentLine.length == 0)
                                    break;
                                
                                i -= numCharsToRemove1;
                                lineFull = true;
                            }
                        }
                        
                        if (i == numChars - 1)
                        {
                            lines.push(currentLine);
                            finished = true;
                        }
                        else if (lineFull)
                        {
                            lines.push(currentLine);
                            
                            if (lastWhiteSpace == i)
                                currentLine.pop();
                            
                            if (currentY + 2*newMLineHeight <= containerHeight)
                            {
                                currentLine = new <CharLocation>[];
                                currentX = containerWidth;
                                currentY += newMLineHeight;
                                lastWhiteSpace = -1;
                                lastCharID = -1;
                            }
                            else
                            {
                                break;
                            }
                        }
                    } 
                } 
                
                if (autoScale && !finished && fontSize > 3)
                    fontSize -= 1;
                else
                    finished = true; 
            } 
            
            var finalLocations:Vector.<CharLocation> = new <CharLocation>[];
            var numLines:int = lines.length;
            var bottom:Number = currentY + newMLineHeight;
            var yOffset:int = 0;
            
            if (vAlign == Align.BOTTOM)      yOffset =  containerHeight - bottom;
            else if (vAlign == Align.CENTER) yOffset = (containerHeight - bottom) / 2;
            
            for (var lineID:int=0; lineID<numLines; ++lineID)
            {
                var line:Vector.<CharLocation> = lines[lineID];
                numChars = line.length;
                
                if (numChars == 0) continue;
                
                var xOffset:int = 0;
                var lastLocation:CharLocation = line[line.length-1];
                var right:Number = lastLocation.x;
                
                if (hAlign == Align.LEFT)       xOffset =  right;
				else if (hAlign == Align.CENTER) xOffset = right / 2;
                
                for (var c:int=0; c<numChars; ++c)
                {
                    charLocation = line[c];
                    charLocation.x = scale * (charLocation.x - xOffset);
                    charLocation.y = scale * (charLocation.y + yOffset + mOffsetY);
                    charLocation.scale = scale;
                    
                    if (charLocation.char.width > 0 && charLocation.char.height > 0)
                        finalLocations.push(charLocation);
                    
                    
                    mCharLocationPool.push(charLocation);
                }
            }
            
            return finalLocations;
        }
        
        
        public function get name():String { return mName; }
        
       
        public function get size():Number { return mSize; }
        
       
        public function get lineHeight():Number { return mLineHeight; }
        public function set lineHeight(value:Number):void { mLineHeight = value; }
        
       
        public function get smoothing():String { return mHelperImage.textureSmoothing; }
        public function set smoothing(value:String):void { mHelperImage.textureSmoothing = value; }
        
        public function get baseline():Number { return mBaseline; }
        public function set baseline(value:Number):void { mBaseline = value; }
        
        
        public function get offsetX():Number { return mOffsetX; }
        public function set offsetX(value:Number):void { mOffsetX = value; }
        
        
        public function get offsetY():Number { return mOffsetY; }
        public function set offsetY(value:Number):void { mOffsetY = value; }
    }
}

import starling.extensions.RTL_BitmapFont.BitmapChar;

/**/

class CharLocation
{
    public var char:BitmapChar;
    public var scale:Number;
    public var x:Number;
    public var y:Number;
    
    public function CharLocation(char:BitmapChar)
    {
        this.char = char;
    }
}