
brew install react-native-cli
react-native bundle --dev false --platform ios --entry-file index.js --bundle-output ./main.jsbundle --sourcemap-output ./main.jsbundle.map

export SENTRY_PROPERTIES=./ios/sentry.properties
echo "Current branch is $APPCENTER_BRANCH"
echo "Current branch is $APPCENTER_BRANCH"

./node_modules/@sentry/cli/bin/sentry-cli releases files "0.0.1" upload-sourcemaps --dist "0.0.1" --rewrite ./main.jsbundle ./main.jsbundle.map
