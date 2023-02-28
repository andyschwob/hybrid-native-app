package com.brandingbrand.testtabapp.bridgemodule

import android.util.Log
import com.brandingbrand.testtabapp.reactgateway.DeepLinkEvent
import com.brandingbrand.testtabapp.reactgateway.ExitEvent
import com.brandingbrand.testtabapp.reactgateway.ReactGatewayProvider
import com.brandingbrand.testtabapp.reactgateway.ShowPostEvent
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.UiThreadUtil
import java.net.URL

interface BridgeModuleDelegate {
    fun didReceiveExitEvent(event: ExitEvent)
    fun didReceiveDeepLinkEvent(event: DeepLinkEvent)
    fun didReceiveShowPostEvent(event: ShowPostEvent)
}

class BridgeModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    var bridgeDelegate: BridgeModuleDelegate? = null

    init {
        super.initialize()
        ReactGatewayProvider.defaultProvider().bridgeModule = this
    }

    @ReactMethod
    fun dispatchExitEvent(data: ReadableMap) {
        Log.d("EXIT RECEIVED", "derp")
        UiThreadUtil.runOnUiThread{
            val component = data.getString("component") ?: return@runOnUiThread
            val event = ExitEvent(component)
            bridgeDelegate?.didReceiveExitEvent(event)
        }
    }

    @ReactMethod
    fun dispatchDeepLinkEvent(data: ReadableMap) {
        UiThreadUtil.runOnUiThread{
            val component = data.getString("component") ?: return@runOnUiThread
            val link = data.getString("link") ?: return@runOnUiThread
            val event = DeepLinkEvent(link, component)
            bridgeDelegate?.didReceiveDeepLinkEvent(event)
        }
    }

    @ReactMethod
    fun dispatchShowPostEvent(data: ReadableMap) {
        UiThreadUtil.runOnUiThread{
            val component = data.getString("component") ?: return@runOnUiThread
            val postId = data.getString("postId") ?: return@runOnUiThread
            val event = ShowPostEvent(postId, component)
            bridgeDelegate?.didReceiveShowPostEvent(event)
        }
    }
    override fun getName(): String {
        return "BridgeModule"
    }
}

