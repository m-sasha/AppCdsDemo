#!/bin/sh
set -v

# Remember script directory
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Build a utility to get current time very quickly
gcc ./getms.c -o ./getms

# Set up to use JBR
JAVA_DIR="C:\Users\msash\.jdks\jbr-21.0.7"  # Must be 21 or newer
export JAVA_HOME=$JAVA_DIR
export PATH=$JAVA_HOME/bin/:"$PATH"
java -version

# Clean
./gradlew.bat --no-daemon clean

# Build the distributable
./gradlew.bat --no-daemon :composeApp:createDistributable

APP_DIR=$(pwd)/composeApp/build/compose/binaries/main/app/AppCdsDemo
cd "$APP_DIR"|| exit

# Re-create the bundled JRE with --generate-cds-archive
RUNTIME_DIR=runtime
rm -rf $RUNTIME_DIR
jlink --generate-cds-archive --output $RUNTIME_DIR --add-modules java.base,java.desktop,java.logging,jdk.crypto.ec

# Run the app to create the jsa archive
cd "$APP_DIR" || exit
export JAVA_TOOL_OPTIONS="-XX:ArchiveClassesAtExit=app/app.jsa -Xlog:cds"
./AppCdsDemo.exe false true

# Make a copy of the app in the root directory
cp -r "$APP_DIR" "$SCRIPT_DIR/"