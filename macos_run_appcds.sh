#!/bin/sh

APP_DIR=$(pwd)/composeApp/build/compose/binaries/main/app/AppCdsDemo.app
shell_time=$(./getms)
cd "$APP_DIR" || exit
export JAVA_TOOL_OPTIONS="-XX:SharedArchiveFile=Contents/app/app.jsa -Xshare:on"
./Contents/MacOS/AppCdsDemo "$shell_time" false