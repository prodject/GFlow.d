package com.prodject.gflow;

import android.os.Bundle;
import android.util.Log;

import androidx.annotation.NonNull;

import com.prodject.gflow.channel.PlatformChannelManager;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

/**
 * MainActivity for GFlow / GControl (Monji).
 */
public class MainActivity extends FlutterActivity {

    private static final String TAG = "GFlowMainActivity";
    private PlatformChannelManager mPlatformChannelManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.i(TAG, "GFlow Automotive MainActivity starting up...");
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        Log.i(TAG, "Configuring Flutter Engine and registering Platform Channels...");
        mPlatformChannelManager = new PlatformChannelManager(this);
        mPlatformChannelManager.registerChannels(flutterEngine);
    }
}
