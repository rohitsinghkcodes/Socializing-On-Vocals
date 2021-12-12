import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

DateTime? backBtnPressedTime = null;

Future<bool> OnBackPressed()async{
  DateTime currTime = DateTime.now();
  if(backBtnPressedTime == null || currTime.difference(backBtnPressedTime!)>Duration(milliseconds: 1500))
  {
    backBtnPressedTime = currTime;
    Fluttertoast.showToast(
        msg: "Double press to exit",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return false;
  }
  return true;
}