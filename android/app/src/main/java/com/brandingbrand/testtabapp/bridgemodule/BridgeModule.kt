package com.brandingbrand.testtabapp.bridgemodule

import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.UiThreadUtil
import org.greenrobot.eventbus.EventBus

class BridgeModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    @ReactMethod
    fun dispatchApplicationEvent(data: ReadableMap) {
        broadcastData(data)
    }

    override fun getName(): String {
        return "BridgeModule"
    }

    private fun broadcastData(data: ReadableMap) {
        UiThreadUtil.runOnUiThread{
            val event = BridgeModuleEvent(data)
            EventBus.getDefault().post(event)
        }
    }
}

