package MainMenuPage.screens {


    import feathers.controls.PanelScreen;
    import feathers.controls.Label;
    import feathers.themes.BaseMaterialCyanLimeMobileTheme;
    import feathers.layout.AnchorLayout;
    import starling.text.TextFormat;
    import feathers.layout.HorizontalAlign;
    import MainMenuPage.data.Fonts;
    import feathers.layout.AnchorLayoutData;
    import feathers.controls.Header;
    import feathers.layout.VerticalAlign;
    import starling.display.DisplayObject;
    import feathers.controls.Button;
    import feathers.events.FeathersEventType;
    import starling.events.Event;
    import com.bazaar.BazaarPoolakyPayment;
    import flash.system.Capabilities;
    import com.bazaar.PoolakeyEvent;

    /**
     * ...
     * @author Younes Mashayekhi
     */
    public class InAppProducts extends PanelScreen {
        public function InAppProducts() {
            super();
            styleNameList.add(BaseMaterialCyanLimeMobileTheme.THEME_STYLE_NAME_HEADER_WITH_SHADOW);
            styleNameList.add(BaseMaterialCyanLimeMobileTheme.THEME_STYLE_NAME_PANEL_WITHOUT_PADDING);
        }

        override protected function initialize():void {

            super.initialize();

            layout = new AnchorLayout()
            this.hasElasticEdges = true;
            this.headerFactory = this.customHeaderFactory;
            styleNameList.add(BaseMaterialCyanLimeMobileTheme.THEME_STYLE_NAME_PANEL_WITHOUT_PADDING);


            var buttonLayout:AnchorLayoutData = new AnchorLayoutData();
            buttonLayout.horizontalCenter = 0;
            buttonLayout.verticalCenter = 0;

            var lunchBtn:Button = new Button();
            lunchBtn.styleNameList.add(Label.ALTERNATE_STYLE_NAME_HEADING);
            lunchBtn.label = "نمایش پرداخت درون برنامه ای";
            lunchBtn.layoutData = buttonLayout;
            lunchBtn.fontStyles = new TextFormat(Fonts.FONT_YEKAN, 18, 0xFFFFFF);
            lunchBtn.labelOffsetY -= 5;
            lunchBtn.addEventListener(Event.TRIGGERED, lunchPoolakey)
            this.addChild(lunchBtn);
        }

        private function customHeaderFactory():Header {
            var header:Header = new Header();
            var title:Label = new Label();
            title.text = "تست پرداخت درون برنامه ای کافه بازار";
            title.fontStyles = new TextFormat(Fonts.FONT_NAZANIN_BOLD, 20, 0xFFFFFF, HorizontalAlign.CENTER, VerticalAlign.MIDDLE);
            title.paddingBottom = 12;
            header.centerItems = new <DisplayObject>[title];

            return header;
        }



        private function lunchPoolakey(event:Event):void {

            if (Capabilities.os.indexOf("Windows") >= 0) {
                return;
            }

            var poolakey:BazaarPoolakyPayment;
            poolakey = BazaarPoolakyPayment.instance;
            // رویدادها
            poolakey.addEventListener(PoolakeyEvent.SUBSCRIPTIONS_RESULT, onSubsResult);
            poolakey.addEventListener(PoolakeyEvent.TRIAL_SUBSCRIPTION_RESULT, onTrialInfo);
            NativeApplication.nativeApplication.addEventListener(flash.events.Event.ACTIVATE, onAppResume);
            // مقادیر تست خودت را بگذار
            const RSA:String = ""; // کلید RSA که در کنسول بازار قرار دارد
            const SKU:String = ""; // دقیقاً همان sku در کنسول بازار
            const PAYLOAD:String = "dev_test";
            poolakey.launchBazaarPayment(RSA, SKU, PAYLOAD);
            poolakey.checkTrialSubscription(RSA);
        }

        private function onTrialInfo(e:PoolakeyEvent):void {
            // اگر خطا:
            if (e.data && e.data.substr(0, 8) == "{\"error\"") {
                trace("trial error:", e.data);
                return;
            }
            // parse
            //دریافت مدت زمان اشتراک آزمایشی
            const obj:Object = JSON.parse(e.data);
            trace("trial available:", obj.isAvailable, " days:", obj.trialPeriodDays);

            if (obj.isAvailable) {
                //کاربر واجد شرایط دریافت تریال است (برای خرید بعدی).
                // اگر قبلا مصرف کرده یا در حال مصرف است جواب فالس است
            }
        }

        private function onSubsResult(e:PoolakeyEvent):void {
            poolakey.removeEventListener(PoolakeyEvent.SUBSCRIPTIONS_RESULT, onSubsResult);
            if (e.data && e.data.substr(0, 8) == "{\"error\"") {
                trace("SUBSCRIPTIONS_RESULT error:", e.data);
                return;
            }
            if (!e.data || e.data.charAt(0) != "[") {
                trace("SUBSCRIPTIONS_RESULT invalid JSON:", e.data);
                return;
            }
            const arr:Array = JSON.parse(e.data) as Array;
            var targetSku = "trial_subscription";
            var purchaseToken:String = "";
            var purchaseTime:String = "";
            var hasIt:Boolean = false;
            for each (var sub:Object in arr) {
                if (sub.productId == targetSku) {
                    purchaseToken = sub.purchaseToken;
                    purchaseTime = sub.purchaseTime;
                    trace("purchaseToken:" + sub.purchaseToken);
                    trace("purchaseTime:" + sub.purchaseTime);
                    hasIt = true;
                    break;
                }
            }
            var reuslt:String = hasIt ? "✅ اشتراک فعال/ثبت‌شده است برای " + targetSku : "❌ اشتراک برای " + targetSku + " پیدا نشد";
            trace(reuslt);
        }

         private function onAppResume(event:flash.events.Event):void {
            NativeApplication.nativeApplication.removeEventListener(flash.events.Event.ACTIVATE, onAppResume);
            poolakey.getSubscriptions(PubValue.RSA);
        }

    }



}
