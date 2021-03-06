/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import type {Node} from 'react';
import {
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  TouchableOpacity,
  useColorScheme,
  View,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';

import * as Sentry from '@sentry/react-native';
import {APPCENTER_BUILD_ID} from '@env';
import Config from 'react-native-config';
import {
  getBundleId,
  getBuildNumber,
  getVersion,
} from 'react-native-device-info';
Sentry.init({
  dsn: 'https://09e60221ff1a4e3cbe21fb212ed48629@o52241.ingest.sentry.io/5761533',
  enableNative: false,
  environment: 'development',
  logLevel: 3,
  dist: APPCENTER_BUILD_ID,
  // dist: `${getBuildNumber()}`,
  release: `${getBundleId()}@${getVersion()}+${APPCENTER_BUILD_ID}`,
});
console.log(
  '====>',
  APPCENTER_BUILD_ID,
  Config.APPCENTER_BUILD_ID,
  getBuildNumber(),
  getVersion(),
  `${getBundleId()}}`,
);

let originalHandler = ErrorUtils.getGlobalHandler();
ErrorUtils.setGlobalHandler(function (error, isFatal) {
  Sentry.captureException(new Error(error.message || JSON.stringify(error)));
  originalHandler(error, isFatal);
});

const Section = ({children, title}): Node => {
  const isDarkMode = useColorScheme() === 'dark';
  return (
    <View style={styles.sectionContainer}>
      <Text
        style={[
          styles.sectionTitle,
          {
            color: isDarkMode ? Colors.white : Colors.black,
          },
        ]}>
        {title}
      </Text>
      <Text
        style={[
          styles.sectionDescription,
          {
            color: isDarkMode ? Colors.light : Colors.dark,
          },
        ]}>
        {children}
      </Text>
    </View>
  );
};

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <SafeAreaView style={backgroundStyle}>
      <StatusBar barStyle={isDarkMode ? 'light-content' : 'dark-content'} />
      <ScrollView
        contentInsetAdjustmentBehavior="automatic"
        style={backgroundStyle}>
        <Header />
        <View
          style={{
            backgroundColor: isDarkMode ? Colors.black : Colors.white,
          }}>
          <Section title="Step One">
            Edit <Text style={styles.highlight}>App.js</Text> to change this
            screen and then come back to see your edits.
            <TouchableOpacity
              onPress={() => {
                let a;
                console.log(a());
              }}>
              <Text style={{color: Colors.white}}>Break me</Text>
            </TouchableOpacity>
          </Section>
          <Section title="See Your Changes">
            <ReloadInstructions />
          </Section>
          <Section title="Debug">
            <DebugInstructions />
          </Section>
          <Section title="Learn More">
            Read the docs to discover what to do next:
          </Section>
          <LearnMoreLinks />
          <TouchableOpacity
            onPress={() => {
              throw new Error('My first Sentry error!');
            }}>
            <Text>Break Me</Text>
          </TouchableOpacity>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  sectionContainer: {
    marginTop: 32,
    paddingHorizontal: 24,
  },
  sectionTitle: {
    fontSize: 24,
    fontWeight: '600',
  },
  sectionDescription: {
    marginTop: 8,
    fontSize: 18,
    fontWeight: '400',
  },
  highlight: {
    fontWeight: '700',
  },
});

export default App;
