package com.bazaar {
    import flash.events.StatusEvent;
    import flash.external.ExtensionContext;

    public class PoolakeyANEContext {
        private static var _context:ExtensionContext;
        internal static const NAME:String = "poolakey";
        internal static const TRACE:String = "TRACE";
        internal static const INIT_ERROR_MESSAGE:String = NAME + " not initialised... use .bazaar";

        public function PoolakeyANEContext() {
        }

        public static function get context():ExtensionContext {
            if (_context == null) {
                try {
                    _context = ExtensionContext.createExtensionContext("com.bazaar." + NAME, null);
                    _context.addEventListener(StatusEvent.STATUS, gotEvent);
                } catch (e:Error) {
                    trace("[" + NAME + "] ANE Not loaded properly. Future calls will fail.");
                }
            }
            return _context;
        }

        private static function gotEvent(event:StatusEvent):void {
            // کانال لاگ
            if (event.code == TRACE) {
                trace("[" + NAME + "]", event.level); // محتوا داخل level میاد
                return;
            }

            const code:String = event.code;
            const level:String = event.level;

            // رویدادهای اصلی از ANE (code مهم است)
            switch (code) {
                case "PURCHASE_SUCCESS":
                    // اگر JSON فرستاده‌ایم:
                    if (level && level.length > 0 && level.charAt(0) == "{") {
                        BazaarPoolakyPayment.instance.dispatchEvent(new PoolakeyEvent(PoolakeyEvent.PURCHASE_SUCCESS, level));
                    } else {
                        // حالت ساده
                        BazaarPoolakyPayment.instance.dispatchEvent(new PoolakeyEvent(PoolakeyEvent.PURCHASE_SUCCESS));
                    }
                    break;

                case "SUBSCRIPTIONS_RESULT":
                    // level حاوی JSON لیست اشتراک‌ها
                    BazaarPoolakyPayment.instance.dispatchEvent(new PoolakeyEvent(PoolakeyEvent.SUBSCRIPTIONS_RESULT, level));
                    break;


                case "INAPP_PURCHASES_RESULT":
                    BazaarPoolakyPayment.instance.dispatchEvent(new PoolakeyEvent(PoolakeyEvent.INAPP_PURCHASES_RESULT, level));
                    break;
                case "CONSUME_RESULT":
                    BazaarPoolakyPayment.instance.dispatchEvent(new PoolakeyEvent(PoolakeyEvent.CONSUME_RESULT, level));
                    break;
                case "PURCHASE_FLOW_BEGAN":
                    BazaarPoolakyPayment.instance.dispatchEvent(new PoolakeyEvent(PoolakeyEvent.PURCHASE_FLOW_BEGAN, level));
                    break;
                case "TRIAL_SUBSCRIPTION_RESULT":
                    BazaarPoolakyPayment.instance.dispatchEvent(new PoolakeyEvent(PoolakeyEvent.TRIAL_SUBSCRIPTION_RESULT, level));
                    break;
                // خطاها
                case "BEGIN_FLOW_FAILED":
                case "PURCHASE_CANCELED":
                case "PURCHASE_FAILED":
                case "CONNECTION_FAILED":
                case "DISCONNECTED":
                    BazaarPoolakyPayment.instance.dispatchEvent(new PoolakeyEvent(code, level));
                    break;

                default:
                    trace("[" + NAME + "] Unknown event → code:", code, " level:", level);
                    break;
            }
        }

        public static function dispose():void {
            if (!_context) {
                return;
            }
            trace("[" + NAME + "] Unloading ANE...");
            _context.removeEventListener(StatusEvent.STATUS, gotEvent);
            _context.dispose();
            _context = null;
        }

    }
}
