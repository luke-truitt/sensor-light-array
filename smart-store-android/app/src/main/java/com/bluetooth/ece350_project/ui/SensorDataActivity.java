package com.bluetooth.ece350_project.ui;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothGattService;
import android.content.ComponentName;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.ServiceConnection;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.IBinder;
import android.os.Message;
import android.support.annotation.NonNull;
import android.support.annotation.RequiresApi;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AlertDialog;
import android.text.InputType;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.EditorInfo;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.Toolbar;

import com.bluetooth.ece350_project.data.remote.BluetoothChatService;
import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.firestore.DocumentReference;
import com.google.firebase.firestore.DocumentSnapshot;
import com.google.firebase.firestore.FieldValue;
import com.google.firebase.firestore.FirebaseFirestore;
import com.google.firebase.firestore.Query;
import com.google.firebase.firestore.QuerySnapshot;
import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.series.DataPoint;
import com.jjoe64.graphview.series.LineGraphSeries;
import com.bluetooth.ece350_project.R;
import com.bluetooth.ece350_project.data.Constants;
import com.bluetooth.ece350_project.data.model.Graph;
import com.bluetooth.ece350_project.data.remote.BleAdapterService;
import com.bluetooth.ece350_project.data.remote.BleScanner;
import com.bluetooth.ece350_project.data.remote.ScanResultsConsumer;
import com.bluetooth.ece350_project.ui.services.AudioService;
import com.bluetooth.ece350_project.ui.services.ToasterService;
import com.bluetooth.ece350_project.util.CommonUtil;

import java.io.File;
import java.io.FileOutputStream;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.bluetooth.ece350_project.data.Constants.CANCEL;
import static com.bluetooth.ece350_project.data.Constants.DATE_MAP_KEY;
import static com.bluetooth.ece350_project.data.Constants.NO;
import static com.bluetooth.ece350_project.data.Constants.OK;
import static com.bluetooth.ece350_project.data.Constants.READINGS_DB;
import static com.bluetooth.ece350_project.data.Constants.READING_MAP_KEY;
import static com.bluetooth.ece350_project.data.Constants.SENSOR_BASE;
import static com.bluetooth.ece350_project.data.Constants.SENSOR_DB;
import static com.bluetooth.ece350_project.data.Constants.SENSOR_ID_DB;
import static com.bluetooth.ece350_project.data.Constants.SENSOR_MAC_DB;
import static com.bluetooth.ece350_project.data.Constants.SENSOR_NAME_DB;
import static com.bluetooth.ece350_project.data.Constants.SET;
import static com.bluetooth.ece350_project.data.Constants.YES;
import static java.lang.Math.PI;

@RequiresApi(api = Build.VERSION_CODES.LOLLIPOP)
public class SensorDataActivity extends Activity {

    private final static String TAG = "Sensor Info";
    private static final String CAPACITANCE_LABEL= "Capacitance (pF)";
    private static final String FREQUENCY_LABEL= "Frequency (Hz)";
    private static final String CAPACITANCE_DATA_LABEL = "COLLECT CAPACITANCE DATA";
    private static final String FREQUENCY_DATA_LABEL = "COLLECT FREQUENCY DATA";
    private static final String CONNECTED = "CONNECTED";
    private static final String NOT_CONNECTED = "NOT CONNECTED";
    private static final String READINGS = "Readings";
    private static final String TIME = "Time";
    private static final String CAP_TAG = "pF";
    private static final String TIME_TAG = "Time";
    private static final String TEMP_TAG = "C";
    private static final String VOLTAGE_TAG = "V";

    private static final String EDIT_NAME_TITLE = "Change Name of Sensor";
    private static final String EDIT_NAME_BODY = "Choose what to append to Tyrata_";
    private static final String EDIT_NAME_TITLE2 = "Reminder";
    private static final String EDIT_NAME_BODY2 = "Change will take effect after BLE is power cycled.";

    private static final String REQ_LOC_TITLE = "Permission Required";
    private static final String REQ_LOC_BODY = "Please grant Location access so this application can perform Bluetooth scanning";

