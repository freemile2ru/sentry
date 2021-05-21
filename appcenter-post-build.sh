#!/usr/bin/env bash
echo APPCENTER_BUILD_ID=$APPCENTER_BUILD_ID >> .env
APKFile=`find "$APPCENTER_SOURCE_DIRECTORY" -name *.apk | head -1`
if [ -n "$APKFile" ]; then
  echo "We are in adroid ENV"
  export SENTRY_PROPERTIES=./ios/sentry.properties
  ENVIRONMENT=$APPCENTER_BRANCH
  if [ $APPCENTER_BRANCH = "master" ]; then
    ENVIRONMENT="production"  
  fi
  echo "========>$APPCENTER_BRANCH"
  echo "========>$ENVIRONMENT"
  APP_VERSION="1.0"
  brew install react-native-cli
  BUNDLE_ID="org.reactjs.native.example.senntry"
  SENTRY_VERSION="$BUNDLE_ID@${APP_VERSION}+$APPCENTER_BUILD_ID"
  react-native bundle --dev false --platform android --entry-file index.js --bundle-output index.android.bundle --sourcemap-output index.android.bundle.map
  ./node_modules/@sentry/cli/bin/sentry-cli releases files $SENTRY_VERSION upload-sourcemaps --dist $APPCENTER_BUILD_ID --rewrite index.android.bundle index.android.bundle.map
  ./node_modules/@sentry/cli/bin/sentry-cli  releases deploys new -e "$ENVIRONMENT"
else
  echo "We are in adroid ENV"
  export SENTRY_PROPERTIES=./ios/sentry.properties
  ENVIRONMENT=$APPCENTER_BRANCH
  if [ $APPCENTER_BRANCH = "master" ]; then
    ENVIRONMENT="production"  
  fi
  echo "========>$APPCENTER_BRANCH"
  echo "========>$ENVIRONMENT"
  APP_VERSION="1.0"
  brew install react-native-cli
  BUNDLE_ID="org.reactjs.native.example.senntry"
  SENTRY_VERSION="$BUNDLE_ID@${APP_VERSION}+$APPCENTER_BUILD_ID"
  react-native bundle --dev false --platform android --entry-file index.js --bundle-output index.android.bundle --sourcemap-output index.android.bundle.map
  ./node_modules/@sentry/cli/bin/sentry-cli releases files $SENTRY_VERSION upload-sourcemaps --dist $APPCENTER_BUILD_ID --rewrite index.android.bundle index.android.bundle.map
  ./node_modules/@sentry/cli/bin/sentry-cli  releases deploys "$SENTRY_VERSION" new -e "$ENVIRONMENT"
fi
