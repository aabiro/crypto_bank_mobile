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
  List<Journey> _userJourneys = [];
  List<Journey> _ownerJourneys = [];
  Journey _userJourney;

  Journeys([this.token, this.userId, this._journeys]);

  List<Journey> get journeys {
    return _journeys;
  }

  List<Journey> get allJourneys {
    return _allJourneys;
  }

  List<Journey> get userJourneys {
    return _userJourneys;
  }

  List<Journey> get ownerJourneys {
    return _ownerJourneys;
  }

  Journey get userJourney {
    return _userJourney;
  }

  set userJourney(userJourney) {
    this._userJourney = userJourney;
  }

  Future<Journey> addJourney(Journey journey) {
    var newJourney;
    final url =
        'https://capstone-addb0.firebaseio.com/journeys.json?auth=$token';
    http
        .post(url,
            body: json.encode({
              'startTime': journey.startTime.toString(),
              'endTime': null,
              'dayOfTheWeek':
                  journey.dayOfTheWeek.toString(), //update on trip end
              'userId': userId,
              'bikeId': journey.bikeId, //passed in by journey
              'bikeOwnerId': journey.bikeOwnerId,
              'distance': 0,
              'hasEnded': false,
              'tripTotal': null,
              'tripLength': null
            }))
        .then(
      (response) {
        var data = json.decode(response.body);
        // print('response $data');
        newJourney = Journey(
          id: json.decode(response.body)["name"],
          startTime: data['startTime'],
          endTime: data['endTime'],
          dayOfTheWeek: data['dayOfTheWeek'],
          userId: userId,
          bikeId: data['bikeId'],
          bikeOwnerId: data['bikeOwnerId'],
          distance: data['distance'],
          hasEnded: data['hasEnded'],
          tripTotal: data['tripTotal'],
          tripLength: data['tripLength'],
        );
        // print('newJourney : $newJourney');
        allJourneys.add(
            newJourney);
        notifyListeners();
        
      },
    );
    return newJourney;
  }

  Future<Journey> getCurrentUserJourney() async {
    var userJourney;
    var url;
    url =
        'https://capstone-addb0.firebaseio.com/journeys.json?auth=$token&orderBy="userId"&equalTo="$userId"&hasEnded="false"';
    final response = await http.get(url).then(
      (response) {
        if (response.statusCode < 200 ||
            response.statusCode >= 400 ||
            json == null) {
          throw ExceptionHandler(response.body);
        } else {
          final data = json.decode(response.body) as Map<String, dynamic>;
          print('data length: ${data.length}');
          print('get current journey data: $data');
          if (data.length > 0 && data != null) {
            // for (var key in data.keys) print(key);
            // for (var value in data.values) print(value);
            for (var entry in data.entries) {
              // final userJourneyIndex = _allJourneys.indexWhere((journey) => journey.id == entry.key);
              // userJourney = _allJourneys[userJourneyIndex];
              userJourney = Journey(
                  id: entry.key,
                  startTime: DateTime.parse(entry.value['startTime']),
                  endTime: null, //no endTime yet
                  dayOfTheWeek: null, //update on trip end
                  userId: entry.value['userId'],
                  bikeId: entry.value['bikeId'],
                  bikeOwnerId: entry.value['bikeOwnerId'],
                  distance: entry.value['distance'].toString(),
                  tripTotal: entry.value['tripTotal'],
                  tripLength: entry.value['tripLength'],
                  hasEnded: entry.value['hasEnded'],
                  );
              _allJourneys.add(userJourney);
            }
          } else {
            userJourney = null;
          }
        }
      },
    );
    return userJourney;
  }

  Future<void> getJourneys({bool asLender = false}) async {
    //all ended journeys
    final List<Journey> journeysLoaded = [];
    var url;
    if (asLender == true) {
      url =
          'https://capstone-addb0.firebaseio.com/journeys.json?auth=$token&orderBy="bikeOwnerId"&equalTo="$userId"';
    } else {
      url =
          'https://capstone-addb0.firebaseio.com/journeys.json?auth=$token&orderBy="userId"&equalTo="$userId"';
      final response = await http.get(url).then((response) {
        if (response.statusCode < 200 ||
            response.statusCode >= 400 ||
            json == null) {
          throw ExceptionHandler(response.body);
        } else {
          final data = json.decode(response.body) as Map<String, dynamic>;
          print(data);
          if (data.length > 0 && data != null) {
            for (var key in data.keys) print(key);
            for (var value in data.values) print(value);
            for (var entry in data.entries) {
              if (entry.value['hasEnded'] == true) {
                //make sure it has endTime
                journeysLoaded.add(
                  Journey(
                    id: entry.key,
                    startTime: DateTime.parse(entry.value['startTime']),
                    endTime: DateTime.parse(entry.value['endTime']),
                    dayOfTheWeek: entry.value['dayOfTheWeek'],
                    userId: entry.value['userId'],
                    bikeId: entry.value['bikeId'],
                    bikeOwnerId: entry.value['bikeOwnerId'],
                    distance: entry.value['distance'].toString(),
                    tripTotal: entry.value['tripTotal'],
                    tripLength: entry.value['tripLength'],
                    hasEnded: entry.value['hasEnded'],
                  ),
                );
              }
              if (asLender == true) {
                _ownerJourneys = journeysLoaded;
              } else {
                _userJourneys = journeysLoaded;
              }
              notifyListeners();
            }
          }
        }
      });
    }
  }

  Future<void> updateJourney(String id, Journey updatedJourney) async {
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
            'dayOfTheWeek': updatedJourney.dayOfTheWeek,
            'tripTotal': updatedJourney.tripTotal,
            'tripLength': updatedJourney.tripLength,
          },
        ),
      );
      if (response.statusCode >= 400) {
        print(response.statusCode);
        // userJourneys.insert(journeyIndex, Journey); //keep Journey if the delete did not work, optimistic updating
        // notifyListeners();
        throw ExceptionHandler('Cannot update Journey.');
      }
      allJourneys[journeyIndex] = updatedJourney;
      print('updated Journey :${response.toString()}');
      notifyListeners();
    } else {
      print('did not update');
    }
  }
}
