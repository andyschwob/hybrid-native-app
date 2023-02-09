package com.brandingbrand.testtabapp.reactgateway

import android.app.Activity
import android.os.Bundle
import com.brandingbrand.testtabapp.bridgemodule.BridgeModulePackage
import com.brandingbrand.testtabapp.BuildConfig
import com.facebook.react.PackageList
import com.facebook.react.ReactInstanceManager
import com.facebook.react.ReactPackage
import com.facebook.react.ReactRootView
import com.facebook.react.common.LifecycleState
import com.facebook.soloader.SoLoader

class ReactGatewayActivity(private var modulePath: String,
                           private var bundleAssetName: String,
                           private var initialProps: Bundle?
                           ): Activity() {

    private var mReactRootView: ReactRootView? = null
    private var mReactInstanceManager: ReactInstanceManager? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SoLoader.init(baseContext, false)
        mReactRootView = ReactRootView(baseContext)

        val packages: List<ReactPackage> = PackageList(application).packages

        mReactInstanceManager = ReactInstanceManager.builder()
            .setApplication(application)
            .setCurrentActivity(this)
            .setBundleAssetName(bundleAssetName)
            .setJSMainModulePath(modulePath)
            .addPackage(BridgeModulePackage())
            .addPackages(packages)
            .setUseDeveloperSupport(BuildConfig.DEBUG)
            .setInitialLifecycleState(LifecycleState.RESUMED)
            .build()

        mReactRootView?.startReactApplication(mReactInstanceManager, getMainComponentName(), initialProps)
        setContentView(mReactRootView)
    }

    private fun getMainComponentName(): String {
        return "ComponentOne"
    }
}