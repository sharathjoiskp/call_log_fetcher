package com.jois.call_log_fetcher

import android.Manifest
import android.content.pm.PackageManager
import android.provider.CallLog
import androidx.core.content.ContextCompat
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class CallLogFetcherPlugin : FlutterPlugin, MethodCallHandler {
    private lateinit var channel: MethodChannel
    private var context: android.content.Context? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "com.jois.app/platfroms")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        context = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getCallLogs" -> {
                val fromTimestamp = call.argument<Long>("from") ?: 0
                val toTimestamp = call.argument<Long>("to") ?: System.currentTimeMillis()
                val ctx = context

                if (ctx != null && ContextCompat.checkSelfPermission(ctx, Manifest.permission.READ_CALL_LOG)
                    == PackageManager.PERMISSION_GRANTED
                ) {
                    result.success(getCallLogsFormatted(ctx, fromTimestamp, toTimestamp))
                } else {
                    result.error("PERMISSION_DENIED", "Call log permission not granted", null)
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun getCallLogsFormatted(ctx: android.content.Context, from: Long, to: Long): List<Map<String, Any>> {
        val callLogs = mutableListOf<Map<String, Any>>()
        val cursor = ctx.contentResolver.query(
            CallLog.Calls.CONTENT_URI,
            null,
            "${CallLog.Calls.DATE} BETWEEN ? AND ?",
            arrayOf(from.toString(), to.toString()),
            CallLog.Calls.DATE + " DESC"
        )

        cursor?.use {
            val numberColumn = it.getColumnIndex(CallLog.Calls.NUMBER)
            val typeColumn = it.getColumnIndex(CallLog.Calls.TYPE)
            val dateColumn = it.getColumnIndex(CallLog.Calls.DATE)
            val durationColumn = it.getColumnIndex(CallLog.Calls.DURATION)

            while (it.moveToNext()) {
                val number = it.getString(numberColumn)
                val callType = when (it.getInt(typeColumn)) {
                    CallLog.Calls.OUTGOING_TYPE -> "Outgoing"
                    CallLog.Calls.INCOMING_TYPE -> "Incoming"
                    CallLog.Calls.MISSED_TYPE -> "Missed"
                    else -> "Unknown"
                }
                val calledDate = it.getLong(dateColumn)
                val duration = it.getInt(durationColumn)

                callLogs.add(
                    mapOf(
                        "number" to (number ?: ""),
                        "callType" to callType,
                        "calledDate" to calledDate,
                        "duration" to duration
                    )
                )
            }
        }
        return callLogs
    }
}