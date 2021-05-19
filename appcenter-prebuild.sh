brew install jq

react-native bundle --dev false --platform ios --entry-file index.js --bundle-output ./main.jsbundle --sourcemap-output ./main.jsbundle.map
react-native bundle --dev false --platform android --entry-file index.js --bundle-output ./index.android.bundle --sourcemap-output ./index.android.bundle.map

export SENTRY_PROPERTIES=./ios/sentry.properties
BUNDLE_ID_IOS="org.reactjs.native.example.senntry"
APP_VERSION=$(cat package.json | jq -r .version)
SENTRY_VERSION="$BUNDLE_ID_IOS@${APP_VERSION}+$APPCENTER_BUILD_ID"

echo “APPCENTER_BUILD_ID=$APPCENTER_BUILD_ID” >> .env
echo “SENTRY_VERSION=$SENTRY_VERSION” >> .env

echo "build Id is $APPCENTER_BUILD_ID"