
import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';

class Bike with ChangeNotifier {
  String id;
  String userId;
  String qrCode; // image?
  String name;
  String model;
  double lat;
  double lng;
  int passengerId;
  bool isVerified; // other users have verified
  bool isActive;
  bool isAvailable;
  bool isOutOfOrder;
  bool outOfBounds;
  String imageUrl;
  double totalIncomeGenerated;

  //need daily income model to update for each ride

  Bike({
    this.id,
    this.name,
    this.isActive, 
    this.userId,
    this.qrCode,
    this.model,
    this.lat,
    this.lng,
    this.passengerId,
    this.isVerified, // other users have verified
    this.isAvailable,
    this.isOutOfOrder,
    this.outOfBounds,
    this.imageUrl,
    this.totalIncomeGenerated = 0
  }
  );

  void toggleActive() {
      isActive = !isActive;
      notifyListeners();
  }

  String get bikeId {
    return id;
  }

   String get bikeName {
    return name;
  }

    String get _userId {
    return userId;
  }
}