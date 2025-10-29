#!/bin/sh

APP_DIR=$(pwd)/composeApp/build/compose/binaries/main/app/AppCdsDemo.app
shell_time=$(./getms)
cd "$APP_DIR" || exit
./Contents/MacOS/AppCdsDemo "$shell_time" false