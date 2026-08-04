package com.prodject.gflow.engine;

import android.content.Context;
import android.util.Log;

import com.prodject.gflow.bus.CarCommandBus;

import java.util.HashMap;
import java.util.Map;

/**
 * SmartClimateController: Intelligently calculates optimal cabin target temperature,
 * fan speed levels, and seat heating/ventilation presets based on external environmental factors.
 */
public class SmartClimateController {

    private static final String TAG = "SmartClimateController";
    private final Context mContext;
    private final CarCommandBus mCommandBus;

    public SmartClimateController(Context context) {
        this.mContext = context;
        this.mCommandBus = CarCommandBus.getInstance(context);
    }

    public void applySmartPreset(String presetMode, int outdoorTemp) {
        Log.i(TAG, "Applying Smart Climate Preset: " + presetMode + " (Outdoor Temp: " + outdoorTemp + "°C)");
        Map<String, Object> args = new HashMap<>();

        switch (presetMode) {
            case "WINTER":
                args.put("driverTemp", 24.5);
                args.put("passengerTemp", 24.5);
                mCommandBus.executeClimateCommand("setTemperature", args);
                mCommandBus.executeClimateCommand("setFanSpeed", Map.of("speed", 5));
                mCommandBus.executeClimateCommand("setSeatHeating", Map.of("seat", 1, "level", 3));
                break;

            case "SUMMER":
                args.put("driverTemp", 19.0);
                args.put("passengerTemp", 19.0);
                mCommandBus.executeClimateCommand("setTemperature", args);
                mCommandBus.executeClimateCommand("setFanSpeed", Map.of("speed", 7));
                mCommandBus.executeClimateCommand("setSeatVentilation", Map.of("seat", 1, "level", 3));
                break;

            case "COMFORT":
                args.put("driverTemp", 22.0);
                args.put("passengerTemp", 22.0);
                mCommandBus.executeClimateCommand("setTemperature", args);
                mCommandBus.executeClimateCommand("setFanSpeed", Map.of("speed", 3));
                break;

            default:
                Log.w(TAG, "Unknown Smart Climate Preset: " + presetMode);
                break;
        }
    }
}
