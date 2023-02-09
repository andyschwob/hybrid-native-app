package com.brandingbrand.testtabapp

import android.os.Bundle
import com.brandingbrand.testtabapp.bridgemodule.BridgeModuleEvent
import com.brandingbrand.testtabapp.reactgateway.ReactGatewayActivity
import com.brandingbrand.testtabapp.reactgateway.ReactGatewayFragment
import org.greenrobot.eventbus.EventBus
import org.greenrobot.eventbus.Subscribe
import org.greenrobot.eventbus.ThreadMode

interface ReactGatewayDelegate {
    fun didReceiveReactApplicationEvent(event: BridgeModuleEvent)
}

object ReactGatewayProvider {
    var gatewayInterface: ReactGatewayDelegate? = null

    fun defaultProvider(): ReactGatewayProvider {
        return this
    }

    init {
        EventBus.getDefault().register(this)
    }

    fun newReactGatewayFragment(modulePath: String, bundleAssetName: String, initialProps: Bundle?): ReactGatewayFragment {
        return ReactGatewayFragment(modulePath, bundleAssetName, initialProps)
    }

    fun newReactGatewayActivity(modulePath: String, bundleAssetName: String, initialProps: Bundle?): ReactGatewayActivity {
        return ReactGatewayActivity(modulePath, bundleAssetName, initialProps)
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    fun onMessageEvent(event: BridgeModuleEvent) {
        gatewayInterface?.didReceiveReactApplicationEvent(event)
    }

}

