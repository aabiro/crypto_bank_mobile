import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

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
    final url = 'https://capstone-addb0.firebaseio.com/journeys.json?auth=$token';
    http
        .post(url,
            body: json.encode({
              'startTime': journey.startTime.toString(),
              'endTime': null,
              'dayOfTheWeek': journey.dayOfTheWeek.toString(),//update on trip end
              'userId': userId,
              // 'bikeId': journey.bikeId, //passed in by journey
              'distance': 0,
              'hasEnded':false
            }))
        .then(
      (response) {
        var data = json.decode(response.body);
        print('response $data');  
        final newJourney = Journey(
          id: json.decode(response.body)["name"], //'name' is the id of the bike
          startTime: data['startTime'],
          endTime: data['endTime'],
          dayOfTheWeek: data['dayOfTheWeek'],//update on trip end
          userId: data['userId'],
          // bikeId: data.bikeId, //passed in by journey
          distance: data['distance'],
          hasEnded: false
        );
        print('newJourney id: ${newJourney.id}');
        print('newJourney userId: ${newJourney.userId}');
        _journeys.add(newJourney); //called on null ??
        notifyListeners();
      },
    );
  }

}