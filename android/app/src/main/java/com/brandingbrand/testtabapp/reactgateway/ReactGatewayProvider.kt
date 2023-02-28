package com.brandingbrand.testtabapp.reactgateway

import android.os.Bundle
import android.util.Log
import com.brandingbrand.testtabapp.bridgemodule.BridgeModule
import com.brandingbrand.testtabapp.bridgemodule.BridgeModuleDelegate

interface ReactGatewayDelegate {
    fun didReceiveExitEvent(event: ExitEvent)
    fun didReceiveDeepLinkEvent(event: DeepLinkEvent)
    fun didReceiveShowPostEvent(event: ShowPostEvent)
}

object ReactGatewayProvider : BridgeModuleDelegate {
    var gatewayInterface: ReactGatewayDelegate? = null
    var bridgeModule: BridgeModule? = null
        set(value) {
            field = value
            if (value == null) {
                field?.bridgeDelegate = null
            } else {
                field?.bridgeDelegate = this
            }
        }

    fun defaultProvider(): ReactGatewayProvider {
        return this
    }

    fun newReactGatewayFragment(modulePath: String, bundleAssetName: String, initialProps: Bundle?): ReactGatewayFragment {
        return ReactGatewayFragment(modulePath, bundleAssetName, initialProps)
    }

    fun newReactGatewayActivity(modulePath: String, bundleAssetName: String, initialProps: Bundle?): ReactGatewayActivity {
        return ReactGatewayActivity(modulePath, bundleAssetName, initialProps)
    }

    override fun didReceiveExitEvent(event: ExitEvent) {
        gatewayInterface?.didReceiveExitEvent(event)
    }

    override fun didReceiveDeepLinkEvent(event: DeepLinkEvent) {
        gatewayInterface?.didReceiveDeepLinkEvent(event)
    }

    override fun didReceiveShowPostEvent(event: ShowPostEvent) {
        gatewayInterface?.didReceiveShowPostEvent(event)
    }

}

