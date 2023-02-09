package com.brandingbrand.testtabapp.bridgemodule

import com.facebook.react.bridge.ReadableMap

enum class Type {
    EXIT,
    ACTION,
    LINK
}

class BridgeModuleEvent(data: ReadableMap) : java.io.Serializable {
    val eventType: Type
    val invokingComponent: String
    val additionalData: HashMap<String, Any>

    init {
        eventType = serializeEventType(data)
        invokingComponent = getComponent(data)
        additionalData = getExtraData(data)
    }

    private fun serializeEventType(data: ReadableMap) : Type {
        return when (data.getString("event")) {
            "EXIT" -> Type.EXIT
            "ACTION" -> Type.ACTION
            "LINK" -> Type.LINK
            else -> Type.EXIT
        }
    }

    private fun getComponent(data: ReadableMap): String {
        return if (data.hasKey("component") && !data.getString("component").isNullOrEmpty()) {
            data.getString("component") as String
        } else {
            ""
        }
    }

    private fun getExtraData(data: ReadableMap): HashMap<String, Any> {
        return if (data.hasKey("data")) {
            data.getMap("data")?.toHashMap() as HashMap<String, Any>
        } else {
            hashMapOf("" to "")
        }
    }

}