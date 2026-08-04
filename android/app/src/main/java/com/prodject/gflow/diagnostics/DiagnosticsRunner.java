package com.prodject.gflow.diagnostics;

import android.content.Context;
import android.util.Log;

import java.io.File;
import java.io.FileOutputStream;

/**
 * DiagnosticsRunner: Scans ECARX AdaptAPI availability and generates gflow-diagnostics.txt report.
 */
public class DiagnosticsRunner {

    private static final String TAG = "DiagnosticsRunner";
    private final Context mContext;

    public DiagnosticsRunner(Context context) {
        this.mContext = context;
    }

    public void runFullDiagnostics() {
        Log.i(TAG, "Starting full GFlow AdaptAPI diagnostics scan...");

        StringBuilder report = new StringBuilder();
        report.append("=== GFLOW AUTOMOTIVE DIAGNOSTICS REPORT ===\n");
        report.append("Timestamp: ").append(System.currentTimeMillis()).append("\n");
        report.append("OS Version: ").append(android.os.Build.VERSION.RELEASE).append(" (API ").append(android.os.Build.VERSION.SDK_INT).append(")\n");
        report.append("Device Hardware: ").append(android.os.Build.HARDWARE).append("\n");
        report.append("Model: ").append(android.os.Build.MODEL).append("\n\n");

        // Scan AdaptAPI Classes via reflection
        String[] targetClasses = {
            "ecarx.os.car.ECarManager",
            "ecarx.os.car.CarSignalManager",
            "ecarx.os.car.AudioExtService",
            "ecarx.os.car.AvmManager",
            "ecarx.os.car.DvrManager"
        };

        report.append("--- AdaptAPI Vendor Class Scan ---\n");
        for (String className : targetClasses) {
            try {
                Class.forName(className);
                report.append("[AVAILABLE] ").append(className).append("\n");
            } catch (ClassNotFoundException e) {
                report.append("[MISSING]   ").append(className).append("\n");
            }
        }

        // Save report to gflow-diagnostics.txt
        try {
            File diagFile = new File(mContext.getExternalFilesDir(null), "gflow-diagnostics.txt");
            FileOutputStream fos = new FileOutputStream(diagFile);
            fos.write(report.toString().getBytes());
            fos.close();
            Log.i(TAG, "Diagnostics report exported successfully to: " + diagFile.getAbsolutePath());
        } catch (Exception e) {
            Log.e(TAG, "Failed to save diagnostics report", e);
        }
    }
}
