package com.brandingbrand.testtabapp.ui.main

import android.content.Context
import android.os.Bundle
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentPagerAdapter
import com.brandingbrand.testtabapp.R
import com.brandingbrand.testtabapp.reactgateway.ReactGatewayProvider
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableMap
import com.facebook.react.bridge.WritableMap

private val TAB_TITLES = arrayOf(
        R.string.tab_text_1,
        R.string.tab_text_2,
        R.string.tab_text_3
)

class SectionsPagerAdapter(private val context: Context, fm: FragmentManager)
    : FragmentPagerAdapter(fm) {

    override fun getItem(position: Int): Fragment {
        while(position < 2) {
            return PlaceholderFragment.newInstance(position + 1)
        }

        val propsBundle = Bundle()
        propsBundle.putString("foo", "bar")
        return ReactGatewayProvider.defaultProvider().newFeedFragment(null)
    }

    override fun getPageTitle(position: Int): CharSequence? {
        return context.resources.getString(TAB_TITLES[position])
    }

    override fun getCount(): Int {
        return 3
    }
}