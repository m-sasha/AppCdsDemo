#!/bin/sh
set -v

# Set up to use JBR
JAVA_DIR=~/Library/Java/JavaVirtualMachines/jbr-21.0.7  # Must be 21 or newer
export JAVA_HOME=$JAVA_DIR/Contents/Home/
export PATH=$JAVA_HOME/bin/:"$PATH"
java -version

# Clean
./gradlew --no-daemon clean

# Build the distributable
./gradlew --no-daemon :composeApp:createDistributable

APP_DIR=$(pwd)/composeApp/build/compose/binaries/main/app/AppCdsDemo.app
cd "$APP_DIR"/Contents || exit

# Re-create the bundled JRE with --generate-cds-archive
RUNTIME_DIR=runtime/Contents/Home
rm -rf $RUNTIME_DIR
jlink --generate-cds-archive --output $RUNTIME_DIR --add-modules java.base,java.desktop,java.logging,jdk.crypto.ec

# Run the app to create the jsa archive
cd "$APP_DIR" || exit
export JAVA_TOOL_OPTIONS="-XX:ArchiveClassesAtExit=Contents/app/app.jsa -Xlog:cds"
./Contents/MacOS/AppCdsDemo false true
