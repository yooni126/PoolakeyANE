package com.bazaar.poolakey

import android.widget.Toast
import com.tuarua.frekotlin.FreKotlinMainController

class BridgeMaker {
    companion object {
        lateinit var _MainActivity : FreKotlinMainController ;

        fun purchaseSucceed() {

            _MainActivity.dispatchEvent("PURCHASE_SUCCESS", "purchase_success")
            Toast.makeText(_MainActivity.context?.activity, "خرید با موفقیت ثبت شد", Toast.LENGTH_SHORT).show()

        }

        fun subscriptionsResult(data: String) {
            _MainActivity.dispatchEvent("SUBSCRIPTIONS_RESULT", data)
          //  Toast.makeText(_MainActivity.context?.activity, "نتیجه اشتراک‌ها دریافت شد", Toast.LENGTH_SHORT).show()
        }

        

    }
}