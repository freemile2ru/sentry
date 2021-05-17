if [ "$AGENT_JOBSTATUS" == "Succeeded" ]; then
    export SENTRY_PROPERTIES=./ios/sentry.properties
    
    ./node_modules/@sentry/cli/bin/sentry-cli releases files "0.0.1" upload-sourcemaps --dist "0.0.1" --rewrite ./main.jsbundle ./main.jsbundle.map
fi