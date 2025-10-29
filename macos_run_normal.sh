#!/bin/sh

shell_time=$(./getms)
cd "AppCdsDemo.app" || exit
./Contents/MacOS/AppCdsDemo "$shell_time" false