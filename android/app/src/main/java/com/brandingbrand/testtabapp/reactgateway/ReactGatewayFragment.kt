package com.brandingbrand.testtabapp.reactgateway

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import com.facebook.react.ReactRootView
import com.facebook.soloader.SoLoader


class ReactGatewayFragment(private var componentName: String,
                           private var initialProps: Bundle?
                           ) : Fragment() {

    private var mReactRootView: ReactRootView? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        SoLoader.init(activity?.baseContext, false)
        mReactRootView = ReactRootView(activity?.baseContext)
        val reactInstanceManager = ReactGatewayProvider.defaultProvider().currentInstanceManager()
        mReactRootView?.startReactApplication(reactInstanceManager, componentName, initialProps)
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return mReactRootView
    }

}