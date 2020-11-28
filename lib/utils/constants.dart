import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constants {
  // static final endpoint = 'https://delivery-yoshi.herokuapp.com/';
  static final endpoint = 'http://localhost:8080/';
  static final currency = new NumberFormat("#,##0.00", "pt_BR");

  static const kTitleTextStyle = TextStyle(
    fontSize: 21.0,
  );
}
