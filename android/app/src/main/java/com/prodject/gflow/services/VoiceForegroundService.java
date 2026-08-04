package com.prodject.gflow.services;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.Service;
import android.content.Intent;
import android.os.Build;
import android.os.IBinder;
import android.util.Log;

import androidx.core.app.NotificationCompat;

import com.prodject.gflow.voice.VoiceFlowRouter;

/**
 * VoiceForegroundService: Foreground service keeping Vosk speech recognizer active in the background.
 */
public class VoiceForegroundService extends Service {

    private static final String TAG = "VoiceForegroundService";
    private static final String CHANNEL_ID = "GFlowVoiceChannel";
    private static final int NOTIFICATION_ID = 1001;

    public static final String ACTION_START_LISTENING = "com.prodject.gflow.action.START_LISTENING";
    public static final String ACTION_STOP_LISTENING = "com.prodject.gflow.action.STOP_LISTENING";

    private VoiceFlowRouter mVoiceFlowRouter;

    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG, "Creating Voice Foreground Service...");
        mVoiceFlowRouter = new VoiceFlowRouter(this);
        createNotificationChannel();
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Notification notification = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle("GFlow Voice Assistant")
                .setContentText("Offline Vosk Voice Recognizer Active")
                .setSmallIcon(android.R.drawable.ic_btn_speak_now)
                .setPriority(NotificationCompat.PRIORITY_LOW)
                .build();

        startForeground(NOTIFICATION_ID, notification);

        if (intent != null && ACTION_START_LISTENING.equals(intent.getAction())) {
            Log.i(TAG, "Starting audio listening session...");
            // Vosk speech recognizer listening loop triggers VoiceFlowRouter
        }

        return START_STICKY;
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    CHANNEL_ID,
                    "GFlow Voice Service",
                    NotificationManager.IMPORTANCE_LOW
            );
            NotificationManager manager = getSystemService(NotificationManager.class);
            if (manager != null) {
                manager.createNotificationChannel(channel);
            }
        }
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        Log.i(TAG, "Destroying Voice Foreground Service");
    }
}
