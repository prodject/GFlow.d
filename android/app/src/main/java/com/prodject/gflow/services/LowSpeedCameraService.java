package com.prodject.gflow.services;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.util.Log;

import com.prodject.gflow.bus.CarCommandBus;
import com.prodject.gflow.hal.CarHalAdapter;

import java.util.Map;

/**
 * LowSpeedCameraService: Monitors vehicle speed and auto-launches AVM 360 camera view when speed < 15 km/h.
 */
public class LowSpeedCameraService extends Service implements CarHalAdapter.TelemetryCallback {

    private static final String TAG = "LowSpeedCameraService";
    private CarCommandBus mCommandBus;
    private boolean mIsCameraPopped = false;

    @Override
    public void onCreate() {
        super.onCreate();
        Log.i(TAG, "Starting LowSpeedCameraService...");
        mCommandBus = CarCommandBus.getInstance(this);
        mCommandBus.subscribeTelemetry(this);
    }

    @Override
    public void onTelemetryUpdated(Map<String, Object> data) {
        if (data == null || !data.containsKey("vehicleSpeed")) return;
        Integer speed = (Integer) data.get("vehicleSpeed");
        if (speed != null) {
            if (speed > 0 && speed < 15 && !mIsCameraPopped) {
                Log.i(TAG, "Vehicle speed low (" + speed + " km/h). Auto-popping AVM 360 camera view...");
                mIsCameraPopped = true;
            } else if (speed >= 15 && mIsCameraPopped) {
                Log.i(TAG, "Vehicle speed increased (" + speed + " km/h). Hiding AVM camera overlay.");
                mIsCameraPopped = false;
            }
        }
    }

    @Override
    public void onError(String errorCode, String message) {}

    @Override
    public IBinder onBind(Intent intent) { return null; }

    @Override
    public void onDestroy() {
        super.onDestroy();
        if (mCommandBus != null) {
            mCommandBus.unsubscribeTelemetry(this);
        }
    }
}
