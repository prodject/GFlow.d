package com.prodject.gflow.receivers;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.prodject.gflow.services.VoiceForegroundService;

/**
 * VoiceTriggerReceiver: Intercepts custom intent triggers to activate offline Vosk speech recognition.
 */
public class VoiceTriggerReceiver extends BroadcastReceiver {

    private static final String TAG = "VoiceTriggerReceiver";
    public static final String ACTION_VOICE_TRIGGER = "com.prodject.gflow.VOICE";

    @Override
    public void onReceive(Context context, Intent intent) {
        String action = intent.getAction();
        Log.i(TAG, "Voice Trigger Intent received: " + action);

        if (ACTION_VOICE_TRIGGER.equals(action)) {
            Intent serviceIntent = new Intent(context, VoiceForegroundService.class);
            serviceIntent.setAction(VoiceForegroundService.ACTION_START_LISTENING);
            context.startService(serviceIntent);
        }
    }
}
