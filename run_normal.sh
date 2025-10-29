#!/bin/sh

APP_DIR=$(pwd)/composeApp/build/compose/binaries/main/app/AppCdsDemo.app
cd "$APP_DIR" || exit
./Contents/MacOS/AppCdsDemo $(($(date +%s) * 1000)) false