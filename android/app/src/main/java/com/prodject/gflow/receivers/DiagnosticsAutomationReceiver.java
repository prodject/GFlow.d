package com.prodject.gflow.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.prodject.gflow.diagnostics.DiagnosticsRunner;

/**
 * DiagnosticsAutomationReceiver: Triggers AdaptAPI self-diagnostics via broadcast command.
 */
public class DiagnosticsAutomationReceiver extends BroadcastReceiver {

    private static final String TAG = "DiagnosticsReceiver";
    public static final String ACTION_RUN_DIAGNOSTICS = "com.prodject.gflow.ACTION_DIAGNOSTICS";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (ACTION_RUN_DIAGNOSTICS.equals(intent.getAction())) {
            Log.i(TAG, "Triggering automated AdaptAPI diagnostics scan...");
            DiagnosticsRunner runner = new DiagnosticsRunner(context);
            runner.runFullDiagnostics();
        }
    }
}
