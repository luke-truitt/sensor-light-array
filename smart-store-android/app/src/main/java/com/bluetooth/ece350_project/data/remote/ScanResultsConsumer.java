package com.bluetooth.ece350_project.data.remote;

import android.bluetooth.BluetoothDevice;

public interface ScanResultsConsumer {
    public void candidateBleDevice(BluetoothDevice device, byte[] scan_record, int rssi);
    public void scanningStarted();
    public void scanningStopped();
}
