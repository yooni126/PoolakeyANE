package com.bazaar {
    import flash.events.Event;

    public class PoolakeyEvent extends Event {
        public var params : *;
        public static const PURCHASE_SUCCESS:String = "purchase_success";
        public static const SUBSCRIPTIONS_RESULT:String = "subscribtions_result";

        public function PoolakeyEvent ( type : String , params : * = null , bubbles : Boolean = false , cancelable : Boolean = false ) {
            super ( type , bubbles , cancelable );
            this.params = params;
        }

        public override function clone () : Event {
            return new PoolakeyEvent ( type , this.params , bubbles , cancelable );
        }

        public override function toString () : String {
            return formatToString ( "PoolakeyEvent" , "params" , "type" , "bubbles" , "cancelable" );
        }
    }
}
