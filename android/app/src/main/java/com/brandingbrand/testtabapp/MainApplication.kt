package com.brandingbrand.testtabapp

import android.app.Application

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        SoLoader.init(this, false)
    }

    private val mReactNativeHost: ReactNativeHost = object : ReactNativeHost(this) {
        val useDeveloperSupport: Boolean
            get() = BuildConfig.DEBUG

        // Packages that cannot be autolinked yet can be added manually here
        protected val packages: List<Any>
            protected get() =// Packages that cannot be autolinked yet can be added manually here
                PackageList(this).getPackages()

        protected val jSMainModuleName: String
            protected get() = "myreactnativeapp"

        @get:Nullable
        protected val bundleAssetName: String
            protected get() = "index.android.bundle"
    }
    val reactNativeHost: ReactNativeHost
        get() = mReactNativeHost
}