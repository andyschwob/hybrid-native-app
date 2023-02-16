package com.brandingbrand.testtabapp.reactgateway

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.brandingbrand.testtabapp.*
import com.brandingbrand.testtabapp.bridgemodule.BridgeModulePackage
import com.facebook.react.PackageList
import com.facebook.react.ReactInstanceManager
import com.facebook.react.ReactPackage
import com.facebook.react.ReactRootView
import com.facebook.react.common.LifecycleState
import com.facebook.soloader.SoLoader


class ReactGatewayFragment(private var modulePath: String,
                           private var bundleAssetName: String,
                           private var initialProps: Bundle?
                           ) : Fragment() {

    private var mReactRootView: ReactRootView? = null
    private var mReactInstanceManager: ReactInstanceManager? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SoLoader.init(activity?.baseContext, false)

        mReactRootView = ReactRootView(activity?.baseContext)

        val packages: List<ReactPackage> = PackageList(activity?.application).packages
        mReactInstanceManager = ReactInstanceManager.builder()
            .setApplication(activity?.application)
            .setCurrentActivity(activity)
            .setBundleAssetName(bundleAssetName) //"index.android.bundle"
            .setJSMainModulePath(modulePath) // index
            .addPackage(BridgeModulePackage())
            .addPackages(packages)
            .setUseDeveloperSupport(BuildConfig.DEBUG)
            .setInitialLifecycleState(LifecycleState.RESUMED)
            .build()

        mReactRootView?.startReactApplication(mReactInstanceManager, getMainComponentName(), initialProps)
    }

    private fun getMainComponentName(): String {
        return "ComponentOne"
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return mReactRootView
    }

}