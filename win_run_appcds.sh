#!/bin/sh

shell_time=$(./getms.exe)
cd "AppCdsDemo" || exit
export JAVA_TOOL_OPTIONS="-XX:SharedArchiveFile=app/app.jsa -Xshare:on"
./AppCdsDemo.exe "$shell_time" false