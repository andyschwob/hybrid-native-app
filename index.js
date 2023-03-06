import React, { useCallback, useState, useEffect } from "react"
import EngagementLite, { EngagementCompGhost } from '@brandingbrand/fsengagementlite';
import { AppRegistry, NativeEventEmitter, NativeModules, StyleSheet, Text, View } from "react-native";

const { BridgeModule, BridgeModuleEventEmitter } = NativeModules;

const handleDeepLink = url => {
  // Dispatch deep link to receiving application.
  BridgeModule.dispatchDeepLinkEvent({
    component: "ComponentOne",
    data: {
      url,
      tag
    }
  });
};

const handleNavigateToPost = data => {
  const { postId, json, title, dynamicData, tag } = data;
  //Dispatch show post event to receiving application.
  BridgeModule.dispatchShowPostEvent({
    component: "ComponentOne",
    data: {
      postId,
      json,
      name: title,
      dynamicData,
      tag
    }
  });
};

const handleBackPress = () => {
  // Dispatch for application exit so the receiving native code can handle navigation.
  BridgeModule.dispatchExitEvent({
    component: "ComponentOne",
  });
};


var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
  },
  errorText: {
    fontSize: 16,
    textAlign: "center",
    margin: 10,
  },
});
let EngagementRenderer;
const EngagementFeed = ({ appId }) => {

  const [loading, setLoading] = useState(true);
  const [errorMessage, setErrorMessage] = useState('');
  const [posts, setPosts] = useState([]);
  const [attributesArr, setAttributesArr] = useState([]);

  if (!appId || appId === '') {
    return (
      <View style={styles.container}>
        <Text style={styles.errorText}>No App Id provided</Text>
      </View>
    );
  }

  const { engagementService, EngagementComp } = EngagementLite({
    appId,
    baseURL: 'https://api.brandingbrand.com/engagement-general/v1',
    cacheTTL: 0,
    handleDeepLink,
    handleNavigateToPost,
    handleBackPress
  });
  EngagementRenderer = EngagementComp;

  const eventEmitter = new NativeEventEmitter(BridgeModuleEventEmitter);

  const fetchEngagementInbox = async () => {
    const profile = await engagementService.getProfile(); // add user info?
    if (!profile) {
      throw 'invalid_id';
    }
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
      .catch(e => {
        if (e === 'invalid_id') {
          setErrorMessage('App Id is invalid.')
        }
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

  if (errorMessage) {
    return (
      <View style={styles.container}>
        <Text style={styles.errorText}>{errorMessage}</Text>
      </View>
    )
  }
  if (loading) {
    return <EngagementCompGhost />;
  }

  return (
    <View style={styles.container}>
      <EngagementRenderer
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
      <EngagementRenderer
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
