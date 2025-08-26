package com.bazaar.poolakey

import android.widget.Toast
import com.tuarua.frekotlin.FreKotlinMainController

class BridgeMaker {
    companion object {
        lateinit var _MainActivity: FreKotlinMainController

        /** ارسال رویداد عمومی (اختیاری ولی مفید) */
        fun dispatch(code: String, level: String) {
            _MainActivity.dispatchEvent(level, code)
        }

        /** موفقیت خرید ساده (بدون JSON) */
        fun purchaseSucceed() {
            dispatch("PURCHASE_SUCCESS", "purchase_success")
        }

        fun subscriptionsResult(json: String) {
            dispatch("SUBSCRIPTIONS_RESULT", json)
        }

        // نتیجه‌ی خریدهای INAPP (Query) به‌صورت JSON
        fun inappPurchasesResult(json: String) {
            dispatch("INAPP_PURCHASES_RESULT", json)
        }

        // نتیجه‌ی consume
        fun consumeResult(json: String) {
            dispatch("CONSUME_RESULT", json)
        }

         // نتیجه‌ی consume
        fun purchaseFlowBegan(type: String = "inapp") {
            dispatch("PURCHASE_FLOW_BEGAN",type)
        }

        // خطاها/حالات
        fun beginFlowFailed(type: String) { dispatch("BEGIN_FLOW_FAILED", type) }
        fun purchaseCanceled(type: String) { dispatch("PURCHASE_CANCELED", type) }
        fun purchaseFailed(type: String) { dispatch("PURCHASE_FAILED", type) }
        fun connectionFailed(msg: String) { dispatch("CONNECTION_FAILED", msg) }
        fun disconnected() { dispatch("DISCONNECTED", "") }
    }
}
