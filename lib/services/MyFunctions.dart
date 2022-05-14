import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyFunctions {
  toast(msg, color) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: color,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
  }
}
