package com.bazaar.poolakey

import android.content.Intent
import android.content.res.Configuration
import android.os.Build
import com.adobe.air.AndroidActivityWrapper.ActivityState
import com.adobe.air.AndroidActivityWrapper.ActivityState.DESTROYED
import com.adobe.air.AndroidActivityWrapper.ActivityState.PAUSED
import com.adobe.air.AndroidActivityWrapper.ActivityState.RESTARTED
import com.adobe.air.AndroidActivityWrapper.ActivityState.RESUMED
import com.adobe.air.AndroidActivityWrapper.ActivityState.STARTED
import com.adobe.air.AndroidActivityWrapper.ActivityState.STOPPED
import com.adobe.air.FreKotlinActivityResultCallback
import com.adobe.air.FreKotlinStateChangeCallback
import com.adobe.fre.FREContext
import com.bazaar.poolakey.BridgeMaker.Companion._MainActivity
import com.tuarua.frekotlin.FREArgv
import com.tuarua.frekotlin.FreKotlinMainController
import com.tuarua.frekotlin.String as freString 
import ir.cafebazaar.poolakey.Connection
import ir.cafebazaar.poolakey.Payment
import ir.cafebazaar.poolakey.config.PaymentConfiguration
import ir.cafebazaar.poolakey.config.SecurityCheck

@Suppress("unused", "UNUSED_PARAMETER", "UNCHECKED_CAST")
class KotlinController : FreKotlinMainController, FreKotlinStateChangeCallback, FreKotlinActivityResultCallback {


    private lateinit var paymentConnection: Connection;

    fun launchBazaarPayment(ctx: FREContext, argv: FREArgv) {

        val rsaKey: String = (if (argv.size > 0) freString(argv[0]) else null) ?: ""
        val skuId : String = (if (argv.size > 1) freString(argv[1]) else null) ?: ""
        val payload: String = (if (argv.size > 2) freString(argv[2]) else null) ?: ""


        _MainActivity = this

        val act = context?.activity ?: return
        if (rsaKey.isEmpty() || skuId.isEmpty()) return

     //   Toast.makeText(_MainActivity.context?.activity, getInstallerPackageName(), Toast.LENGTH_SHORT).show()


        val intent = Intent(act, PaymentActivity::class.java).apply {
            putExtra("BASE64KEY", rsaKey)
            putExtra("productId", skuId)
            putExtra("payload", payload)
            addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION)
        }
        act.startActivity(intent)


    }
    fun getSubscriptions(ctx: FREContext, argv: FREArgv) {
        val act = context?.activity ?: return
        _MainActivity = this

        val passedKey: String = (if (argv.size > 0) freString(argv[0]) else null) ?: ""

        val cfg = if (passedKey.isNotEmpty()) {
            PaymentConfiguration(localSecurityCheck = SecurityCheck.Enable(rsaPublicKey = passedKey))
        } else {
            // برای تولید بهتره Enable باشد؛ Disable فقط جهت توسعه
            PaymentConfiguration(localSecurityCheck = SecurityCheck.Disable)
        }

        val payment = Payment(context = act, config = cfg)
        payment.getSubscribedProducts {
            querySucceed { subs ->
                val json = buildString {
                    append('[')
                    subs.forEachIndexed { i, sub ->
                        append("{\"productId\":\"${sub.productId}\",")
                        append("\"purchaseToken\":\"${sub.purchaseToken}\",")
                        append("\"purchaseState\":${sub.purchaseState},")
                        append("\"purchaseTime\":${sub.purchaseTime}}")
                        if (i < subs.size - 1) append(',')
                    }
                    append(']')
                }
                BridgeMaker.subscriptionsResult(json)
            }
            queryFailed { t ->
                BridgeMaker.subscriptionsResult("{\"error\":\"${t.message ?: "unknown"}\"}")
            }
        }
    }

    /** فقط برای تست/لاگ: نام نصب‌کنندهٔ اپ */
    fun getInstallerPackageName(): String {
        val pm = context?.activity?.applicationContext?.packageManager
        val pkg = context?.activity?.applicationContext?.packageName
        if (pm == null || pkg == null) return "unknown"
        return try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                pm.getInstallSourceInfo(pkg).installingPackageName ?: "unknown"
            } else {
                @Suppress("DEPRECATION")
                pm.getInstallerPackageName(pkg) ?: "unknown"
            }
        } catch (_: Exception) { "unknown" }
    }



    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?) = Unit
    override fun onConfigurationChanged(configuration: Configuration?) = Unit
    override fun onActivityStateChanged(activityState: ActivityState?) {
        when (activityState) {
            STARTED, RESTARTED, RESUMED, PAUSED, STOPPED, DESTROYED -> return
            else -> return
        }
    }

    override val TAG: String? get() = this::class.java.simpleName

    private var _context: FREContext? = null
    override var context: FREContext?
        get() = _context
        set(value) {
            _context = value
            // اطمینان: هر وقت context ست شد، BridgeMaker هم MainController را داشته باشد
            _MainActivity = this
        }
}