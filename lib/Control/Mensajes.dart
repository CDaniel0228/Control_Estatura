// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Mensajes {
  info(titulo) {
    Fluttertoast.showToast(
        msg: titulo,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xFF333742),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}