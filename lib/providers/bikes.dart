import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bike.dart';

class Bikes with ChangeNotifier {
  String token;
  String userId;
  List<Bike> _items = [];
  List<Bike> _userBikes = [];

  // //change urls to final , pass it to objects
  //changenotifierproxy provider instead!!

  Bikes([this.token, this.userId, this._items]);

  List<Bike> get items {
    return _items;
  }

  List<Bike> get userBikes {
    return _userBikes;
  }

  //the bikes shown on map
  Future<void> getBikes() async {
    final url = 'https://capstone-addb0.firebaseio.com/bikes.json?auth=$token';
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    print(json.decode(response.body));
    final List<Bike> bikesLoaded = [];
    data.forEach((bikeId, bikeData) {
      //watch out for called on null
      bikesLoaded.add(
        Bike(
          // userId: data['userId'],
          isActive: data['isActive'],
          // lat: 0,     //laod correct lat lng here
          // lng: 0
        ),
      );
    });
    _items = bikesLoaded;
    notifyListeners();
  }

  Future<void> getUserBikes(String token) async {
    final url = 'https://capstone-addb0.firebaseio.com/bikes.json?auth=$token';
    final response = await http.get(url);
    final data = json.decode(response.body) as Map<String, dynamic>;
    print(json.decode(response.body));
    final List<Bike> bikesLoaded = [];
    data.forEach((bikeId, bikeData) {
      //watch out for called on null
      bikesLoaded.add(
        //this is needed for the correct initial list loading... it loads the bikes upon app load
        Bike(
            id: bikeId,
            userId: bikeData['userId'],
            isActive: bikeData['isActive'],
            name: bikeData["name"]
            // lat: 0,     //laod correct lat lng here
            // lng: 0
            ),
      );
    });
    _userBikes = bikesLoaded;
    notifyListeners();
  }

  Bike findById(String id) {
    return userBikes.firstWhere((bike) => bike.id == id);
  }

  //add bike to the users bike list
  void addBike(Bike bike, String userId, String token) {
    final url = 'https://capstone-addb0.firebaseio.com/bikes.json?auth=$token';
    http
        .post(url,
            body: json.encode({
              'qrCode': bike.qrCode,
              'isActive': bike.isActive,
              'name': bike.name,
              'userId': userId,
            }))
        .then(
      (response) {
        final newBike = Bike(
          id: json.decode(response.body)["name"], //'name' is the id of the bike
          qrCode: bike.qrCode,
          isActive: true,
          name: bike.name,
          userId: userId,
        );

        userBikes.add(newBike);
        print(userBikes);
        notifyListeners();
      },
    );
  }
}
