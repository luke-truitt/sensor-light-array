package com.bluetooth.ece350_project.ui.services;

import android.content.Context;
import android.view.Gravity;
import android.widget.Toast;

public class ToasterService {
    public static void makeToast(Context context, String message, int duration) {
        Toast toast = Toast.makeText(context, message, duration);
        toast.setGravity(Gravity.CENTER, 0, 0);
        toast.show();
    }
}
