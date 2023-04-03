package com.example.method_channel_app

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.EventChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES

import android.os.Handler
import android.os.Looper
import java.text.SimpleDateFormat
import java.util.*
import android.widget.Toast



class MainActivity : FlutterActivity() {

    private val CHANNEL_BATTERY = "unique.identifier.method/battery"
    private val CHANNEL_HELLO = "unique.identifier.method/hello"
    private val CHANNEL_STREAM = "unique.identifier.method/stream"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_BATTERY
        ).setMethodCallHandler { call, result ->

            // This method is invoked on the main thread.
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                    Toast.makeText(this, "You got the battery level from Native Android!", Toast.LENGTH_SHORT).show()
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }


        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL_HELLO
        ).setMethodCallHandler { call, result ->

            // This method is invoked on the main thread.
            if (call.method == "getHelloWorld") {
                val user: String? = call.argument("user");
                if (user == null) {
                    result.success("Hello World")
                    Toast.makeText(this, "You got the Hello World from Native Android!", Toast.LENGTH_SHORT).show()
                } else {
                    result.success("Hello World, ${user}");
                     Toast.makeText(this, "You got the Hello World ${user} from Native Android!", Toast.LENGTH_SHORT).show()
                }
            } else {
                result.notImplemented()
            }
        }

        EventChannel(
                flutterEngine.dartExecutor.binaryMessenger,
                CHANNEL_STREAM
            ).setStreamHandler(
                object : EventChannel.StreamHandler {
                    override fun onListen(args: Any?, events: EventChannel.EventSink) {
                        var handler = Handler(Looper.getMainLooper())

                        handler.postDelayed(object : Runnable {
                            override fun run() {
                                val sdf = SimpleDateFormat("dd/MM/yyyy hh:mm:ss")
                                val currentDate = sdf.format(Date())
                                events.success(currentDate)
                                handler.postDelayed(this, 1000)
                            }
                        }, 0)
                    }

                    override fun onCancel(arguments: Any?) {
                        println("cancelling listener")
                    }
                }
            )

    }


    private fun getBatteryLevel(): Int {
        val batteryLevel: Int

        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null,
                IntentFilter(Intent.ACTION_BATTERY_CHANGED)
            )
            batteryLevel =
                intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(
                    BatteryManager.EXTRA_SCALE,
                    -1
                )
        }

        return batteryLevel
    }
}
  