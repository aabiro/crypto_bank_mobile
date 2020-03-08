library constants;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final storage = new FlutterSecureStorage();

final clientID = "com.example.flutter_app";
final mysecret = "mysecret";
final clientCredentials = Base64Encoder().convert("$clientID:$mysecret".codeUnits);

const Color mainColor = Color(0xff673AB7);
const Color optionalColor = Color(0xff9575CD);
const Color accentColor = Color(0xff2196F3);



const bikeTypes = ["Road bike", "Mountain bike", "BMX", "Commuting"];

const torontoLocations = [
  LatLng(43.655531,-79.4090097),
  LatLng(43.654382,-79.4068427),
  LatLng(43.650842,-79.3792907),
  LatLng(43.641774,-79.4014347),
  LatLng(43.669594,-79.3801487),
];

const londonLocations = [
  LatLng(42.997403,-81.2588867),
  LatLng(42.99428,-81.2596587),
  LatLng(43.005893,-81.2791427),
  LatLng(43.009722,-81.2678127),
];

const indPlanArray = ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29'];
const compPlanArray = ['30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59','60','61','62','63','64','65','66','67','68','69','70','71','72','73','74','75','76','77','78','79','80','81','82','83','84','85','86','87','88','89','90','91','92','93','94','95','96','97','98','99','100'];