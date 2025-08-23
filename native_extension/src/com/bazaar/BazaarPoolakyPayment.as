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

        public function launchBazaarPayment(rsa_key:String, sku_id:String, _payload:String = "dev_pay"):void {
            PoolakeyANEContext.context.call("launchBazaarPayment", rsa_key, sku_id, _payload);
        }

        public function getSubscriptions(base64Key:String):void {
            PoolakeyANEContext.context.call("getSubscriptions", base64Key);
        }

        public static function dispose():void {
            if (PoolakeyANEContext.context) {
                PoolakeyANEContext.dispose();
            }
        }


    }
}
