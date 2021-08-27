import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushBar {
  static showSimpleFlushBar(
      String message, BuildContext context, Color baccolor, Color textcolor) {
    return Flushbar(
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: textcolor),
      ),
      shouldIconPulse: true,
      backgroundColor: baccolor,
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 2),
    )..show(context);
  }
}
