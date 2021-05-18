
brew install react-native-cli
react-native bundle --dev false --platform ios --entry-file index.js --bundle-output ./main.jsbundle --sourcemap-output ./main.jsbundle.map
react-native bundle --dev false --platform android --entry-file index.js --bundle-output ./index.android.bundle --sourcemap-output ./index.android.bundle.map

export SENTRY_PROPERTIES=./ios/sentry.properties
BUNDLE_ID_IOS="org.reactjs.native.example.senntry"

echo "Current branch is $APPCENTER_BUILD_ID"
SENTRY_VERSION="$BUNDLE_ID_IOS@1.0+$APPCENTER_BUILD_ID"
echo "Current branch is $SENTRY_VERSION"
echo "Current branch is $APPCENTER_SOURCE_DIRECTORY"

./node_modules/@sentry/cli/bin/sentry-cli releases files $SENTRY_VERSION upload-sourcemaps --dist $APPCENTER_BUILD_ID --strip-prefix "$APPCENTER_SOURCE_DIRECTORY/src" --rewrite ./main.jsbundle ./main.jsbundle.map
./node_modules/@sentry/cli/bin/sentry-cli releases files $SENTRY_VERSION upload-sourcemaps --dist $APPCENTER_BUILD_ID --strip-prefix "$APPCENTER_SOURCE_DIRECTORY/src" --rewrite index.android.bundle index.android.bundle.map
