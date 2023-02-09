package com.brandingbrand.testtabapp

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.viewpager.widget.ViewPager
import com.brandingbrand.testtabapp.bridgemodule.BridgeModuleEvent
import com.brandingbrand.testtabapp.databinding.ActivityMainBinding

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

        ReactGatewayProvider.defaultProvider().gatewayInterface = this
    }

    override fun didReceiveReactApplicationEvent(event: BridgeModuleEvent) {
        Log.d("REACT_MESSAGE", event.invokingComponent)
        Log.d("REACT_MESSAGE", event.eventType.toString())
        Log.d("REACT_MESSAGE", event.additionalData.toString())
    }

}