package com.brandingbrand.testtabapp.ui.main

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.brandingbrand.testtabapp.BuildConfig
import com.brandingbrand.testtabapp.MainActivity
import com.brandingbrand.testtabapp.MainApplication
import com.brandingbrand.testtabapp.R
import com.facebook.react.PackageList
import com.facebook.react.ReactInstanceManager
import com.facebook.react.ReactPackage
import com.facebook.react.ReactRootView
import com.facebook.react.common.LifecycleState
import com.facebook.soloader.SoLoader


/**
 * A simple [Fragment] subclass.
 * Use the [ReactNativeFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class ReactNativeFragment : Fragment() {
    private var mReactRootView: ReactRootView? = null
    private var mReactInstanceManager: ReactInstanceManager? = null
    fun getMainComponentName(): String {
        return "HybridNativeApp"
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SoLoader.init(activity?.baseContext, false)
        mReactRootView = ReactRootView(activity?.baseContext)
        val packages: List<ReactPackage> = PackageList(activity?.application).packages
        // Packages that cannot be autolinked yet can be added manually here, for example:
        // packages.add(MyReactNativePackage())
        // Remember to include them in `settings.gradle` and `app/build.gradle` too.
        mReactInstanceManager = ReactInstanceManager.builder()
            .setApplication(activity?.application)
            .setCurrentActivity(activity)
            .setBundleAssetName("index.android.bundle")
            .setJSMainModulePath("index")
            .addPackages(packages)
            .setUseDeveloperSupport(BuildConfig.DEBUG)
            .setInitialLifecycleState(LifecycleState.RESUMED)
            .build()
        // The string here (e.g. "MyReactNativeApp") has to match
        // the string in AppRegistry.registerComponent() in index.js
        mReactRootView?.startReactApplication(mReactInstanceManager, getMainComponentName(), null)
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return mReactRootView
    }

    companion object {
        @JvmStatic
        fun newInstance() = ReactNativeFragment()
    }
}