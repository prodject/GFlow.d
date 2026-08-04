package com.prodject.gflow.services;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

/**
 * CameraForegroundService: Holds camera capture hardware lock across activities.
 */
public class CameraForegroundService extends Service {

    private static final String TAG = "CameraForegroundService";

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        Log.i(TAG, "Camera capture lock active");
        return START_STICKY;
    }

    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}
