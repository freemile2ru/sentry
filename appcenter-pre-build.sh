brew install jq
BUNDLE_ID_IOS="org.reactjs.native.example.senntry"
APP_VERSION=$(jq -r .version)
SENTRY_VERSION="$BUNDLE_ID_IOS@${APP_VERSION}+$APPCENTER_BUILD_ID"

echo “APPCENTER_BUILD_ID=$APPCENTER_BUILD_ID” >> .env
echo “SENTRY_VERSION=$SENTRY_VERSION” >> .env

echo "build Id is $APPCENTER_BUILD_ID"