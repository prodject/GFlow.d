package com.prodject.gflow.hal;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;

/**
 * Mock HAL Adapter for development & testing on Android Emulators or non-ECARX devices.
 * Emulates real-time CAN bus telemetry updates.
 */
public class MockCarHalAdapter implements CarHalAdapter {

    private static final String TAG = "MockCarHalAdapter";
    private TelemetryCallback mCallback;
    private final Handler mHandler = new Handler(Looper.getMainLooper());
    private boolean mIsRunning = false;

    // Simulated Vehicle State
    private boolean mClimatePower = true;
    private float mDriverTemp = 22.0f;
    private float mPassengerTemp = 22.5f;
    private int mFanSpeed = 3;
    private String mAirDirection = "face_feet";
    private boolean mDoorLocked = true;
    private int mVehicleSpeed = 45; // km/h
    private int mOutdoorTemp = 18; // Celsius
    private int mBatteryLevel = 84; // %

    private final Runnable mSimulationRunnable = new Runnable() {
        @Override
        public void run() {
            if (!mIsRunning) return;

            // Fluctuate outdoor temp slightly for real-time CAN effect
            mOutdoorTemp = 18 + (int) (Math.random() * 2 - 1);
            Map<String, Object> state = getCurrentState();

            if (mCallback != null) {
                mCallback.onTelemetryUpdated(state);
            }

            mHandler.postDelayed(this, 1500); // Telemetry tick every 1.5s
        }
    };

    @Override
    public void initialize(TelemetryCallback callback) {
        Log.i(TAG, "Initializing Mock Car HAL Adapter...");
        this.mCallback = callback;
        this.mIsRunning = true;
        mHandler.post(mSimulationRunnable);
    }

    @Override
    public void release() {
        Log.i(TAG, "Releasing Mock Car HAL Adapter");
        this.mIsRunning = false;
        mHandler.removeCallbacks(mSimulationRunnable);
    }

    @Override
    public boolean setClimatePower(boolean powerOn) {
        this.mClimatePower = powerOn;
        Log.d(TAG, "setClimatePower: " + powerOn);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setTargetTemperature(float driverTemp, float passengerTemp) {
        this.mDriverTemp = driverTemp;
        this.mPassengerTemp = passengerTemp;
        Log.d(TAG, "setTargetTemperature: driver=" + driverTemp + ", passenger=" + passengerTemp);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setFanSpeed(int level) {
        this.mFanSpeed = Math.max(1, Math.min(9, level));
        Log.d(TAG, "setFanSpeed: " + mFanSpeed);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setAirDirection(String direction) {
        this.mAirDirection = direction;
        Log.d(TAG, "setAirDirection: " + direction);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setSeatHeating(int seatPosition, int level) {
        Log.d(TAG, "setSeatHeating: seat=" + seatPosition + ", level=" + level);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setSeatVentilation(int seatPosition, int level) {
        Log.d(TAG, "setSeatVentilation: seat=" + seatPosition + ", level=" + level);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setSeatMassage(int seatPosition, int mode) {
        Log.d(TAG, "setSeatMassage: seat=" + seatPosition + ", mode=" + mode);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setRecirculation(boolean active) {
        Log.d(TAG, "setRecirculation: " + active);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setAcMax(boolean active) {
        Log.d(TAG, "setAcMax: " + active);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setDoorLock(boolean locked) {
        this.mDoorLocked = locked;
        Log.d(TAG, "setDoorLock: " + locked);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setWindowPosition(int windowId, int percentage) {
        Log.d(TAG, "setWindowPosition: window=" + windowId + ", pos=" + percentage + "%");
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setSunroofPosition(int percentage) {
        Log.d(TAG, "setSunroofPosition: pos=" + percentage + "%");
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setTrunkState(boolean open) {
        Log.d(TAG, "setTrunkState: open=" + open);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setMirrorFold(boolean folded) {
        Log.d(TAG, "setMirrorFold: folded=" + folded);
        notifyStateChange();
        return true;
    }

    @Override
    public boolean setExternalLighting(String mode) {
        Log.d(TAG, "setExternalLighting: mode=" + mode);
        notifyStateChange();
        return true;
    }

    @Override
    public Map<String, Object> getCurrentState() {
        Map<String, Object> map = new HashMap<>();
        map.put("climatePower", mClimatePower);
        map.put("driverTemp", mDriverTemp);
        map.put("passengerTemp", mPassengerTemp);
        map.put("fanSpeed", mFanSpeed);
        map.put("airDirection", mAirDirection);
        map.put("doorLocked", mDoorLocked);
        map.put("vehicleSpeed", mVehicleSpeed);
        map.put("outdoorTemp", mOutdoorTemp);
        map.put("batteryLevel", mBatteryLevel);
        map.put("isMock", true);
        return map;
    }

    private void notifyStateChange() {
        if (mCallback != null) {
            mCallback.onTelemetryUpdated(getCurrentState());
        }
    }
}
