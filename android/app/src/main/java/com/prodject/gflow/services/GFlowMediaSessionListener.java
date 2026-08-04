package com.prodject.gflow.services;

import android.service.notification.NotificationListenerService;
import android.service.notification.StatusBarNotification;
import android.util.Log;

/**
 * GFlowMediaSessionListener: Intercepts active media notifications (Yandex Music, Spotify, Poweramp)
 * to stream track metadata to GFlow HUD and Dashboard.
 */
public class GFlowMediaSessionListener extends NotificationListenerService {

    private static final String TAG = "GFlowMediaListener";

    @Override
    public void onNotificationPosted(StatusBarNotification sbn) {
        if (sbn == null) return;
        String packageName = sbn.getPackageName();
        if (packageName.contains("music") || packageName.contains("media") || packageName.contains("spotify") || packageName.contains("yandex")) {
            Log.d(TAG, "Media Notification Intercepted from package: " + packageName);
        }
    }

    @Override
    public void onNotificationRemoved(StatusBarNotification sbn) {}
}
