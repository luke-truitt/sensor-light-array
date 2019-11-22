package com.bluetooth.ece350_project.data;

public class Constants {
        public static final String TAG = "DAML";
        public static final String FIND = "Scan For Sensors";
        public static final String STOP_SCANNING = "Stop Scanning";
        public static final String SCANNING = "Scanning";
        public static final String READING = "Taking Reading";

        public static final String READINGS_DB = "readings";
        public static final String SENSOR_ID_DB = "SensorId";
        public static final String SENSOR_DB = "sensors";
        public static final String SENSOR_NAME_DB = "Name";
        public static final String SENSOR_MAC_DB = "MAC";

        public static final String READING_MAP_KEY = "Reading";
        public static final String DATE_MAP_KEY = "Date";

        public static final String SENSOR_NAME = "name";
        public static final String SENSOR_MAC = "mac";
        public static final String SENSOR_DATA = "data";

        public static final String READINGS = "readings";
        public static final String TIME = "time";

        public static final byte [] ALERT_LEVEL_LOW = { (byte) 0x00};
        public static final byte [] ALERT_LEVEL_MID = { (byte) 0x01};
        public static final byte [] ALERT_LEVEL_HIGH = { (byte) 0x02};

        public final static String OK = "OK";
        public final static String NO = "No";
        public final static String YES = "Yes";
        public final static String CANCEL = "Cancel";
        public final static String SEND = "Send";
        public final static String SET = "Set";
        public final static String SENSOR_BASE = "";
}
