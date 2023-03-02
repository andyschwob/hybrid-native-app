package com.brandingbrand.testtabapp
import android.app.Application
import com.brandingbrand.testtabapp.reactgateway.ReactGatewayProvider

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        ReactGatewayProvider.initWithApplication(this)
    }
}
