package com.prodject.gflow.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

/**
 * SplitCommandReceiver: Receives broadcast requests to control multi-window split screen mode on HU.
 */
public class SplitCommandReceiver extends BroadcastReceiver {

    private static final String TAG = "SplitCommandReceiver";
    public static final String ACTION_TOGGLE_SPLIT = "com.prodject.gflow.ACTION_TOGGLE_SPLIT";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (ACTION_TOGGLE_SPLIT.equals(intent.getAction())) {
            String primaryApp = intent.getStringExtra("primaryApp");
            String secondaryApp = intent.getStringExtra("secondaryApp");
            Log.i(TAG, "Requesting Split Screen Mode: " + primaryApp + " | " + secondaryApp);
        }
    }
}
