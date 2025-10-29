This is a sample application to reproduce [AppCDS writes local paths into .jsa archive](https://youtrack.jetbrains.com/issue/JBR-9098/AppCDS-writes-local-paths-into-.jsa-archive)
(and is slow when the jar files don't exist).

The project is a small Compose application that shows a single window and shuts down after 5 seconds.
It also prints to stdout the time it took to start.

The project includes two sets of three scripts (one set for Windows and one set for macOS):
- `win/macos_prepare.sh`:
  1. Builds the app
  2. Runs the app with `-XX:ArchiveClassesAtExit` to create the jsa archive
  3. Creates a copy of the app in the project's root directory.
- `win/macos_run_normal.sh`: Runs the app's copy without AppCDS
- `win/macos_run_appcds.sh`: Runs the app's copy with AppCDS

After you've run the `prepare` script, you can run the `run_normal` and `run_appcds` scripts and see that the AppCDS 
version is significantly faster.

### To reproduce the problem
If you delete the original jar files whose paths were written into the jsa archive
(under `composeApp/build/compose/binaries/main/app/`):
1. When running the app copy, you will get many lines like this printed:
    ```
    [0.107s][warning][cds] Required classpath entry does not exist: C:\Users\msash\Projects\AppCdsDemo\composeApp\build\compose\binaries\main\app\AppCdsDemo\app\runtime-desktop-1.9.0-c25a54d26562099d86e41defd73c526.jar
    ```
2. **Only on Windows** the app will start up much slower, almost as slow as without AppCDS at all.