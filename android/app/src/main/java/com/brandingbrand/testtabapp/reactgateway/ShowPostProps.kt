package com.brandingbrand.testtabapp.reactgateway

import android.os.Bundle
import androidx.annotation.RequiresPermission.Read
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.ReadableMap

class ShowPostProps(data: ReadableMap) {
    val postId: String? = data.getString("postId")
    val json: String? = data.getString("json")
    val name: String? = data.getString("name")
    val dynamicData: ReadableMap? = data.getMap("dynamicData")

    fun areValidProps() : Boolean {
        if (!postId.isNullOrEmpty() &&
            !json.isNullOrEmpty() &&
            !name.isNullOrEmpty()) {
            return true
        }
        return false
    }

    fun getJsObjectRepresentation(): Bundle {
        val bundle = Bundle()
        bundle.putString("id", postId)
        bundle.putString("name", name)
        bundle.putString("json", json)
        bundle.putSerializable("dynamicData", dynamicData?.toHashMap())
        return bundle
    }
}