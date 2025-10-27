# **Poolakey ANE (AIR/ActionScript)**

پرداخت درون‌برنامه‌ای و اشتراک‌های **کافه‌بازار** برای اپ‌های **Adobe AIR (Android)**.  
 این ANE یک بریج کامل بین **ActionScript** و **Poolakey (Kotlin)** فراهم می‌کند: خرید محصول/اشتراک، کوئری اشتراک‌های فعال کاربر، مصرف inapp، و بررسی واجد شرایط بودن **Trial**.

---

## **پیش‌نیازها**

* **Android** (AIR for Android)

* **کافه‌بازار** روی دستگاه نصب و کاربر لاگین‌شده باشد

* **RSA Public Key** از کنسول بازار (برای SecurityCheck)

* AIR SDK \+ VSCode/IDE دلخواه

  ---

  ## **نصب**

1. فایل ANE را در پوشهٔ `lib/` پروژه قرار بده (مثلاً `lib/PoolakeyPayment.ane`).

2. در `asconfig.json`:
   

````json
{
"compilerOptions": {
     "library-path": [
       "lib/PoolakeyPayment.ane"
     ]
   },
"airOptions": { 
     "android": { 
       "extdir": ["./lib"]
     } 
   }
}
````
3. در Application Descriptor (XML):
```` xml
<extensions> 
   <extensionID>androidx.core</extensionID>
   <extensionID>com.jetbrains.kotlin</extensionID>
   <extensionID>com.bazaar.poolakey</extensionID>
</extensions>  
````    

  ## **پیکربندی AndroidManifest**

اگر از manifest سفارشی استفاده می‌کنی، موارد زیر را اضافه کن:
```` xml

<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="com.farsitel.bazaar.permission.PAY_THROUGH_BAZAAR" />
  

<queries>  
   <package android:name="com.farsitel.bazaar" />
</queries>
<application> 
<activity
       android:name="com.bazaar.poolakey.PaymentActivity" 
       android:exported="true" 
       android:configChanges="keyboardHidden|orientation" 
       android:screenOrientation="portrait"
       android:theme="@android:style/Theme.Translucent.NoTitleBar" />
<receiver
            android:name="ir.cafebazaar.poolakey.receiver.BillingReceiver"
            android:exported="true" >
            <intent-filter>
                <action android:name="com.farsitel.bazaar.purchase" />
                <action android:name="com.farsitel.bazaar.billingSupport" />
                <action android:name="com.farsitel.bazaar.consume" />
                <action android:name="com.farsitel.bazaar.getPurchase" />
                <action android:name="com.farsitel.bazaar.skuDetail" />
                <action android:name="com.farsitel.bazaar.checkTrialSubscription" />
            </intent-filter>
</receiver>
</application> 
    
````

  ## **رویدادها**

این رویدادها از ANE به ActionScript  ارسال می‌شوند:

| Event code | توضیح | `event.level` |
| ----- | ----- | ----- |
| `TRACE` | لاگ دیباگ | متن |
| `PURCHASE_FLOW_BEGAN` | UI خرید بازار باز شد | `"inapp"` یا `"subs"` |
| `PURCHASE_SUCCESS` | خرید موفق | `"purchase_success"` یا JSON خرید |
| `SUBSCRIPTIONS_RESULT` | نتیجهٔ اشتراک‌ها | JSON آرایه‌ای از `{productId,purchaseToken,purchaseState,purchaseTime}` |
| `INAPP_PURCHASES_RESULT` | نتیجهٔ inappهای کاربر | JSON آرایه‌ای مشابه بالا |
| `CONSUME_RESULT` | نتیجهٔ مصرف inapp | `{"ok":true}` یا `{"error":"..."}` |
| `TRIAL_SUBSCRIPTION_RESULT` | وضعیت واجد شرایط بودن Trial | `{"isAvailable":bool,"trialPeriodDays":int}` یا `{"error":"..."}` |
| `BEGIN_FLOW_FAILED` / `PURCHASE_CANCELED` / `PURCHASE_FAILED` / `CONNECTION_FAILED` / `DISCONNECTED` | خطاها/وضعیت‌ها | متن |