    private static final String RESET_TITLE = "Are you sure?";
    private static final String RESET_BODY = "This will reset sensor to FACTORY settings.";
    private static final String RESET_TOAST = "Resetting Sensor";

    private static final String CLEAR_TITLE =  "Are you sure?";
    private static final String CLEAR_BODY = "This will clear all of the data collected.";
    private static final String CLEAR_TITLE2 = "Actually??";

    private static final String ON_CLICK_OPT = "Take reading on button-click";
    private static final String ONE_SECOND_OPT = "Take reading every 1s";
    private static final String TEN_SECOND_OPT = "Take reading every 10s";
    private static final String THIRTY_SECOND_OPT = "Take reading every 30s";
    private static final String SIXTY_SECOND_OPT = "Take reading every 60s";

    private static final String RF_OPT = "RF";
    private static final String AD7747_OPT = "AD7747";

    private static final int REQUEST_LOCATION = 0;
        //  private BluetoothLeService mBluetoothLeService
    private Graph mGraph;
    private long mReqTime;
    private String device_name;
    private String device_address;
    private boolean back_requested = false;
    private HashMap<String, String> lastReading;
    private ListAdapter readings_list_adapter;
    private String reading = "";
    public String sensor_mode;
    private FirebaseFirestore db = FirebaseFirestore.getInstance();
    private DocumentSnapshot active_sensor;
    private boolean isReadings;
    private boolean isAD7747;
    private boolean isPhone;
    public static boolean isAfterReading;

    TextView waitText, irText, motionText, temperatureText;
    int waitCount, irCount;

    // Intent request codes
    private static final int REQUEST_CONNECT_DEVICE_SECURE = 1;
    private static final int REQUEST_CONNECT_DEVICE_INSECURE = 2;
    private static final int REQUEST_ENABLE_BT = 3;

    // Layout Views
    private ListView mConversationView;
    private EditText mOutEditText;
    private Button mSendButton;

    /**
     * Name of the connected device
     */
    private String mConnectedDeviceName = null;

    /**
     * Array adapter for the conversation thread
     */
    private ArrayAdapter<String> mConversationArrayAdapter;

    /**
     * String buffer for outgoing messages
     */
    private StringBuffer mOutStringBuffer;

    /**
     * Local Bluetooth adapter
     */
    private BluetoothAdapter mBluetoothAdapter = null;

    /**
     * Member object for the chat services
     */
    private BluetoothChatService mChatService = null;

    public static class ViewHolder {
        public TextView time;
        public TextView data;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sensor_data);
        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();


        if (mBluetoothAdapter == null && SensorDataActivity.this != null) {
            Toast.makeText(SensorDataActivity.this, "Bluetooth is not available", Toast.LENGTH_LONG).show();
            finish();
        }

        Intent data = getIntent();

