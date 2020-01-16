import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/exception_handler.dart';

import 'journey.dart';

class Journeys with ChangeNotifier {
  String token;
  String userId;
  List<Journey> _journeys = [];

  Journeys([this.token, this.userId, this._journeys]);

  List<Journey> get journeys {
    return _journeys;
  }

  void addJourney(Journey journey) {
    print('token add journey $token');
    final url = 'https://flutter-database-78c33.firebaseio.com/journeys.json?auth=$token';
    http
        .post(url,
            body: json.encode({
              'startTime': journey.startTime.toString(),
              'endTime': null,
              'dayOfTheWeek': journey.dayOfTheWeek.toString(),//update on trip end
              'userId': userId,
              'bikeId': journey.bikeId, //passed in by journey
              'distance': 0,
              'hasEnded':false
            }))
        .then(
      (response) {
        var data = json.decode(response.body);
        print('response $data');  
        final newJourney = Journey(
          id: json.decode(response.body)["name"], //'name' is the id of the Journey
          startTime: data['startTime'],
          endTime: data['endTime'],
          dayOfTheWeek: data['dayOfTheWeek'],//update on trip end
          userId: data['userId'],
          bikeId: data['bikeId'], //passed in by journey
          distance: data['distance'],
          hasEnded: false
        );
        print('newJourney id: ${newJourney.id}');
        print('newJourney userId: ${newJourney.userId}');
        // _journeys.add(newJourney); //called on null ??
        notifyListeners();
      },
    );
  }

  Future<bool> userIsOnTrip() async {
    //no token or userId here, when coming back to map...
    // print('token get user bikes $token');
    // final List<Journey> bikesLoaded = [];
    var url;
    var result;
    // if (allBikes == true) {
    //   url = 'https://flutter-database-78c33.firebaseio.com/bikes.json?auth=$token';
    // } else {
      url =
          'https://flutter-database-78c33.firebaseio.com/journeys.json?auth=$token&orderBy="userId"&equalTo="$userId"&hasEnded=false';
      final response = await http.get(url).then(
        (response) {
          if (response.statusCode < 200 ||
              response.statusCode >= 400 ||
              json == null) {
            //handle exceptions
            throw ExceptionHandler(response.body);
          } else {
            final data = json.decode(response.body) as Map<String, dynamic>;
            if (data.length > 0) {
              result = true;
            } else {
              result = false;
            }
           
          }
        },
      );
      return result;
    // }
  }

  // Future<bool> getJourney({bool allBikes = false}) async {
  //   //no token or userId here, when coming back to map...
  //   // print('token get user bikes $token');
  //   // final List<Journey> bikesLoaded = [];
  //   var url;
  //   var result;
  //   // if (allBikes == true) {
  //   //   url = 'https://flutter-database-78c33.firebaseio.com/bikes.json?auth=$token';
  //   // } else {
  //     url =
  //         'https://flutter-database-78c33.firebaseio.com/journeys.json?auth=$token&orderBy="userId"&equalTo="$userId"&hasEnded=false';
  //     final response = await http.get(url).then(
  //       (response) {
  //         if (response.statusCode < 200 ||
  //             response.statusCode >= 400 ||
  //             json == null) {
  //           //handle exceptions
  //           throw ExceptionHandler(response.body);
  //         } else {
  //           final data = json.decode(response.body) as Map<String, dynamic>;
  //           if (data.length > 0) {
  //             result = true;
  //           } else {
  //             result = false;
  //           }
           
  //         }
  //       },
  //     );
  //     return result;
  //   // }
  // }

  Future<void> endJourney(String id, Journey updatedJourney) async {
    final journeyIndex = _journeys.indexWhere((Journey) => Journey.id == id);
    if (journeyIndex >= 0) {
      final url =
          "https://flutter-database-78c33.firebaseio.com/journeys/$id.json?auth=$token";
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'hesEnded': true
            //merges with existing values on server
            // 'name': newBike.name,
            // 'model': newBike.model,
            // 'isActive': newBike.isActive //this line causes null error on detail view..!!
            // 'imageUrl': newBike.imageUrl,
          },
        ),
      );
      if (response.statusCode >= 400) {
        print(response.statusCode);
        print("$response");
        // userBikes.insert(bikeIndex, Journey); //keep Journey if the delete did not work, optimistic updating
        // notifyListeners();
        throw ExceptionHandler('Cannot update Journey.');
      }
      _journeys[journeyIndex] = updatedJourney;
      print('updatedJourney :${response.toString()}');
      notifyListeners();
    } else {
      print('did not update');
    }
  }

}