#!/bin/sh

shell_time=$(./getms.exe)
cd "AppCdsDemo" || exit
./AppCdsDemo.exe "$shell_time" false