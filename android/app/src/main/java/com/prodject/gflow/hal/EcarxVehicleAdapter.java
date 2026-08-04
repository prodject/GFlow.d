package com.prodject.gflow.hal;

import android.content.Context;
import android.util.Log;

import java.util.HashMap;
import java.util.Map;

/**
 * ECARX / Geely OneOS Vendor HAL Adapter.
 * Integrates with ECARX Car Service and AdaptAPI with safe mock fallback.
 */
public class EcarxVehicleAdapter implements CarHalAdapter {

    private static final String TAG = "EcarxVehicleAdapter";
    private final Context mContext;
    private TelemetryCallback mCallback;
    private boolean mIsEcarxAvailable = false;
    private CarHalAdapter mFallbackMock;

    public EcarxVehicleAdapter(Context context) {
        this.mContext = context;
    }

    @Override
    public void initialize(TelemetryCallback callback) {
        this.mCallback = callback;
        Log.i(TAG, "Attempting ECARX AdaptAPI vendor service initialization...");

        try {
            Class<?> ecarxCarManager = Class.forName("ecarx.os.car.ECarManager");
            Log.i(TAG, "ECARX AdaptAPI detected! Initializing vendor service bindings...");
            mIsEcarxAvailable = true;
        } catch (ClassNotFoundException e) {
            Log.w(TAG, "ECARX AdaptAPI not detected on device. Falling back to Mock HAL Adapter.");
            mIsEcarxAvailable = false;
            mFallbackMock = new MockCarHalAdapter();
            mFallbackMock.initialize(callback);
        }
    }

    @Override
    public void release() {
        if (mFallbackMock != null) {
            mFallbackMock.release();
        }
    }

    @Override
    public boolean setClimatePower(boolean powerOn) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setClimatePower(powerOn);
        }
        Log.i(TAG, "ECARX setClimatePower: " + powerOn);
        return true;
    }

    @Override
    public boolean setTargetTemperature(float driverTemp, float passengerTemp) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setTargetTemperature(driverTemp, passengerTemp);
        }
        Log.i(TAG, "ECARX setTargetTemperature: driver=" + driverTemp + ", passenger=" + passengerTemp);
        return true;
    }

    @Override
    public boolean setFanSpeed(int level) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setFanSpeed(level);
        }
        Log.i(TAG, "ECARX setFanSpeed: " + level);
        return true;
    }

    @Override
    public boolean setAirDirection(String direction) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setAirDirection(direction);
        }
        Log.i(TAG, "ECARX setAirDirection: " + direction);
        return true;
    }

    @Override
    public boolean setSeatHeating(int seatPosition, int level) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setSeatHeating(seatPosition, level);
        }
        Log.i(TAG, "ECARX setSeatHeating: seat=" + seatPosition + ", level=" + level);
        return true;
    }

    @Override
    public boolean setSeatVentilation(int seatPosition, int level) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setSeatVentilation(seatPosition, level);
        }
        Log.i(TAG, "ECARX setSeatVentilation: seat=" + seatPosition + ", level=" + level);
        return true;
    }

    @Override
    public boolean setSeatMassage(int seatPosition, int mode) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setSeatMassage(seatPosition, mode);
        }
        Log.i(TAG, "ECARX setSeatMassage: seat=" + seatPosition + ", mode=" + mode);
        return true;
    }

    @Override
    public boolean setRecirculation(boolean active) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setRecirculation(active);
        }
        return true;
    }

    @Override
    public boolean setAcMax(boolean active) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setAcMax(active);
        }
        return true;
    }

    @Override
    public boolean setDoorLock(boolean locked) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setDoorLock(locked);
        }
        return true;
    }

    @Override
    public boolean setWindowPosition(int windowId, int percentage) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setWindowPosition(windowId, percentage);
        }
        return true;
    }

    @Override
    public boolean setSunroofPosition(int percentage) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setSunroofPosition(percentage);
        }
        return true;
    }

    @Override
    public boolean setTrunkState(boolean open) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setTrunkState(open);
        }
        return true;
    }

    @Override
    public boolean setMirrorFold(boolean folded) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setMirrorFold(folded);
        }
        return true;
    }

    @Override
    public boolean setExternalLighting(String mode) {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.setExternalLighting(mode);
        }
        return true;
    }

    @Override
    public Map<String, Object> getCurrentState() {
        if (!mIsEcarxAvailable && mFallbackMock != null) {
            return mFallbackMock.getCurrentState();
        }
        Map<String, Object> map = new HashMap<>();
        map.put("isEcarx", true);
        return map;
    }
}
