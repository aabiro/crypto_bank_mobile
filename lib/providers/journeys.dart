import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../models/exception_handler.dart';

import 'journey.dart';

class Journeys with ChangeNotifier {
  String token;
  String userId;
  List<Journey> _journeys = [];
  List<Journey> _allJourneys = [];

  Journeys([this.token, this.userId, this._journeys]);

  List<Journey> get journeys {
    return _journeys;
  }

  List<Journey> get allJourneys {
    return _allJourneys;
  }

  void addJourney(Journey journey) {
    // print('token add journey $token');
    final url = 'https://capstone-addb0.firebaseio.com/journeys.json?auth=$token';
    http
        .post(url,
            body: json.encode({
              'startTime': journey.startTime.toString(),
              'endTime': null,
              'dayOfTheWeek': journey.dayOfTheWeek.toString(),//update on trip end
              'userId': userId,
              // 'bikeId': journey.bikeId, //passed in by journey
              'bikeId': null,
              'distance': 0,
              'hasEnded': false
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
          userId: userId,
          bikeId: data['bikeId'], //passed in by journey
          distance: data['distance'],
          hasEnded: data['hasEnded']
        );
        print('newJourney : ${newJourney}');
        // print('newJourney userId: ${newJourney.userId}');
        allJourneys.add(newJourney); //journeys would be called on null ??
        notifyListeners();
      },
    );
  }

  Future<Journey> getUserJourney() async {
    Journey journey;
    var url;
      url =
          'https://capstone-addb0.firebaseio.com/journeys.json?auth=$token&orderBy="userId"&equalTo="$userId"&hasEnded=false';
      final response = await http.get(url).then(
        (response) {
          if (response.statusCode < 200 ||
              response.statusCode >= 400 ||
              json == null) {
            throw ExceptionHandler(response.body);
          } else {
            final data = json.decode(response.body) as Map<String, dynamic>;
            if (data.length > 0) {
              print('get user journey: $data');
              journey = Journey(
                    id: json.decode(response.body)["name"], //'name' is the id of the Journey
                    startTime: data['startTime'],
                    endTime: data['endTime'],
                    dayOfTheWeek: data['dayOfTheWeek'],//update on trip end
                    userId: userId,
                    bikeId: data['bikeId'], //passed in by journey
                    distance: data['distance'],
                    hasEnded: data['hasEnded']
              );
            } else {
              journey = null;
            }
          }
        },
      );
      print('returning journey ${journey.toString()}');
      return journey;
  }

  Future<void> updateJourney(String id, Journey updatedJourney) async {
    //no id !!
    // final id = '-M0ApdmGVDnVFIJy8F6i';
    //endJourney
    final journeyIndex = _allJourneys.indexWhere((journey) => journey.id == id);
    if (journeyIndex >= 0) {
      final url =
          "https://capstone-addb0.firebaseio.com/journeys/$id.json?auth=$token";
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'hasEnded': updatedJourney.hasEnded,
            'endTime': updatedJourney.endTime.toString(),
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
      allJourneys[journeyIndex] = updatedJourney;
      print('updatedJourney :${response.toString()}');
      notifyListeners();
    } else {
      print('did not update');
    }
  }

}