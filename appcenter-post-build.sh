if [ "$AGENT_JOBSTATUS" == "Succeeded" ]; then
    export SENTRY_PROPERTIES=./ios/sentry.properties

    cp "$APPCENTER_SOURCE_DIRECTORY/index.ios.map" "$APPCENTER_SOURCE_DIRECTORY/dist/index.ios.map"
    cp "$APPCENTER_SOURCE_DIRECTORY/dummy-sourcemap-main.jsbundle" "$APPCENTER_SOURCE_DIRECTORY/dist/main.jsbundle"

    ./node_modules/@sentry/cli/bin/sentry-cli --log-level=DEBUG releases \
    files $SENTRY_VERSION \
    upload-sourcemaps \
    --dist $APPCENTER_BUILD_ID \
    --strip-prefix "$APPCENTER_SOURCE_DIRECTORY/src" \
    --rewrite "$APPCENTER_SOURCE_DIRECTORY/dist"
fi