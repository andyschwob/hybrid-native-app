package com.brandingbrand.testtabapp.reactgateway

import com.facebook.react.bridge.ReadableMap

class ShowPostEvent(data: ReadableMap) {
    val props: ShowPostProps = ShowPostProps(data)
    val invokingComponent: String? = data.getString("component")

    fun isValidEvent(): Boolean {
        if (props.areValidProps() &&
            !invokingComponent.isNullOrEmpty()) {
            return true
        }
        return false
    }
}