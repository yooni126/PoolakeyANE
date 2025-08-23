package com.bazaar.poolakey

import android.os.Bundle
import android.widget.Toast
import androidx.activity.ComponentActivity
import ir.cafebazaar.poolakey.Connection
import ir.cafebazaar.poolakey.Payment
import ir.cafebazaar.poolakey.config.PaymentConfiguration
import ir.cafebazaar.poolakey.config.SecurityCheck
import ir.cafebazaar.poolakey.request.PurchaseRequest

class PaymentActivity : ComponentActivity() {
    private lateinit var paymentConnection: Connection
    private var isDisposed: Boolean = false
    private var isPurchaseSucc: Boolean = false

    override fun onDestroy() {
        isDisposed = true

        if (isPurchaseSucc)
            BridgeMaker.purchaseSucceed()

        paymentConnection.disconnect()


        // Toast.makeText(this, "onDestroy---------------------", Toast.LENGTH_SHORT).show()

        super.onDestroy()
    }


    lateinit var _activity: PaymentActivity
    lateinit var productId: String

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val base64Key = intent.getStringExtra("BASE64KEY") ?: run {
            Toast.makeText(this, "کلید RSA نامعتبر است", Toast.LENGTH_SHORT).show()
            finish()
            return
        }
        val productId = intent.getStringExtra("productId") ?: run {
            Toast.makeText(this, "شناسه محصول نامعتبر است", Toast.LENGTH_SHORT).show()
            finish()
            return
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
                val purchaseRequest = PurchaseRequest(
                    productId = productId,
                    payload = payload
                )
                payment.purchaseProduct(
                    registry = activityResultRegistry,
                    request = purchaseRequest
                ) {
                    purchaseFlowBegan {
                        // UI بازار باز شد
                    }
                    failedToBeginFlow {
                        Toast.makeText(this@PaymentActivity, "خطا در شروع خرید", Toast.LENGTH_SHORT).show()
                        finish()
                    }
                    purchaseSucceed {
                        isPurchaseSucc = true
                        finish()
                    }
                    purchaseCanceled {
                        Toast.makeText(this@PaymentActivity, "پرداخت لغو شد", Toast.LENGTH_SHORT).show()
                        finish()
                    }
                    purchaseFailed {
                        Toast.makeText(this@PaymentActivity, "خرید ناموفق بود", Toast.LENGTH_SHORT).show()
                        finish()
                    }
                }
            }
            connectionFailed {
                Toast.makeText(this@PaymentActivity, "اتصال به بازار ناموفق بود", Toast.LENGTH_SHORT).show()
                finish()
            }
            disconnected {
                if (!isDisposed) {
                    Toast.makeText(this@PaymentActivity, "اتصال به بازار برقرار نیست", Toast.LENGTH_SHORT).show()
                }
                finish()
            }
        }
    }
    

    
}
