package com.bazaar;

import com.adobe.air.AndroidActivityWrapper;
import com.bazaar.poolakey.KotlinController;
import com.tuarua.frekotlin.FreKotlinContext;
import com.tuarua.frekotlin.FreKotlinMainController;


public class PoolakeyANEContext extends FreKotlinContext {
    private AndroidActivityWrapper aaw;
    private KotlinController kc;

    @SuppressWarnings("WeakerAccess")
    public PoolakeyANEContext(String name, FreKotlinMainController controller, String[] functions) {
        super(name, controller, functions);
        kc = (KotlinController) this.controller;
        aaw = AndroidActivityWrapper.GetAndroidActivityWrapper();
        aaw.addActivityResultListener(kc);
        aaw.addActivityStateChangeListner(kc);
    }

    @Override
    public void dispose() {
        super.dispose();
        if (aaw != null) {
            aaw.removeActivityResultListener(kc);
            aaw.removeActivityStateChangeListner(kc);
            aaw = null;
        }
    }
}
