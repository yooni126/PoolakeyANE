package com.bazaar;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREExtension;
import com.bazaar.poolakey.KotlinController;

@SuppressWarnings({"unused", "WeakerAccess", "FieldCanBeLocal"})
public class PoolakeyANE implements FREExtension {
    private String NAME = "com.bazaar.PoolakeyANE";
    private static final String[] FUNCTIONS = {
             "launchBazaarPayment",
             "getSubscriptions",
             "getPurchasedInapps",
             "consumeInapp",
             "checkTrialSubscription",
             "ping",
             "listFunctions"
    };

    public static PoolakeyANEContext extensionContext;

    @Override
    public void initialize() {

    }
    

    @Override
    public FREContext createContext(String s) {
        return extensionContext = new PoolakeyANEContext(NAME, new KotlinController(), FUNCTIONS);
    }

    @Override
    public void dispose() {
        extensionContext.dispose();
    }
}