---

## 

## **متدهای ActionScript**

رپر AS3 در کلاس BazaarPoolakyPayment:

```` ActionScript
// خرید اشتراک/محصول  
launchBazaarPayment(rsa:String, sku:String, payload:String="dev_pay"):void   
// گرفتن اشتراک‌های فعال کاربر  
getSubscriptions(rsa:String):void 
// گرفتن inappهای کاربر (مصرفی/غیرمصرفی) 
getPurchasedInapps(rsa:String):void 
// مصرف کردن inapp با purchaseToken 
consumeInapp(token:String):void
// بررسی واجد شرایط بودن Trial (قبل از خرید)
checkTrialSubscription(rsa:String):void 
    
```` 

  ## **نمونهٔ استفاده سریع**
```` ActionScript
import com.bazaar.BazaarPoolakyPayment;
import com.bazaar.PoolakeyEvent;
  
const RSA:String = "----- YOUR RSA PUBLIC KEY FROM BAZAAR -----";
const SUB_SKU:String = "your.subscription.sku"; // مثلا sub_60

var pay:BazaarPoolakyPayment = BazaarPoolakyPayment.instance;

// رویدادها 
pay.addEventListener(PoolakeyEvent.PURCHASE_FLOW_BEGAN, onFlowBegan);
pay.addEventListener(PoolakeyEvent.PURCHASE_SUCCESS, onPurchaseSuccess);
pay.addEventListener(PoolakeyEvent.SUBSCRIPTIONS_RESULT, onSubsResult);
pay.addEventListener(PoolakeyEvent.INAPP_PURCHASES_RESULT, onInappsResult);
pay.addEventListener(PoolakeyEvent.CONSUME_RESULT, onConsumeResult);
pay.addEventListener(PoolakeyEvent.TRIAL_SUBSCRIPTION_RESULT, onTrialInfo);
// شروع خرید 
pay.launchBazaarPayment(RSA, SUB_SKU, "optional_payload");
   
// بررسی Trial قبل از خرید (اختیاری)
pay.checkTrialSubscription(RSA);
  
// بررسی وضعیت اشتراک‌ها (شروع اپ یا بعد از خرید)  
pay.getSubscriptions(RSA);

// مصرف کردن آیتم خریدنی
pay.consumeInapp(token:String);
  
// هندلرها  
function onFlowBegan(e:PoolakeyEvent):void {
   trace("FLOW:", e.level); // "inapp" یا "subs"
}
  
function onPurchaseSuccess(e:PoolakeyEvent):void {
   trace("PURCHASE_SUCCESS:", e.data); // ممکنه "purchase_success" یا JSON باشد
   pay.getSubscriptions(RSA);
}  
 
function onSubsResult(e:PoolakeyEvent):void {
   if (!e.data || e.data.charAt(0) != "[") {
     trace("SUBSCRIPTIONS_RESULT error or invalid:", e.data);
     return; 
} 
const subs:Array = JSON.parse(e.data) as Array;
const active:Boolean = subs.some(function(s:Object, ...rest):Boolean {
     return s.productId == SUB_SKU;
});
  trace("is active:", active);
}
   
function onInappsResult(e:PoolakeyEvent):void {
   trace("INAPPS:", e.data); // JSON array یا {"error":...}
} 
   
function onConsumeResult(e:PoolakeyEvent):void {
   trace("CONSUME:", e.data); // {"ok":true} یا {"error":...}
} 
  
function onTrialInfo(e:PoolakeyEvent):void {
   const o:Object = JSON.parse(e.data); 
   if (o.error) { trace("TRIAL error:", o.error); return; }
   trace("trial available:", o.isAvailable, "days:", o.trialPeriodDays)
}

`````
**نکتهٔ مهم Trial:**  
 checkTrialSubscription فقط *واجد شرایط بودن برای دریافت تریال در خرید بعدی* را می‌گوید؛ برای تشخیص «تریال/اشتراک فعّال فعلی» از getSubscriptions (و ترجیحاً تأیید سروری) استفاده کنید.


