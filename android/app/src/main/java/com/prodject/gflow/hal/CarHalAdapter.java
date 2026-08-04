package com.prodject.gflow.hal;

import java.util.Map;

/**
 * Abstract Vehicle HAL Adapter interface for GFlow / GControl.
 * Provides low-level control over Climate, Body, ADAS, and telemetry signals.
 */
public interface CarHalAdapter {

    interface TelemetryCallback {
        void onTelemetryUpdated(Map<String, Object> data);
        void onError(String errorCode, String message);
    }

    void initialize(TelemetryCallback callback);
    void release();

    // Climate Control Methods
    boolean setClimatePower(boolean powerOn);
    boolean setTargetTemperature(float driverTemp, float passengerTemp);
    boolean setFanSpeed(int level); // 1-9
    boolean setAirDirection(String direction); // face, feet, face_feet, defrost
    boolean setSeatHeating(int seatPosition, int level); // 0=off, 1-3
    boolean setSeatVentilation(int seatPosition, int level); // 0=off, 1-3
    boolean setSeatMassage(int seatPosition, int mode); // 0=off, 1-3
    boolean setRecirculation(boolean active);
    boolean setAcMax(boolean active);

    // Vehicle Body Control Methods
    boolean setDoorLock(boolean locked);
    boolean setWindowPosition(int windowId, int percentage); // 0=closed, 100=open
    boolean setSunroofPosition(int percentage);
    boolean setTrunkState(boolean open);
    boolean setMirrorFold(boolean folded);
    boolean setExternalLighting(String mode); // auto, off, low_beam, high_beam

    // Telemetry Getter
    Map<String, Object> getCurrentState();
}
