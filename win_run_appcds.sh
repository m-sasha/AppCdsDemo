#!/bin/sh

APP_DIR=$(pwd)/composeApp/build/compose/binaries/main/app/AppCdsDemo
cd "$APP_DIR" || exit
export JAVA_TOOL_OPTIONS="-XX:SharedArchiveFile=app/app.jsa -Xshare:on"
./AppCdsDemo.exe $(($(date +%s) * 1000)) false