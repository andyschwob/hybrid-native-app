import React from "react";
import { NativeModules } from "react-native";
import { AppRegistry, StyleSheet, Text, View } from "react-native";

const { BridgeModule } = NativeModules;
const EventType = {
  exit: "EXIT",
  action: "ACTION",
  link: "LINK",
}
const ReactNativeTest = () => {
  BridgeModule.dispatchApplicationEvent({
    component: "ComponentOne",
    event: EventType.exit,
    data: {
      data : "ADDITIONAL DATA",
      moreData: "More Data"
    }
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
