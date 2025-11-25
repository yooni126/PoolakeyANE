package com.bazaar {
    import flash.events.EventDispatcher;

    public class BazaarPoolakyPayment extends EventDispatcher {
        private static var _instance:BazaarPoolakyPayment;

        public function BazaarPoolakyPayment() {

            _instance = this;
        }

        public static function get instance():BazaarPoolakyPayment {
            if (!_instance) {
                new BazaarPoolakyPayment();
            }
            return _instance;
        }

        public function launchBazaarPayment(rsa_key:String, sku_id:String, payload:String = "dev_pay", dynamicPriceToken:String = ""):void {
            if (!PoolakeyANEContext.context)
                return;

            PoolakeyANEContext.context.call("launchBazaarPayment", rsa_key, sku_id, payload, dynamicPriceToken);
        }

        public function getSubscriptions(rsa:String):void {
            if (!PoolakeyANEContext.context)
                return;
            PoolakeyANEContext.context.call("getSubscriptions", rsa);
        }

        public function subscribe(rsa:String, sku:String, payload:String = ""):void {
            if (!PoolakeyANEContext.context)
                return;
            PoolakeyANEContext.context.call("subscribe", rsa, sku, payload); // اسم تابع باید با Kotlin یکی باشد
        }

        public function getPurchasedInapps(rsa:String):void {
            if (!PoolakeyANEContext.context)
                return;
            PoolakeyANEContext.context.call("getPurchasedInapps", rsa);
        }

        public function consumeInapp(purchaseToken:String):void {
            if (!PoolakeyANEContext.context)
                return;
            PoolakeyANEContext.context.call("consumeInapp", purchaseToken);
        }

        public function checkTrialSubscription(rsa:String = ""):void {
            if (!PoolakeyANEContext.context)
                return;
            PoolakeyANEContext.context.call("checkTrialSubscription", rsa);
        }


        public static function dispose():void {
            if (PoolakeyANEContext.context) {
                PoolakeyANEContext.dispose();
            }
        }


    }
}
