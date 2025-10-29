#!/bin/sh

shell_time=$(./getms)
cd "AppCdsDemo.app" || exit
export JAVA_TOOL_OPTIONS="-XX:SharedArchiveFile=Contents/app/app.jsa -Xshare:on"
./Contents/MacOS/AppCdsDemo "$shell_time" false