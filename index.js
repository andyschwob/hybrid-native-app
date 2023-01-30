import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View
} from 'react-native';
const ReactNativeTest = () => {
  return (
    <View style={styles.container}>
      <Text style={styles.hello}>React Native Test</Text>
    </View>
  );
};
var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center'
  },
  hello: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10
  }
});
AppRegistry.registerComponent(
  'HybridNativeApp',
  () => ReactNativeTest
);