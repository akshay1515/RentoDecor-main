import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomPopups {
  static showToastMessage(String message) {
    Fluttertoast.showToast(
        msg: "Product Already Exists",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
