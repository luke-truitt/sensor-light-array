package com.bluetooth.ece350_project.data;

public interface Constants {
        public String TAG = "DAML";
        public String FIND = "Scan For Sensors";
        public String STOP_SCANNING = "Stop Scanning";
        public String SCANNING = "Scanning";
        public String READING = "Taking Reading";

        public String READINGS_DB = "readings";
        public String SENSOR_ID_DB = "SensorId";
        public String SENSOR_DB = "sensors";
        public String SENSOR_NAME_DB = "Name";
        public String SENSOR_MAC_DB = "MAC";

        public String READING_MAP_KEY = "Reading";
        public String DATE_MAP_KEY = "Date";

        public String SENSOR_NAME = "name";
        public String SENSOR_MAC = "mac";
        public String SENSOR_DATA = "data";

        public String READINGS = "readings";
        public String TIME = "time";

        public byte [] ALERT_LEVEL_LOW = { (byte) 0x00};
        public byte [] ALERT_LEVEL_MID = { (byte) 0x01};
        public byte [] ALERT_LEVEL_HIGH = { (byte) 0x02};

        public String OK = "OK";
        public String NO = "No";
        public String YES = "Yes";
        public String CANCEL = "Cancel";
        public String SEND = "Send";
        public String SET = "Set";
        public String SENSOR_BASE = "";

        // Message types sent from the BluetoothChatService Handler
        public  int MESSAGE_STATE_CHANGE = 1;
        public  int MESSAGE_READ = 2;
        public  int MESSAGE_WRITE = 3;
        public  int MESSAGE_DEVICE_NAME = 4;
        public  int MESSAGE_TOAST = 5;

        // Key names received from the BluetoothChatService Handler
        public String DEVICE_NAME = "device_name";
        public String TOAST = "toast";

}
