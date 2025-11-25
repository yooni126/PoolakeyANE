package com.bazaar.poolakey

import android.content.Intent
import android.content.res.Configuration
import android.os.Build
import com.adobe.air.AndroidActivityWrapper.ActivityState
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
import org.json.JSONArray
import org.json.JSONObject

@Suppress("unused", "UNUSED_PARAMETER")
class KotlinController : FreKotlinMainController,
    FreKotlinStateChangeCallback, FreKotlinActivityResultCallback {

    private lateinit var paymentConnection: Connection

    /** شروع فرآیند خرید */
    fun launchBazaarPayment(ctx: FREContext, argv: FREArgv) {
        val rsaKey: String = (if (argv.size > 0) freString(argv[0]) else null) ?: ""
        val skuId : String = (if (argv.size > 1) freString(argv[1]) else null) ?: ""
        val payload: String = (if (argv.size > 2) freString(argv[2]) else null) ?: ""
        val dynamicPriceToken: String = (if (argv.size > 3) freString(argv[3]) else null) ?: ""

        _MainActivity = this
        val act = context?.activity ?: return
        if (rsaKey.isEmpty() || skuId.isEmpty()) return

        val intent = Intent(act, PaymentActivity::class.java).apply {
            putExtra("BASE64KEY", rsaKey)
            putExtra("productId", skuId)
            putExtra("payload", payload)
            putExtra("dynamicPriceToken", dynamicPriceToken)
            addFlags(Intent.FLAG_ACTIVITY_NO_ANIMATION)
        }
        act.startActivity(intent)
    }

        /** دریافت لیست اشتراک‌ها */
    @Suppress("unused")
    fun getSubscriptions(ctx: FREContext, argv: FREArgv) {
        BridgeMaker.dispatch("TRACE", "getSubscriptions: called")

        val act = context?.activity ?: run {
            BridgeMaker.dispatch("TRACE", "getSubscriptions: no-activity")
            return
        }

        val rsa: String = if (argv.size > 0) freString(argv[0]) ?: "" else ""

        val cfg = if (rsa.isNotEmpty())
            PaymentConfiguration(localSecurityCheck = SecurityCheck.Enable(rsaPublicKey = rsa))
        else
            PaymentConfiguration(localSecurityCheck = SecurityCheck.Disable)

        val payment = Payment(context = act, config = cfg)
        var finished = false
        var conn: Connection? = null

        conn = payment.connect {
            connectionSucceed {
                payment.getSubscribedProducts {
                    querySucceed { subs ->
                        if (!finished) {
                            finished = true
                            BridgeMaker.dispatch("TRACE", "getSubscriptions: succeed size=${subs.size}")

                            val arr = JSONArray()
                            subs.forEach { s ->
                                val o = JSONObject()
                                    .put("productId", s.productId)
                                    .put("purchaseToken", s.purchaseToken)
                                    .put("purchaseState", s.purchaseState)
                                    .put("purchaseTime", s.purchaseTime)
                                arr.put(o)
                            }
                            BridgeMaker.subscriptionsResult(arr.toString()) // ← JSON معتبر و escape‌شده
                            try { conn?.disconnect() } catch (_: Throwable) {}
                        }
                    }
                    queryFailed { t ->
                        if (!finished) {
                            finished = true
                            val err = JSONObject().put("error", t.message ?: "unknown")
                            BridgeMaker.subscriptionsResult(err.toString())
                            try { conn?.disconnect() } catch (_: Throwable) {}
                        }
                    }
                }
            }
            connectionFailed {
                if (!finished) {
                    finished = true
                    BridgeMaker.subscriptionsResult("{\"error\":\"connection_failed\"}")
                }
            }
            disconnected {
                if (!finished) {
                    finished = true
                    BridgeMaker.dispatch("TRACE", "getSubscriptions: disconnected")
                    BridgeMaker.subscriptionsResult("{\"error\":\"disconnected\"}")
                }
            }
        }

        // تایم‌اوت احتیاطی (اگر هیچ کالبکی نیامد)
        act.window?.decorView?.postDelayed({
            if (!finished) {
                finished = true
                BridgeMaker.dispatch("TRACE", "getSubscriptions: timeout")
                BridgeMaker.subscriptionsResult("{\"error\":\"timeout\"}")
                try { conn.disconnect() } catch (_: Throwable) {}
            }
        }, 8000)
    }



    @Suppress("unused")
    fun listFunctions(ctx: FREContext, argv: FREArgv) {
        val names = this::class.java.methods
            .map { it.name }
            .distinct()
            .sorted()
            .joinToString(",")
        BridgeMaker.dispatch("TRACE", names)
    }

    @Suppress("unused")
    fun ping(ctx: FREContext, argv: FREArgv) {
        BridgeMaker.dispatch("TRACE", "ping-ok")
    }


    /** INAPP: گرفتن خریدهای کاربر (مصرفی/غیرمصرفی) */
    @Suppress("unused")
    fun getPurchasedInapps(ctx: FREContext, argv: FREArgv) {
        val act = context?.activity ?: return
        _MainActivity = this

        val rsaKey = freString(argv.getOrNull(0)) ?: ""
        val cfg = if (rsaKey.isNotEmpty())
            PaymentConfiguration(localSecurityCheck = SecurityCheck.Enable(rsaPublicKey = rsaKey))
        else
            PaymentConfiguration(localSecurityCheck = SecurityCheck.Disable)

        val payment = Payment(context = act, config = cfg)
        var conn: Connection? = null

        conn = payment.connect {
            connectionSucceed {
                payment.getPurchasedProducts {
                    querySucceed { purchases ->
                        val arr = org.json.JSONArray()
                        purchases.forEach { p ->
                            val o = org.json.JSONObject()
                                .put("productId", p.productId)
                                .put("purchaseToken", p.purchaseToken )
                                .put("purchaseState", p.purchaseState)
                                .put("purchaseTime", p.purchaseTime)
                            arr.put(o)
                        }
                        BridgeMaker.inappPurchasesResult(arr.toString())
                        try { conn?.disconnect() } catch (_: Throwable) {}
                    }
                    queryFailed { t ->
                        BridgeMaker.inappPurchasesResult("{\"error\":\"${t.message ?: "unknown"}\"}")
                        try { conn?.disconnect() } catch (_: Throwable) {}
                    }
                }
            }
            connectionFailed {
                BridgeMaker.inappPurchasesResult("{\"error\":\"connection_failed\"}")
            }
            disconnected {
                BridgeMaker.inappPurchasesResult("{\"error\":\"disconnected\"}")
            }
        }
    }

    /** INAPP: مصرف‌کردن خرید مصرفی با purchaseToken */
    @Suppress("unused")
    fun consumeInapp(ctx: FREContext, argv: FREArgv) {
        val act = context?.activity ?: return
        _MainActivity = this

        val token: String = freString(argv.getOrNull(0)) ?: ""
        if (token.isEmpty()) {
            BridgeMaker.consumeResult("{\"error\":\"empty_token\"}")
            return
        }

        val payment = Payment(context = act, config = PaymentConfiguration(localSecurityCheck = SecurityCheck.Disable))
        payment.consumeProduct(purchaseToken = token) {
            consumeSucceed {
                BridgeMaker.consumeResult("{\"ok\":true}")
            }
            consumeFailed { t ->
                BridgeMaker.consumeResult("{\"error\":\"${t.message ?: "unknown"}\"}")
            }
        }
    }

    /** فقط برای تست */
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

    @Suppress("unused")
    fun checkTrialSubscription(ctx: FREContext, argv: FREArgv) {
        val act = context?.activity ?: return
        _MainActivity = this

        val rsaKey = freString(argv.getOrNull(0)) ?: ""
        val cfg = if (rsaKey.isNotEmpty())
            PaymentConfiguration(localSecurityCheck = SecurityCheck.Enable(rsaPublicKey = rsaKey))
        else
            PaymentConfiguration(localSecurityCheck = SecurityCheck.Disable)

        val payment = Payment(context = act, config = cfg)
        var conn: Connection? = null

        conn = payment.connect {
            connectionSucceed {
                payment.checkTrialSubscription {
                    checkTrialSubscriptionSucceed { info ->
                        // info.isAvailable (Boolean), info.trialPeriodDays (Int)
                        val json = org.json.JSONObject()
                            .put("isAvailable", info.isAvailable)
                            .put("trialPeriodDays", info.trialPeriodDays)
                            .toString()
                        BridgeMaker.dispatch("TRIAL_SUBSCRIPTION_RESULT", json)
                        try { conn?.disconnect() } catch (_: Throwable) {}
                    }
                    checkTrialSubscriptionFailed { t ->
                        val err = org.json.JSONObject()
                            .put("error", t.message ?: "unknown")
                            .toString()
                        BridgeMaker.dispatch("TRIAL_SUBSCRIPTION_RESULT", err)
                        try { conn?.disconnect() } catch (_: Throwable) {}
                    }
                }
            }
            connectionFailed {
                BridgeMaker.dispatch("TRIAL_SUBSCRIPTION_RESULT", """{"error":"connection_failed"}""")
            }
            disconnected {
                BridgeMaker.dispatch("TRIAL_SUBSCRIPTION_RESULT", """{"error":"disconnected"}""")
            }
        }
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, intent: Intent?) = Unit
    override fun onConfigurationChanged(configuration: Configuration?) = Unit
    override fun onActivityStateChanged(activityState: ActivityState?) = Unit

    override val TAG: String? get() = this::class.java.simpleName

    private var _context: FREContext? = null
    override var context: FREContext?
        get() = _context
        set(value) {
            _context = value
            _MainActivity = this
        }
}
