package com.prodject.gflow.voice;

import android.content.Context;
import android.util.Log;

import com.prodject.gflow.bus.CarCommandBus;

import java.util.HashMap;
import java.util.Map;

/**
 * VoiceFlowRouter: Parses offline Vosk speech recognition text and dispatches automotive commands.
 */
public class VoiceFlowRouter {

    private static final String TAG = "VoiceFlowRouter";
    private final Context mContext;
    private final CarCommandBus mCommandBus;

    public VoiceFlowRouter(Context context) {
        this.mContext = context;
        this.mCommandBus = CarCommandBus.getInstance(context);
    }

    public boolean processHypothesis(String text) {
        if (text == null || text.trim().isEmpty()) return false;
        String query = text.toLowerCase().trim();
        Log.i(TAG, "Processing Voice Hypothesis: " + query);

        Map<String, Object> args = new HashMap<>();

        // Climate Commands
        if (query.contains("включи климат") || query.contains("запусти климат")) {
            args.put("power", true);
            return mCommandBus.executeClimateCommand("setPower", args);
        } else if (query.contains("выключи климат")) {
            args.put("power", false);
            return mCommandBus.executeClimateCommand("setPower", args);
        } else if (query.contains("тепло") || query.contains("согрей")) {
            args.put("driverTemp", 24.0);
            args.put("passengerTemp", 24.0);
            return mCommandBus.executeClimateCommand("setTemperature", args);
        } else if (query.contains("холодно") || query.contains("охлади")) {
            args.put("driverTemp", 19.0);
            args.put("passengerTemp", 19.0);
            return mCommandBus.executeClimateCommand("setTemperature", args);
        }

        // Vehicle Commands
        if (query.contains("закрой двери") || query.contains("заблокируй")) {
            args.put("locked", true);
            return mCommandBus.executeVehicleCommand("setDoorLock", args);
        } else if (query.contains("открой двери") || query.contains("разблокируй")) {
            args.put("locked", false);
            return mCommandBus.executeVehicleCommand("setDoorLock", args);
        }

        Log.w(TAG, "Unrecognized voice command: " + query);
        return false;
    }
}
