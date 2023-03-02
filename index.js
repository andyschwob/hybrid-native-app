import React, { useCallback, useState, useEffect } from "react"
import EngagementLite, { EngagementCompGhost } from '@brandingbrand/fsengagementlite';
import { AppRegistry, NativeEventEmitter, NativeModules, StyleSheet, View } from "react-native";

const { BridgeModule, BridgeModuleEventEmitter } = NativeModules;

const handleDeepLink = link => {
  // Dispatch deep link to receiving application.
  BridgeModule.dispatchDeepLinkEvent({
    component: "ComponentOne",
    url: link
  });
};

const handleNavigateToPost = data => {
  const { postId, json, title, dynamicData, path } = data;
  //Dispatch show post event to receiving application.
  BridgeModule.dispatchShowPostEvent({
    component: "ComponentOne",
    data: {
      postId,
      json,
      name: title,
      dynamicData
    }
  });
};

const handleBackPress = () => {
  // Dispatch for application exit so the receiving native code can handle navigation.
  BridgeModule.dispatchExitEvent({
    component: "ComponentOne",
  });
};

const { engagementService, EngagementComp } = EngagementLite({
  appId: 'f547cb88-d59b-4edb-8ae9-f067c1cc5010', // Core example app (Hybrid Native App)
  baseURL: 'https://api.brandingbrand.com/engagement-general/v1',
  cacheTTL: 0,
  handleDeepLink,
  handleNavigateToPost,
  handleBackPress
});

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

const EngagementFeed = () => {

  const eventEmitter = new NativeEventEmitter(BridgeModuleEventEmitter);

  const [loading, setLoading] = useState(true);
  const [posts, setPosts] = useState([]);
  const [attributesArr, setAttributesArr] = useState([]);

  const fetchEngagementInbox = async () => {
    await engagementService.getProfile(); // add user info?
    const attributes = JSON.stringify(attributesArr);
  
    const inboxResponse = await engagementService.getInboxMessages({ attributes });
    const sorted = await engagementService.sortInbox(inboxResponse);
    return sorted.map(inboxPost => (inboxPost.message));
  } 

  const fetchDiscover = useCallback(async () => {
    await fetchEngagementInbox()
      .then(posts => {
        setLoading(false);
        setPosts(
          posts.map(post => ({
            id: post.id,
            name: post.title,
            ...post.content
          }))
        );
      })
      .catch(() => {
        setLoading(false);
      });
  }, [setLoading, setPosts]);

  useEffect(() => {
    fetchDiscover().catch(e => console.error(e));
  }, []);

  eventEmitter.addListener("onUpdateProfileAttributes", profileAttributes => {
    // example attributes object:
    // {
    //   gender: 'male',
    //   age: 21,
    //   country_code: 'US',
    //   isLoggedIn: true
    // }
    const attr = [];
    for (const [key, value] of Object.entries(profileAttributes)) {
      attr.push({
        key,
        value,
        type: typeof value || 'string'
      });
    }
    setAttributesArr(attr);
    fetchDiscover().catch(e => console.error(e));
  });

  const json = { private_type: 'feed', private_blocks: posts };

  if (loading) {
    return <EngagementCompGhost />;
  }

  return (
    <View style={styles.container}>
      <EngagementComp
        refreshControl={fetchDiscover}
        isLoading={false}
        json={json}
      />
    </View>
  );
};


const EngagementStory = (props) => {
  const { json, backButton = false, name, id } = props;

  return (
    <View style={styles.container}>
      <EngagementComp
        isLoading={false}
        json={json}
        backButton={backButton}
        name={name}
        id={id}
      />
    </View>
  );
};

AppRegistry.registerComponent("ComponentOne", () => EngagementFeed);
AppRegistry.registerComponent("StoryComponent", () => EngagementStory);
