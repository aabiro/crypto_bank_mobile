import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'bike.dart';

class Bikes with ChangeNotifier {
  List<Bike> _items = [
    Bike('1', "bike 1", true),
    Bike('2', "bike 2", false)
  ];


  List<Bike> get items {
    return [..._items]; //is a copy, want to keep outside from changing values
  }

  Bike findById(String id) {
    return _items.firstWhere((bike) => bike.id == id);
  }

  void addBike() {
    // _items.add(value);
    notifyListeners();
  }
}