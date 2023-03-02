package com.brandingbrand.testtabapp.reactgateway

import android.annotation.SuppressLint
import android.app.Application
import android.os.Bundle
import com.brandingbrand.testtabapp.BuildConfig
import com.brandingbrand.testtabapp.bridgemodule.BridgeModule
import com.brandingbrand.testtabapp.bridgemodule.BridgeModuleDelegate
import com.brandingbrand.testtabapp.bridgemodule.BridgeModulePackage
import com.facebook.react.PackageList
import com.facebook.react.ReactInstanceManager
import com.facebook.react.ReactPackage
import com.facebook.react.common.LifecycleState
import com.facebook.react.modules.core.DeviceEventManagerModule

interface ReactGatewayDelegate {
    fun didReceiveExitEvent(event: ExitEvent)
    fun didReceiveDeepLinkEvent(event: DeepLinkEvent)
    fun didReceiveShowPostEvent(event: ShowPostEvent)
}

object ReactGatewayProvider : BridgeModuleDelegate {
    var gatewayDelegate: ReactGatewayDelegate? = null

    @SuppressLint("StaticFieldLeak") // Not binding activity to react instance manager
    private var mReactInstanceManager: ReactInstanceManager? = null
    private var mApplication: Application? = null
    var bridgeModule: BridgeModule? = null
        set(value) {
            field = value
            if (value == null) {
                field?.bridgeDelegate = null
            } else {
                field?.bridgeDelegate = this
            }
        }

    //Components
    private const val POST_COMPONENT = "ComponentOne"
    private const val FEED_COMPONENT = "ComponentOne"

    // Initializer
    fun initWithApplication(application: Application) {
        this.mApplication = application
    }

    // Instance Getter
    fun defaultProvider(): ReactGatewayProvider {
        if (mApplication != null) {
            this.mReactInstanceManager = this.mReactInstanceManager ?: initializeInstanceManager()
        } else {
            throw Exception("did not call ReactInstanceManager.initWithApplication() in MainApplication onCreate()")
        }
        return this
    }

    fun currentInstanceManager(): ReactInstanceManager? {
        return this.mReactInstanceManager
    }

    private fun initializeInstanceManager(): ReactInstanceManager {
        val packages: List<ReactPackage> = PackageList(this.mApplication).packages
        return ReactInstanceManager.builder()
            .setApplication(mApplication)
            .setBundleAssetName("index.android.bundle")
            .setJSMainModulePath("index")
            .addPackage(BridgeModulePackage())
            .addPackages(packages)
            .setUseDeveloperSupport(BuildConfig.DEBUG)
            .setInitialLifecycleState(LifecycleState.BEFORE_CREATE)
            .build()
    }

    fun newFeedFragment(initialProps: Bundle?): ReactGatewayFragment {
        return ReactGatewayFragment(FEED_COMPONENT, initialProps)
    }

    fun newFeedActivity(initialProps: Bundle?): ReactGatewayActivity {
        return ReactGatewayActivity(FEED_COMPONENT, initialProps)
    }

    fun newPostFragment(initialProps: Bundle?): ReactGatewayFragment {
        return ReactGatewayFragment(POST_COMPONENT, initialProps)
    }

    fun newPostActivity(initialProps: Bundle?): ReactGatewayActivity {
        return ReactGatewayActivity(POST_COMPONENT, initialProps)
    }

    override fun didReceiveExitEvent(event: ExitEvent) {
        gatewayDelegate?.didReceiveExitEvent(event)
    }

    override fun didReceiveDeepLinkEvent(event: DeepLinkEvent) {
        gatewayDelegate?.didReceiveDeepLinkEvent(event)
    }

    override fun didReceiveShowPostEvent(event: ShowPostEvent) {
        gatewayDelegate?.didReceiveShowPostEvent(event)
    }

    fun sendProfileAttributes() {
        this.mReactInstanceManager?.currentReactContext?.getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
            ?.emit("", null)

    }
}

