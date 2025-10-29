#!/bin/sh

APP_DIR=$(pwd)/composeApp/build/compose/binaries/main/app/AppCdsDemo
cd "$APP_DIR" || exit
./AppCdsDemo.exe $(($(date +%s) * 1000)) false