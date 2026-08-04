package com.prodject.gflow.channel;

import android.content.Context;
import android.util.Log;

import androidx.annotation.NonNull;

import com.prodject.gflow.bus.CarCommandBus;
import com.prodject.gflow.hal.CarHalAdapter;

import java.util.Map;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

/**
 * PlatformChannelManager: Connects Flutter Engine with Android Native CarCommandBus & HAL.
 */
public class PlatformChannelManager implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler, CarHalAdapter.TelemetryCallback {

    private static final String TAG = "PlatformChannelManager";
    public static final String METHOD_CHANNEL_NAME = "com.prodject.gflow/command";
    public static final String EVENT_CHANNEL_NAME = "com.prodject.gflow/telemetry";

    private final Context mContext;
    private final CarCommandBus mCommandBus;
    private EventChannel.EventSink mEventSink;

    public PlatformChannelManager(@NonNull Context context) {
        this.mContext = context;
        this.mCommandBus = CarCommandBus.getInstance(context);
    }

    public void registerChannels(@NonNull FlutterEngine flutterEngine) {
        Log.i(TAG, "Registering GFlow Platform Channels...");

        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), METHOD_CHANNEL_NAME);
        methodChannel.setMethodCallHandler(this);

        EventChannel eventChannel = new EventChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), EVENT_CHANNEL_NAME);
        eventChannel.setStreamHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Log.d(TAG, "MethodCall received: " + call.method);

        try {
            switch (call.method) {
                case "getInitialState":
                    Map<String, Object> state = mCommandBus.getCurrentState();
                    result.success(state);
                    break;

                case "executeClimateCommand":
                    String climateAction = call.argument("action");
                    Map<String, Object> climateArgs = call.argument("args");
                    boolean climateSuccess = mCommandBus.executeClimateCommand(climateAction, climateArgs);
                    result.success(climateSuccess);
                    break;

                case "executeVehicleCommand":
                    String vehicleAction = call.argument("action");
                    Map<String, Object> vehicleArgs = call.argument("args");
                    boolean vehicleSuccess = mCommandBus.executeVehicleCommand(vehicleAction, vehicleArgs);
                    result.success(vehicleSuccess);
                    break;

                default:
                    result.notImplemented();
                    break;
            }
        } catch (Exception e) {
            Log.e(TAG, "Error handling method call: " + call.method, e);
            result.error("COMMAND_ERROR", e.getMessage(), null);
        }
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        Log.i(TAG, "EventChannel stream listener attached");
        this.mEventSink = events;
        mCommandBus.subscribeTelemetry(this);

        Map<String, Object> initial = mCommandBus.getCurrentState();
        if (initial != null && mEventSink != null) {
            mEventSink.success(initial);
        }
    }

    @Override
    public void onCancel(Object arguments) {
        Log.i(TAG, "EventChannel stream listener cancelled");
        mCommandBus.unsubscribeTelemetry(this);
        this.mEventSink = null;
    }

    @Override
    public void onTelemetryUpdated(Map<String, Object> data) {
        if (mEventSink != null) {
            mEventSink.success(data);
        }
    }

    @Override
    public void onError(String errorCode, String message) {
        if (mEventSink != null) {
            mEventSink.error(errorCode, message, null);
        }
    }
}
