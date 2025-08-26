package com.bazaar.poolakey

import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import ir.cafebazaar.poolakey.Connection
import ir.cafebazaar.poolakey.Payment
import ir.cafebazaar.poolakey.config.PaymentConfiguration
import ir.cafebazaar.poolakey.config.SecurityCheck
import ir.cafebazaar.poolakey.request.PurchaseRequest
import com.bazaar.poolakey.BridgeMaker

class PaymentActivity : ComponentActivity() {
    private var paymentConnection: Connection? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val base64Key = intent.getStringExtra("BASE64KEY") ?: run {
            Toast.makeText(this, "کلید RSA نامعتبر است", Toast.LENGTH_SHORT).show()
            finish(); return
        }
        val productId = intent.getStringExtra("productId") ?: run {
            Toast.makeText(this, "شناسه محصول نامعتبر است", Toast.LENGTH_SHORT).show()
            finish(); return
        }
        val payload = intent.getStringExtra("payload") ?: ""

        val payment = Payment(
            context = this,
            config = PaymentConfiguration(
                localSecurityCheck = SecurityCheck.Enable(rsaPublicKey = base64Key)
            )
        )

        paymentConnection = payment.connect {
            connectionSucceed {
                val req = PurchaseRequest(productId = productId, payload = payload)
                payment.purchaseProduct(
                    registry = activityResultRegistry,
                    request = req
                ) {
                    purchaseFlowBegan {
                        /* UI بازار باز شد */
                        BridgeMaker.purchaseFlowBegan("inapp")
                    }

                    failedToBeginFlow {
                        BridgeMaker.beginFlowFailed("inapp")
                        Toast.makeText(this@PaymentActivity,
                            "خطا در شروع خرید", Toast.LENGTH_SHORT).show()
                        finish()
                    }

                    purchaseSucceed { purchase ->
                        // اینجا بلافاصله رویداد رو بفرست
                        val json = """{
                          "productId":"${purchase.productId}",
                          "purchaseToken":"${purchase.purchaseToken}",
                          "purchaseTime":${purchase.purchaseTime},
                          "payload":"$payload"
                        }""".trimIndent()
                        try { BridgeMaker.dispatch("PURCHASE_SUCCESS", json) } catch (_: Throwable) { }
                        finish()
                    }

                    purchaseCanceled {
                        BridgeMaker.purchaseCanceled("inapp")
                        Toast.makeText(this@PaymentActivity,
                            "پرداخت لغو شد", Toast.LENGTH_SHORT).show()
                        finish()
                    }

                    purchaseFailed {
                        BridgeMaker.purchaseFailed("inapp")
                        Toast.makeText(this@PaymentActivity, "خرید ناموفق بود", Toast.LENGTH_SHORT).show()
                        finish()
                    }
                }
            }
            connectionFailed {
                BridgeMaker.connectionFailed(it.message ?: "unknown")
                Toast.makeText(this@PaymentActivity, "اتصال به بازار ناموفق بود", Toast.LENGTH_SHORT).show()
                finish()
            }
            disconnected {
                BridgeMaker.disconnected()
                //Toast.makeText(this@PaymentActivity, "اتصال به بازار برقرار نیست", Toast.LENGTH_SHORT).show()
                finish()
            }
        }
    }

    override fun onDestroy() {
        try { paymentConnection?.disconnect() } catch (_: Throwable) {}
        paymentConnection = null
        super.onDestroy()
    }
}
