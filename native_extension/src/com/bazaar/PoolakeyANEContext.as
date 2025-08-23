package com.bazaar {
    import flash.events.StatusEvent;
    import flash.external.ExtensionContext;

    public class PoolakeyANEContext {
        private static var _context : ExtensionContext;
        internal static const NAME : String = "poolakey";
        internal static const TRACE : String = "TRACE";
        internal static const INIT_ERROR_MESSAGE : String = NAME + " not initialised... use .bazaar";

        public function PoolakeyANEContext () {
        }

        public static function get context () : ExtensionContext {
            if ( _context == null ) {
                try {
                    _context = ExtensionContext.createExtensionContext ( "com.bazaar." + NAME , null );
                    _context.addEventListener ( StatusEvent.STATUS , gotEvent );
                } catch ( e : Error ) {
                    trace ( "[" + NAME + "] ANE Not loaded properly. Future calls will fail." );
                }
            }
            return _context;
        }

        private static function gotEvent(event:StatusEvent):void {
            // کانال لاگ
            if (event.level == TRACE) {
                trace("[" + NAME + "]", event.code);
                return;
            }

            // رویدادهای اصلی از ANE (code مهم است)
            switch (event.code) {
                case "PURCHASE_SUCCESS": // خرید موفق
                    if (event.level == "purchase_success") {
                        BazaarPoolakyPayment.instance.dispatchEvent(
                            new PoolakeyEvent(PoolakeyEvent.PURCHASE_SUCCESS)
                        );
                    } else {
                        // اگر بعداً payload دیگری فرستادی
                        BazaarPoolakyPayment.instance.dispatchEvent(
                            new PoolakeyEvent("PURCHASE_SUCCESS", event.level)
                        );
                    }
                    break;

                case "SUBSCRIPTIONS_RESULT": // JSON در level
                    BazaarPoolakyPayment.instance.dispatchEvent(
                        new PoolakeyEvent(PoolakeyEvent.SUBSCRIPTIONS_RESULT, event.level)
                    );
                    break;

                default:
                    trace("[" + NAME + "] Unknown event → code:", event.code, " level:", event.level);
                    break;
            }
        }

        public static function dispose () : void {
            if ( !_context ) {
                return;
            }
            trace ( "[" + NAME + "] Unloading ANE..." );
            _context.removeEventListener ( StatusEvent.STATUS , gotEvent );
            _context.dispose ();
            _context = null;
        }

    }
}
