package com.brandingbrand.testtabapp.reactgateway

import android.app.Activity
import android.os.Bundle
import com.facebook.react.ReactRootView
import com.facebook.soloader.SoLoader

class ReactGatewayActivity(private var componentName: String,
                           private var initialProps: Bundle?
                           ): Activity() {

    private var mReactRootView: ReactRootView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SoLoader.init(baseContext, false)
        mReactRootView = ReactRootView(baseContext)

        val reactInstanceManager = ReactGatewayProvider.defaultProvider().currentInstanceManager()
        mReactRootView?.startReactApplication(reactInstanceManager, componentName, initialProps)
    }

}