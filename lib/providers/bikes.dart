import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bike.dart';

class Bikes with ChangeNotifier {
  List<Bike> _items = [
    Bike(id: '1', name: "bike 1", isActive: true),
    Bike(id: '2', name: "bike 2", isActive: false),
  ];


  List<Bike> get items {
    return [..._items]; //is a copy, want to keep outside from changing values
  }

  Bike findById(String id) {
    return _items.firstWhere((bike) => bike.id == id);
  }

  void addBike(Bike bike) {
    const url = 'https://capstone-addb0.firebaseio.com/bikes.json';
    http.post(url, body: json.encode({
      'qrCode': bike.qrCode,
      'isActive': bike.isActive,
      'name': bike.name
    })).then((response) {
      final newBike = Bike(
      id: json.decode(response.body)['name'],
      qrCode: bike.qrCode,
      isActive: true,
      name: 'Bike'
    );
     _items.add(newBike);
    notifyListeners();
    });
   
   
  }
}