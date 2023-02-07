package com.brandingbrand.testtabapp

import android.util.Log
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod
import com.facebook.react.bridge.ReadableMap

class BridgeModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    override fun getName(): String {
        return "BridgeModule"
    }

    @ReactMethod
    fun dispatchApplicationEvent(data: ReadableMap) {
        Log.d("RECEIVED DATA", data.toString());
    }
}