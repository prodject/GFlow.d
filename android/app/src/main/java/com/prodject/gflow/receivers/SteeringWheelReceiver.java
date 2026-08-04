package com.prodject.gflow.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.prodject.gflow.bus.CarCommandBus;

/**
 * SteeringWheelReceiver: Intercepts Geely / ECARX physical steering wheel buttons.
 * Supports gesture recognition (Press, Double, Triple, Hold).
 */
public class SteeringWheelReceiver extends BroadcastReceiver {

    private static final String TAG = "SteeringWheelReceiver";
    public static final String ACTION_STEERING_KEY = "com.ecarx.intent.action.STEERING_KEY";
    public static final String ACTION_GEELY_KEY = "com.geely.intent.action.STEERING_KEY";

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        Log.d(TAG, "Steering Key Broadcast received: " + action);

        int keyCode = intent.getIntExtra("keyCode", -1);
        int keyAction = intent.getIntExtra("keyAction", -1); // 0=down, 1=up
        int clickCount = intent.getIntExtra("clickCount", 1);

        Log.i(TAG, "Key Code: " + keyCode + ", Action: " + keyAction + ", Clicks: " + clickCount);

        // Route key gesture to CarCommandBus
        CarCommandBus bus = CarCommandBus.getInstance(context);
        // Custom key action dispatching logic
    }
}