        initialize();
    }

    @Override
    public void onStart() {
        super.onStart();
        if (mBluetoothAdapter == null) {
            return;
        }
        // If BT is not on, request that it be enabled.
        // setupChat() will then be called during onActivityResult
        if (!mBluetoothAdapter.isEnabled()) {
            Intent enableIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(enableIntent, REQUEST_ENABLE_BT);
            // Otherwise, setup the chat session
        } else if (mChatService == null) {
            setupChat();
        }
    }
    @Override
    protected void onResume() {
        super.onResume();
//        ((Button) SensorDataActivity.this.findViewById(R.id.req_btn)).setEnabled(bluetooth_le_adapter != null && bluetooth_le_adapter.isConnected());


        // Performing this check in onResume() covers the case in which BT was
        // not enabled during onStart(), so we were paused to enable it...
        // onResume() will be called when ACTION_REQUEST_ENABLE activity returns.
        if (mChatService != null) {
            // Only if the state is STATE_NONE, do we know that we haven't started already
            if (mChatService.getState() == BluetoothChatService.STATE_NONE) {
                // Start the Bluetooth chat services
                mChatService.start();
            }
        }
    }

    /**
     * Set up the UI and background operations for chat.
     */
    private void setupChat() {
        Log.d(TAG, "setupChat()");

        // Initialize the array adapter for the conversation thread
        Activity activity = SensorDataActivity.this;
        if (activity == null) {
            return;
        }

        // Initialize the send button with a listener that for click events
        mSendButton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Send a message using content of the edit text widget
                String message = "ll";
                sendMessage(message);

            }
        });

        // Initialize the BluetoothChatService to perform bluetooth connections
        mChatService = new BluetoothChatService(activity, mHandler);

        // Initialize the buffer for outgoing messages
        mOutStringBuffer = new StringBuffer();
    }

    /**
     * Updates the status on the action bar.
     *
     * @param resId a string resource ID
     */
    private void setStatus(int resId) {
        Activity activity = SensorDataActivity.this;
        if (null == activity) {
            return;
        }
        final ActionBar actionBar = activity.getActionBar();
        if (null == actionBar) {
            return;
        }
        actionBar.setSubtitle(resId);
    }

    /**
     * Updates the status on the action bar.
     *
     * @param subTitle status
     */
    private void setStatus(CharSequence subTitle) {
        Activity activity = SensorDataActivity.this;
        if (null == activity) {
            return;
        }
        final ActionBar actionBar = activity.getActionBar();
        if (null == actionBar) {
            return;
        }
        actionBar.setSubtitle(subTitle);
    }

    /**
     * The Handler that gets information back from the BluetoothChatService
     */
    private final Handler mHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            Activity activity = SensorDataActivity.this;
            switch (msg.what) {
                case Constants.MESSAGE_STATE_CHANGE:
                    switch (msg.arg1) {
                        case BluetoothChatService.STATE_CONNECTED:
                            setStatus(getString(R.string.title_connected_to, mConnectedDeviceName));
                            readings_list_adapter.clear();
                            readings_list_adapter.notifyDataSetChanged();
                            break;
                        case BluetoothChatService.STATE_CONNECTING:
                            setStatus(R.string.title_connecting);
                            break;
                        case BluetoothChatService.STATE_LISTEN:
                        case BluetoothChatService.STATE_NONE:
                            setStatus(R.string.title_not_connected);
                            break;
                    }
                    break;
                case Constants.MESSAGE_WRITE:
                    byte[] writeBuf = (byte[]) msg.obj;
                    // construct a string from the buffer
                    String writeMessage = new String(writeBuf);
                    //readings_list_adapter.("Me:  " + writeMessage);
                    break;
                case Constants.MESSAGE_READ:
                    byte[] readBuf = (byte[]) msg.obj;
                    // construct a string from the valid bytes in the buffer
                    String readMessage = new String(readBuf, 0, msg.arg1);
                    String time = new Date().toString();
                   HashMap<String, String> reading = new HashMap<>();
                   reading.put(DATE_MAP_KEY, time);
                   reading.put(READING_MAP_KEY, readMessage);
                    readings_list_adapter.addMeasurement(reading);
                    readings_list_adapter.notifyDataSetChanged();
                    SensorDataActivity.this.handleMessage(readMessage);
                    break;
                case Constants.MESSAGE_DEVICE_NAME:
                    // save the connected device's name
                    mConnectedDeviceName = msg.getData().getString(Constants.DEVICE_NAME);
                    if (null != activity) {
                        Toast.makeText(activity, "Connected to "
                                + mConnectedDeviceName, Toast.LENGTH_SHORT).show();
                    }
                    break;
                case Constants.MESSAGE_TOAST:
                    if (null != activity) {
                        Toast.makeText(activity, msg.getData().getString(Constants.TOAST),
                                Toast.LENGTH_SHORT).show();
                    }
                    break;
            }
        }
    };

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        switch (requestCode) {
            case REQUEST_CONNECT_DEVICE_SECURE:
                // When DeviceListActivity returns with a device to connect
                if (resultCode == Activity.RESULT_OK) {
                    connectDevice(data, true);
                }
                break;
            case REQUEST_CONNECT_DEVICE_INSECURE:
                // When DeviceListActivity returns with a device to connect
                if (resultCode == Activity.RESULT_OK) {
                    connectDevice(data, false);
                }
                break;
            case REQUEST_ENABLE_BT:
                // When the request to enable Bluetooth returns
                if (resultCode == Activity.RESULT_OK) {
                    // Bluetooth is now enabled, so set up a chat session
                    setupChat();
                } else {
                    // User did not enable Bluetooth or an error occurred
                    Log.d(TAG, "BT not enabled");
                    Activity activity = SensorDataActivity.this;
                    if (activity != null) {
                        Toast.makeText(activity, R.string.bt_not_enabled_leaving,
                                Toast.LENGTH_SHORT).show();
                        activity.finish();
                    }
                }
        }
    }

    /**
     * Establish connection with other device
     *
     * @param data   An {@link Intent} with {@link DeviceListActivity#EXTRA_DEVICE_ADDRESS} extra.
     * @param secure Socket Security type - Secure (true) , Insecure (false)
     */
    private void connectDevice(Intent data, boolean secure) {
        // Get the device MAC address
        Bundle extras = data.getExtras();

        if (extras == null) {
            return;

        }
        String address = extras.getString(DeviceListActivity.EXTRA_DEVICE_ADDRESS);

        device_address = address;

        // show the device name
        ((TextView) this.findViewById(R.id.device_address)).setText(device_address);
        ((TextView) this.findViewById(R.id.device_name)).setText("Sensor Hub");
        // Get the BluetoothDevice object
        BluetoothDevice device = mBluetoothAdapter.getRemoteDevice(address);
        // Attempt to connect to the device
        mChatService.connect(device, secure);
    }

    private void clearData() {
        // Show alert box that asks to confirm deletion
        AlertDialog.Builder alert = new AlertDialog.Builder(SensorDataActivity.this);
        alert.setTitle(CLEAR_TITLE);
        alert.setMessage(CLEAR_BODY);
        alert.setPositiveButton(YES, (dialog, whichButton) -> {
            AlertDialog.Builder alert2 = new AlertDialog.Builder(SensorDataActivity.this);
            alert2.setTitle(CLEAR_TITLE2);
            alert2.setPositiveButton(YES, (dialog2, whichButton2) ->  {
                this.readings_list_adapter.clear();
                active_sensor.getReference().update(READINGS_DB, new ArrayList<HashMap<String, String>>());
                readings_list_adapter.notifyDataSetChanged();
            });
            alert2.setNegativeButton(CANCEL, (dialog2, whichButton2) -> {

            });
            alert2.show();
        });
        alert.setNegativeButton(NO, (dialog, whichButton) -> {
        });
        alert.show();
    }

    private void showMsg(final String msg) {
        Log.d(Constants.TAG, msg);
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                CommonUtil.sensorValues[2] = msg;
            }
        });
    }
    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mChatService != null) {
            mChatService.stop();
        }
    }

    /**
     * The action listener for the EditText widget, to listen for the return key
     */
    private TextView.OnEditorActionListener mWriteListener
            = new TextView.OnEditorActionListener() {
        public boolean onEditorAction(TextView view, int actionId, KeyEvent event) {
            // If the action is a key-up event on the return key, send the message
            if (actionId == EditorInfo.IME_NULL && event.getAction() == KeyEvent.ACTION_UP) {
                String message = view.getText().toString();
                sendMessage(message);
            }
            return true;
        }
    };

    public void onBackPressed() {
        Log.d(Constants.TAG, "onBackPressed");
        back_requested = true;
        finish();
    }


    private class ListAdapter extends BaseAdapter {
        private ArrayList<HashMap<String, String>> readings;

        public ListAdapter() {
            super();
            readings = new ArrayList<>();
        }

        public void addMeasurement(HashMap<String, String> measurement) {
//            for(HashMap map : readings) {
//                if(map.get("Capacitance") == measurement.get("Capacitance")) {
//                    return;
//                }
//            }

            readings.add(0, measurement);
        }

        public void clear() {
            readings.clear();
        }

        @Override
        public int getCount() {
            return readings.size();
        }

        @Override
        public HashMap<String, String> getItem(int i) {
            return readings.get(i);
        }

        @Override
        public long getItemId(int i) {
            return i;
        }

        @Override
        public View getView(int i, View view, ViewGroup viewGroup) {
            SensorDataActivity.ViewHolder viewHolder;
            if (view == null) {
                view = SensorDataActivity.this.getLayoutInflater().inflate(R.layout.item_sensor, null);
                viewHolder = new SensorDataActivity.ViewHolder();
                viewHolder.time = (TextView) view.findViewById(R.id.data_time);
                viewHolder.data = (TextView) view.findViewById(R.id.data_reading);

                view.setTag(viewHolder);
            } else {
                viewHolder = (SensorDataActivity.ViewHolder) view.getTag();
            }
            viewHolder.time.setText(readings.get(i).get(DATE_MAP_KEY));
            viewHolder.data.setText(readings.get(i).get(READING_MAP_KEY));

            if(isAD7747) {
//                viewHolder.capacitance.setText(readings.get(i).get(AD7747_MAP_KEY));
            } else {
//                String freq = readings.get(i).get(RF_MAP_KEY);
//                viewHolder.frequency.setText(freq);
//                viewHolder.capacitance.setText(convertFreqToCap(freq));
            }

            return view;
        }
    }

    private String convertFreqToCap(String freq) {
            try{
                double freqNum = Double.parseDouble(freq);

                double capNum = Math.pow(10, 12) * ((1/(Math.pow(2 * PI * freqNum, 2)))/(16.405 * Math.pow(10, -6)));

                return capNum + "";

            } catch(Exception e) {
                System.out.println(e);
                return "";
            }
    }

    public void editName(View view) {
        // Show alert box that asks to confirm deletion
        AlertDialog.Builder alert = new AlertDialog.Builder(view.getContext());
        // Set up the input
        final EditText input = new EditText(this);
        // Specify the type of input expected; this, for example, sets the input as a password, and will mask the text
        input.setInputType(InputType.TYPE_CLASS_TEXT);
        alert.setView(input);
        alert.setTitle(EDIT_NAME_TITLE);
        alert.setMessage(EDIT_NAME_BODY);
        // Set up the buttons
        alert.setPositiveButton(SET, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                String x = input.getText().toString();

                device_name = SENSOR_BASE + x;
                AlertDialog.Builder alert2 = new AlertDialog.Builder(view.getContext());
                alert2.setTitle(EDIT_NAME_TITLE2);
                alert2.setMessage(EDIT_NAME_BODY2);
                alert2.setPositiveButton(OK, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog2, int which) {

                        dialog2.cancel();
                    }
                });
                alert2.show();
            }
        });
        alert.setNegativeButton(CANCEL, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.cancel();
            }
        });
        alert.show();
    }

    private void initialize() {
        initVariables();
        setToolbar();
        setDeviceData();
        initGraph();
        setButtons();
        setLabels();
        setLists();
    }

    private void setLists() {
        ListView listView = (ListView) this.findViewById(R.id.other_info);
        listView.setAdapter(readings_list_adapter);
    }
    private void initVariables() {
//        sensor_mode = isAD7747 ? Constants.AD7747_MODE : Constants.RF_MODE;
//        coll = isAD7747 ? AD7747_DB : RF_DB;
        isReadings = true;
//        ble_scanner = new BleScanner(this.getApplicationContext());
//        mHandler = new Handler();
    }

    private void setToolbar() {
        setActionBar(new Toolbar(getApplicationContext()));
        getActionBar().setDisplayHomeAsUpEnabled(true);
        getActionBar().setDisplayShowHomeEnabled(true);
    }

    private void initGraph() {
            if(isPhone){
                return;
            }
//        GraphView graphView = findViewById(R.id.graph_beta);
//        mGraph = new Graph(graphView, READINGS, (isAD7747  ? CAPACITANCE_LABEL : FREQUENCY_LABEL), "");
        //mGraph.addSecondaryAxis("Temperature (C)");
    }

    private void setDeviceData() {
        View editName = findViewById(R.id.ic_settings);
        editName.setEnabled(false);
        readings_list_adapter = new SensorDataActivity.ListAdapter();
        final Intent intent = getIntent();

    }

    private void setButtons() {
        Button clr_btn = findViewById(R.id.clear_data);
        clr_btn.setOnClickListener(view -> {
            String message = "dd";
            sendMessage(message);
        });

        Button reset_btn = findViewById(R.id.share_btn);
        reset_btn.setOnClickListener(view ->
                connectDevice(getIntent(), false));
        mSendButton = findViewById(R.id.reset_sensor);
        Button exp_btn = findViewById(R.id.export_btn);
        exp_btn.setOnClickListener(view -> {
            onExportData();
        });
    }

    private void setLabels() {
        waitText = findViewById(R.id.collected_wait);
        irText = findViewById(R.id.collected_ir);
        motionText = findViewById(R.id.collected_motion);
        temperatureText = findViewById(R.id.collected_temp);
    }

    /**
     * Sends a message.
     *
     * @param message A string of text to send.
     */
    private void sendMessage(String message) {
        // Check that we're actually connected before trying anything
        if (mChatService.getState() != BluetoothChatService.STATE_CONNECTED) {
            Toast.makeText(SensorDataActivity.this, R.string.not_connected, Toast.LENGTH_SHORT).show();
            return;
        }

        // Check that there's actually something to send
        if (message.length() > 0) {
            // Get the message bytes and tell the BluetoothChatService to write
            byte[] send = message.getBytes();
            mChatService.write(send);

        }
    }

    private void handleMessage(String message) {
        handleMotion(message);
        if(message.toLowerCase().contains("b")) {
            handleButtonClick(message);
            return;
        } else if(message.toLowerCase().contains("i")){
            handleIR(message);
            return;
        }  else if(message.toLowerCase().contains("t")) {
            handleTemperature(message);
            return;
        }
    }

    private void handleButtonClick(String message) {
        waitCount = waitCount+1;
        waitText.setText(waitCount+"");
    }

    private void handleIR(String message) {
        irCount = irCount + 1;
        irText.setText(irCount+"");
    }

    private void handleMotion(String message) {
        if(message.toLowerCase().contains("m")) {
            motionText.setText("Yes");
        } else {
            motionText.setText("No");
        }

    }

    private void handleTemperature(String message) {
        temperatureText.setText(message);
    }

    public void onExportData() {
        Uri fileUri = getFormattedSensorData();
        try {
            Intent intent = new Intent(Intent.ACTION_SENDTO);
            intent.setType("text/plain");
            intent.putExtra(Intent.EXTRA_SUBJECT, "Reading data from + " + new Date());
            intent.putExtra(Intent.EXTRA_STREAM, fileUri);
            intent.setData(Uri.parse("mailto:lot@duke.edu"));
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);

            startActivity(intent);
        } catch(Exception e)  {
            System.out.println("is exception raises during sending mail"+e);
        }
    }

    // TODO: Make into CSV Service
    /**
     * Creates a CSV file with fields Timestamp, Reading and Difference
     * @return File path of csv (Uri)
     */
    private Uri getFormattedSensorData() {
        String columnString;
        columnString = "\"Timestamp\",\"Device_Name\",\"Reading\"";

        StringBuilder resultString = new StringBuilder(columnString);
        for (int i = 0; i < readings_list_adapter.getCount(); i++) {
            HashMap<String, String> reading = readings_list_adapter.getItem(i);
                resultString.append("\n")
                        .append(reading.get(DATE_MAP_KEY))
                        .append(",")
                        .append(mConnectedDeviceName)
                        .append(",")
                        .append(reading.get(READING_MAP_KEY));

        }


        String combinedString = resultString.toString();

        File file = null;
        File root = Environment.getExternalStorageDirectory();
        if (root.canWrite()) {
            File dir = new File(root.getAbsolutePath() + "/SensorData");
            dir.mkdirs();
            file = new File(dir, "readings" + new Date().toString() + ".csv");
            FileOutputStream out;
            try {
                out = new FileOutputStream(file);
                out.write(combinedString.getBytes());
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return (file == null) ? null : Uri.fromFile(file);
    }
}
