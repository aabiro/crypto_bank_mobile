
import 'package:flutter/foundation.dart';
// import 'package:provider/provider.dart';

class Bike with ChangeNotifier {
  String id;
  int userId;
  int qrCode; // image?
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

  Bike(
    [this.id, 
    this.name,
    // this.model, 
    // this.userId, 
    // this.isAvailable, 
    // this.isVerified, 
    this.isActive, 
    // this.imageUrl
    ]
  );

  void toggleActive() {
      isActive = !isActive;
      notifyListeners();
  }

    String get _id {
    return id;
  }

    int get ownerId {
    return ownerId;
  }
}