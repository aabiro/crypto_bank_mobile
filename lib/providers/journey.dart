import 'package:flutter/cupertino.dart';

class Journey with ChangeNotifier {
  String id;
  DateTime startTime;
  DateTime endTime;
  int dayOfTheWeek;
  String bikeId;
  String userId;
  String bikeOwnerId;
  String distance;
  bool hasEnded;
  double tripTotal;
  double tripLength;

  Journey({
    this.id,
    this.startTime,
    this.endTime,
    this.dayOfTheWeek,
    this.bikeId,
    this.userId,
    this.bikeOwnerId,
    this.distance,
    this.hasEnded,
    this.tripTotal,
    this.tripLength
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