# Native / React Native app POC 
## Integration 
TBD but the goal is ios `.framework` and and android `.aar`

## Details
The project is a standard react native app implementation with the ios and android directories containing their repective native apps.
each app is tab based with the third tab being a react native component. They both contain a `ReactNativeGatewayProvider` which serves as the access point
for the react application and its communication. The `ReactNativeGatewayProvider` will return a `ViewController` (iOS) or an `Activity` or `Fragment` (Android).

## Communication
Both platforms use a Broadcast/Delegation hybrid to communicate events from the react application back to native code. From the native perspective iOS and Android 
delegates can be set after instantiating the `ReactNativeGatewayProvider` which is a singleton instance. Because of the hyrbid approach for broadcast and delegation, 
the presenting class does not need to be the class conforming to the delegate. On android this allows an adapter to instantiate fragments while the presenting
activity can manage ownership of the delgate callbacks. 

Initial props can be passed in through the `ReactNativeGatewayProvider` uppon instantiation of the required view, and events can be triggered by the application to be received
by the delegate in the form of a `BrigeModuleEvent`. The `BrigeModuleEvent` contains information about the type of event that was sent (`Exit`, `Action`, `Link` for now), the invoking component and an aditional generic
data object (to be refined later). 


## Implementation 
### iOS
Gateway

```
 let jsBundle = URL.init(string: "http://localhost:8081/index.bundle?platform=ios")!
 let moduleName = "ComponentOne"
 let initialProps = ["foo": "bar"]
        
 let reactGatewayProvider = ReactGatewayProvider.defaultProvider
 reactGatewayProvider.delegate = self
 let reactTab = reactGatewayProvider.newReactGatway(jsBundle: jsBundle,
                                                    moduleName: moduleName,
                                                    initialProps: initialProps)
```

Delegate
```
  func didReceiveReactApplicationEvent(event: BridgeModuleEvent) {
      print("EVENT RECEIVED: \(event.typeDescrition())")
        
      switch (event.eventType) {
      case .exit:
          print("Exit")
            
      case .link:
          print("Link")
            
      case .action:
          print("Action")
            
      default:
          return
      }
  }

```

### Android
Gateway
```
  val propsBundle = Bundle()
  propsBundle.putString("foo", "bar")
  val reactFragment = ReactGatewayProvider.defaultProvider().newReactGatewayFragment("index", "index.android.bundle", propsBundle)
```

Delegate
```
class MainActivity : AppCompatActivity(), ReactGatewayDelegate {
    
    override fun didReceiveReactApplicationEvent(event: BridgeModuleEvent) {
        Log.d("REACT_MESSAGE", event.invokingComponent)
        Log.d("REACT_MESSAGE", event.eventType.toString())
        Log.d("REACT_MESSAGE", event.additionalData.toString())
    }

}
```
