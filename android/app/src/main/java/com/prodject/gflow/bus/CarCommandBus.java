package com.prodject.gflow.bus;

import android.content.Context;
import android.util.Log;

import com.prodject.gflow.hal.CarHalAdapter;
import com.prodject.gflow.hal.EcarxVehicleAdapter;

import java.util.Map;
import java.util.concurrent.CopyOnWriteArrayList;

/**
 * CarCommandBus: Central event and command routing bus for GFlow.
 */
public class CarCommandBus implements CarHalAdapter.TelemetryCallback {

    private static final String TAG = "CarCommandBus";
    private static CarCommandBus sInstance;

    private CarHalAdapter mActiveHalAdapter;
    private final CopyOnWriteArrayList<CarHalAdapter.TelemetryCallback> mSubscribers = new CopyOnWriteArrayList<>();

    private CarCommandBus(Context context) {
        mActiveHalAdapter = new EcarxVehicleAdapter(context.getApplicationContext());
        mActiveHalAdapter.initialize(this);
    }

    public static synchronized CarCommandBus getInstance(Context context) {
        if (sInstance == null) {
            sInstance = new CarCommandBus(context);
        }
        return sInstance;
    }

    public void subscribeTelemetry(CarHalAdapter.TelemetryCallback callback) {
        if (!mSubscribers.contains(callback)) {
            mSubscribers.add(callback);
        }
    }

    public void unsubscribeTelemetry(CarHalAdapter.TelemetryCallback callback) {
        mSubscribers.remove(callback);
    }

    public Map<String, Object> getCurrentState() {
        return mActiveHalAdapter != null ? mActiveHalAdapter.getCurrentState() : null;
    }

    public boolean executeClimateCommand(String action, Map<String, Object> args) {
        if (mActiveHalAdapter == null) return false;
        Log.i(TAG, "Executing Climate Command: " + action + " with args: " + args);

        if (args == null) return false;

        switch (action) {
            case "setPower":
                Boolean power = (Boolean) args.get("power");
                return mActiveHalAdapter.setClimatePower(power != null && power);
            case "setTemperature":
                Double dTemp = (Double) args.get("driverTemp");
                Double pTemp = (Double) args.get("passengerTemp");
                return mActiveHalAdapter.setTargetTemperature(
                        dTemp != null ? dTemp.floatValue() : 22.0f,
                        pTemp != null ? pTemp.floatValue() : 22.0f
                );
            case "setFanSpeed":
                Integer speed = (Integer) args.get("speed");
                return mActiveHalAdapter.setFanSpeed(speed != null ? speed : 1);
            case "setAirDirection":
                String dir = (String) args.get("direction");
                return mActiveHalAdapter.setAirDirection(dir != null ? dir : "face");
            case "setSeatHeating":
                Integer seatH = (Integer) args.get("seat");
                Integer levelH = (Integer) args.get("level");
                return mActiveHalAdapter.setSeatHeating(seatH != null ? seatH : 0, levelH != null ? levelH : 0);
            case "setSeatVentilation":
                Integer seatV = (Integer) args.get("seat");
                Integer levelV = (Integer) args.get("level");
                return mActiveHalAdapter.setSeatVentilation(seatV != null ? seatV : 0, levelV != null ? levelV : 0);
            default:
                Log.w(TAG, "Unknown climate action: " + action);
                return false;
        }
    }

    public boolean executeVehicleCommand(String action, Map<String, Object> args) {
        if (mActiveHalAdapter == null) return false;
        Log.i(TAG, "Executing Vehicle Command: " + action + " with args: " + args);

        if (args == null) return false;

        switch (action) {
            case "setDoorLock":
                Boolean lock = (Boolean) args.get("locked");
                return mActiveHalAdapter.setDoorLock(lock != null && lock);
            case "setWindow":
                Integer windowId = (Integer) args.get("windowId");
                Integer pos = (Integer) args.get("position");
                return mActiveHalAdapter.setWindowPosition(windowId != null ? windowId : 0, pos != null ? pos : 0);
            case "setSunroof":
                Integer sunPos = (Integer) args.get("position");
                return mActiveHalAdapter.setSunroofPosition(sunPos != null ? sunPos : 0);
            case "setTrunk":
                Boolean open = (Boolean) args.get("open");
                return mActiveHalAdapter.setTrunkState(open != null && open);
            case "setLighting":
                String mode = (String) args.get("mode");
                return mActiveHalAdapter.setExternalLighting(mode != null ? mode : "auto");
            default:
                Log.w(TAG, "Unknown vehicle action: " + action);
                return false;
        }
    }

    @Override
    public void onTelemetryUpdated(Map<String, Object> data) {
        for (CarHalAdapter.TelemetryCallback subscriber : mSubscribers) {
            subscriber.onTelemetryUpdated(data);
        }
    }

    @Override
    public void onError(String errorCode, String message) {
        for (CarHalAdapter.TelemetryCallback subscriber : mSubscribers) {
            subscriber.onError(errorCode, message);
        }
    }
}
