package com.brandingbrand.testtabapp

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.viewpager.widget.ViewPager
import com.brandingbrand.testtabapp.databinding.ActivityMainBinding
import com.brandingbrand.testtabapp.reactgateway.*

import com.brandingbrand.testtabapp.ui.main.SectionsPagerAdapter
import com.google.android.material.tabs.TabLayout


class MainActivity : AppCompatActivity(), ReactGatewayDelegate {

    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val sectionsPagerAdapter = SectionsPagerAdapter(this, supportFragmentManager)
        val viewPager: ViewPager = binding.viewPager
        viewPager.adapter = sectionsPagerAdapter
        val tabs: TabLayout = binding.tabs
        tabs.setupWithViewPager(viewPager)

        ReactGatewayProvider.defaultProvider().gatewayDelegate = this
    }

    // Gateway Delegate overrides
    override fun didReceiveExitEvent(event: ExitEvent) {
        Log.d("EXIT RECEIVED", event.invokingComponent)
    }

    override fun didReceiveDeepLinkEvent(event: DeepLinkEvent) {
        Log.d("DEEP LINK RECEIVED", event.invokingComponent)
        Log.d("DEEP LINK RECEIVED", event.link)
    }

    override fun didReceiveShowPostEvent(event: ShowPostEvent) {
        Log.d("SHOW POST RECEIVED", event.invokingComponent)
        Log.d("SHOW POST RECEIVED", event.postId)
    }

}