import 'package:flutter/cupertino.dart';

class Journey with ChangeNotifier {
  String id;
  DateTime startTime; //use with time.now for the timer / price
  DateTime endTime;
  int dayOfTheWeek; //?
  String bikeId;
  String userId;
  String bikeOwnerId;
  //gps stuff ie start location/end location for the distance? should the owner see the bike in use,
  // or just use time avg dist?
  String distance;
  bool hasEnded;

  Journey({
    this.id,
    this.startTime,
    this.endTime,
    this.dayOfTheWeek,
    this.bikeId,
    this.userId,
    this.bikeOwnerId,
    this.distance,
    this.hasEnded
  });

  String get myId {
    return id;
  }

  String get myUserId {
    return userId;
  }

  String get myDistance {
    return distance;
  }

  DateTime get mystartTime {
    return startTime;
  }

  DateTime get myendTime {
    return endTime;
  }
}