import React from "react";
import { NativeModules } from "react-native";
import { AppRegistry, StyleSheet, Text, View } from "react-native";

const { BridgeModule } = NativeModules;

const ReactNativeTest = () => {

  // Dispatch for application exit so the receiving native code can handle navigation.
  BridgeModule.dispatchExitEvent({
    component: "ComponentOne",
  });

  // Dispatch deep link to receiving application. 
  BridgeModule.dispatchDeepLinkEvent({
    component: "ComponentOne",
    url: "/discover/messageid"
  });

  //Dispatch show post event to receiving application. 
  BridgeModule.dispatchShowPostEvent({
    component: "ComponentOne",
    postId: "1337"
  });

  return (
    <View style={styles.container}>
      <Text style={styles.hello}>React Native Test</Text>
    </View>
  );
};
var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
  },
  hello: {
    fontSize: 20,
    textAlign: "center",
    margin: 10,
  },
});
AppRegistry.registerComponent("ComponentOne", () => ReactNativeTest);
