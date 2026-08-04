package com.prodject.gflow.engine;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

/**
 * UserProfileEngine: Manages driver and passenger profiles, saving and restoring
 * seat positions, mirror angles, climate preferences, and ADAS settings.
 */
public class UserProfileEngine {

    private static final String TAG = "UserProfileEngine";
    private static final String PREF_NAME = "gflow_user_profiles";
    private final SharedPreferences mPrefs;

    public UserProfileEngine(Context context) {
        this.mPrefs = context.getSharedPreferences(PREF_NAME, Context.MODE_PRIVATE);
    }

    public void saveProfile(String profileName, String jsonConfig) {
        Log.i(TAG, "Saving User Profile: " + profileName);
        mPrefs.edit().putString("profile_" + profileName, jsonConfig).apply();
    }

    public String loadProfile(String profileName) {
        Log.i(TAG, "Loading User Profile: " + profileName);
        return mPrefs.getString("profile_" + profileName, null);
    }

    public void setActiveProfile(String profileName) {
        Log.i(TAG, "Switched active driver profile to: " + profileName);
        mPrefs.edit().putString("active_profile", profileName).apply();
    }

    public String getActiveProfile() {
        return mPrefs.getString("active_profile", "Driver 1");
    }
}
