package org.example.project

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material.MaterialTheme
import androidx.compose.material.Text
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.window.Window
import androidx.compose.ui.window.application
import kotlinx.coroutines.delay
import java.awt.event.WindowAdapter
import java.awt.event.WindowEvent
import kotlin.time.Duration.Companion.seconds

fun main(args: Array<String>) {
    val mainTime = System.currentTimeMillis()
    val shellTime = args.getOrNull(0)?.toLongOrNull()
    if (shellTime != null) {
        println("App startup took:")
        println("  From shell execution to main start: ${mainTime - shellTime}ms")
    }

    val isPrepRun = args.getOrNull(1) == "true"

    application {
        var remainingSeconds by remember { mutableIntStateOf(5) }
        Window(onCloseRequest = ::exitApplication) {
            MaterialTheme {
                Box(Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Column {
                        Text("AppCDS Demo")
                        Text("Prep run: $isPrepRun")
                        Text("Shutting down in $remainingSeconds seconds...")
                    }
                }
            }

            LaunchedEffect(Unit) {
                window.addWindowListener(object: WindowAdapter() {
                    override fun windowOpened(e: WindowEvent?) {
                        if (shellTime != null) {
                            val now = System.currentTimeMillis()
                            println("  From main start to window open: ${now - mainTime}ms")
                            println("Total: ${now - shellTime}ms")
                        }
                    }
                })
            }
        }

        LaunchedEffect(Unit) {
            while (remainingSeconds > 0) {
                delay(1.seconds)
                remainingSeconds--
            }
            exitApplication()
        }
    }
}