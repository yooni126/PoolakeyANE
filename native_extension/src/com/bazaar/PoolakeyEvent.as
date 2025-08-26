package com.bazaar {
    import flash.events.Event;

    public class PoolakeyEvent extends Event {
        public var params:*;
        public static const SUBSCRIPTIONS_RESULT:String = "subscribtions_result";
        public static const PURCHASE_FLOW_BEGAN:String = "PURCHASE_FLOW_BEGAN";
        public static const BEGIN_FLOW_FAILED:String = "BEGIN_FLOW_FAILED";
        public static const PURCHASE_FAILED:String = "PURCHASE_FAILED";
        public static const PURCHASE_CANCELED:String = "PURCHASE_CANCELED";
        public static const CONNECTION_FAILED:String = "CONNECTION_FAILED";
        public static const DISCONNECTED:String = "DISCONNECTED";
        public static const PURCHASE_SUCCESS:String = "PURCHASE_SUCCESS";
        public static const CONSUME_RESULT:String = "CONSUME_RESULT";
        public static const INAPP_PURCHASES_RESULT:String = "INAPP_PURCHASES_RESULT";
        public static const TRIAL_SUBSCRIPTION_RESULT:String = "TRIAL_SUBSCRIPTION_RESULT";

        public var data:String;

        public function PoolakeyEvent(type:String, data:String = null, bubbles:Boolean = false, cancelable:Boolean = false) {
            super(type, bubbles, cancelable);
            this.data = data;
        }

        public override function clone():Event {
            return new PoolakeyEvent(type, this.params, bubbles, cancelable);
        }

        public override function toString():String {
            return formatToString("PoolakeyEvent", "params", "type", "bubbles", "cancelable");
        }
    }
}
