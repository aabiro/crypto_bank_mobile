import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../models/exception_handler.dart';
import 'bike.dart';

class Bikes with ChangeNotifier {
  String token;
  String userId;
  List<Bike> _allBikes = [];
  List<Bike> _userBikes = [];

  Bikes([this.token, this.userId, this._allBikes]);

  List<Bike> get allBikes {
    return _allBikes;
  }

  List<Bike> get userBikes {
    return _userBikes;
  }

  Future<void> updateBike(String id, Bike newBike) async {
    final bikeIndexAll = allBikes.indexWhere((bike) => bike.id == id);
    final bikeIndexUser = userBikes.indexWhere((bike) => bike.id == id);
    if (bikeIndexAll >= 0) {
      final url =
          "https://capstone-addb0.firebaseio.com/bikes/$id.json?auth=$token";
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'qrCode': newBike.qrCode,
            'isActive': newBike.isActive,
            'name': newBike.name,
            'userId': newBike.userId,
            'lat': newBike.lat,
            'lng': newBike.lng
          },
        ),
      );
      if (response.statusCode >= 400) {
        throw ExceptionHandler('Cannot update bike. ${response.body}');
      }
      allBikes[bikeIndexAll] = newBike;
      userBikes[bikeIndexUser] = newBike;
      print('updated bike :${response.toString()}');
      notifyListeners();
    } else {
      print('did not update bike');
    }
  }

  Future<void> deleteBike(String id) async {
    final url =
        "https://capstone-addb0.firebaseio.com/bikes/$id.json?auth=$token";
    final bikeIndex = userBikes.indexWhere((bike) => bike.id == id);
    var bike = userBikes[bikeIndex];
    userBikes.removeAt(bikeIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      userBikes.insert(bikeIndex, bike);
      notifyListeners();
      throw ExceptionHandler('Cannot delete bike. ${response.body}');
    }
    bike = null;
  }

  Future<List<Bike>> getAllUserBikes() async {
    final List<Bike> bikesLoaded = [];
    final url = 'https://capstone-addb0.firebaseio.com/bikes.json?auth=$token';
    final response = await http.get(url).then(
      (response) {
        if (response.statusCode < 200 ||
            response.statusCode >= 400 ||
            json == null) {
          throw ExceptionHandler(response.body);
        } else {
          final data = json.decode(response.body) as Map<String, dynamic>;
          data.forEach((bikeId, bikeData) {
            bikesLoaded.add(
              //this is needed for the correct initial list loading... it loads the bikes upon app load
              Bike(
                  id: bikeId,
                  userId: bikeData["userId"],
                  isActive: bikeData["isActive"],
                  name: bikeData["name"],
                  qrCode: bikeData["qrCode"],
                  lat: bikeData["lat"], //laod correct lat lng here
                  lng: bikeData["lng"]),
            );
          });
          _allBikes = bikesLoaded;
          notifyListeners();
        }
      },
    );
    return bikesLoaded;
  }

  Future<void> getUserBikes({bool allBikes = false}) async {
    final List<Bike> bikesLoaded = [];
    var url;
    if (allBikes == true) {
      url = 'https://capstone-addb0.firebaseio.com/bikes.json?auth=$token';
    } else {
      url =
          'https://capstone-addb0.firebaseio.com/bikes.json?auth=$token&orderBy="userId"&equalTo="$userId"';
      final response = await http.get(url).then(
        (response) {
          if (response.statusCode < 200 ||
              response.statusCode >= 400 ||
              json == null) {
            throw ExceptionHandler(response.body);
          } else {
            final data = json.decode(response.body) as Map<String, dynamic>;
            data.forEach((bikeId, bikeData) {
              bikesLoaded.add(
                //this is needed for the correct initial list loading... it loads the bikes upon app load
                Bike(
                    id: bikeId,
                    userId: bikeData["userId"],
                    isActive: bikeData["isActive"],
                    qrCode: bikeData["qrCode"],
                    name: bikeData["name"],
                    lat: bikeData["lat"],
                    lng: bikeData["lng"]),
              );
            });
            if (allBikes == true) {
              _allBikes = bikesLoaded;
            } else {
              _userBikes = bikesLoaded;
            }
            notifyListeners();
          }
        },
      );
    }
  }

  Bike findById(String id) {
    return allBikes.firstWhere((bike) => bike.id == id);
  }

  Bike findByUserId(String userId) {
    return allBikes.firstWhere((bike) => bike.userId == userId);
  }

  Bike findByQrCode(String qrCode) {
    print('find by qr code : $qrCode');
    return allBikes.firstWhere((bike) => bike.qrCode == qrCode);
  }

  Bike findByName(String name) {
    return allBikes.firstWhere((bike) => bike.name == name);
  }

  void addBike(Bike bike) {
    final url = 'https://capstone-addb0.firebaseio.com/bikes.json?auth=$token';
    http
        .post(url,
            body: json.encode({
              'qrCode': bike.qrCode,
              'isActive': bike.isActive,
              'name': bike.name,
              'userId': bike.userId,
              'lat': bike.lat,
              'lng': bike.lng
            }))
        .then(
      (response) {
        var data = json.decode(response.body);
        final newBike = Bike(
            id: json.decode(response.body)["name"],
            qrCode: bike.qrCode,
            isActive: true,
            name: bike.name,
            userId: bike.userId,
            lat: bike.lat,
            lng: bike.lng);
        userBikes.add(newBike);
        allBikes.add(newBike); //need to separate this logic
        notifyListeners();
      },
    );
  }
}
