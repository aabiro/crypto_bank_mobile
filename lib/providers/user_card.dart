import 'package:flutter/foundation.dart';

class UserCard with ChangeNotifier {
  String id;
  String userId;
  String name;
  int number;
  String expiry;
  int securityCode;
  bool isDefault;

  UserCard({
    this.userId,
    this.name,
    this.number,
    this.expiry,
    this.securityCode,
    this.isDefault, 
    this.id,
  });

  String get _userId {
    return userId;
  }

  String get _id {
    return id;
  }

  String get _expiry {
    return expiry;
  }

  int get _securityCode {
    return securityCode;
  }

  bool get _isDefault {
    return isDefault;
  }

  void toggleDefault() {
      isDefault = !isDefault;
      notifyListeners();
  }
}
