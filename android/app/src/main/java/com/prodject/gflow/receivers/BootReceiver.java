package com.prodject.gflow.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.prodject.gflow.services.VoiceForegroundService;
import com.prodject.gflow.services.DvrService;

/**
 * BootReceiver: Handles BOOT_COMPLETED, QUICKBOOT_POWERON, and SHUTDOWN events.
 * Automatically launches background services upon Car Head Unit power-on.
 */
public class BootReceiver extends BroadcastReceiver {

    private static final String TAG = "GFlowBootReceiver";

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        Log.i(TAG, "Received Broadcast Intent: " + action);

        if (Intent.ACTION_BOOT_COMPLETED.equals(action) ||
            "android.intent.action.QUICKBOOT_POWERON".equals(action) ||
            "com.htc.intent.action.QUICKBOOT_POWERON".equals(action)) {

            Log.i(TAG, "Car Head Unit boot completed. Starting GFlow background services...");

            // Start Voice Foreground Service
            Intent voiceIntent = new Intent(context, VoiceForegroundService.class);
            context.startForegroundService(voiceIntent);

            // Start DVR Service
            Intent dvrIntent = new Intent(context, DvrService.class);
            context.startForegroundService(dvrIntent);
        } else if (Intent.ACTION_SHUTDOWN.equals(action)) {
            Log.i(TAG, "Car Head Unit shutting down. Saving GFlow system states...");
        }
    }
}
