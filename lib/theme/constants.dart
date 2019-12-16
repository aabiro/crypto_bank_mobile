library constants;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/bike.dart';

final clientID = "com.example.flutter_app";
final mysecret = "mysecret";
final clientCredentials = Base64Encoder().convert("$clientID:$mysecret".codeUnits);

const Color mainColor = Color(0xff673AB7);
const Color optionalColor = Color(0xff9575CD);
const Color accentColor = Color(0xff2196F3);

List<Bike> bikes =[
    Bike(1, "mam", 1919, true, true, false, "www."),
    Bike(2, "mam", 1919, true, true, false, "www.")
  ];