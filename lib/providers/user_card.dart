import 'package:flutter/foundation.dart';

class UserCard with ChangeNotifier {
  String id;
  String userId;
  String name;
  String number;
  String expiry;
  String securityCode;
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

  String get _securityCode {
    return securityCode;
  }

  String get lastFourDigits {
    // return "XXXX";
    // return number; //needs numberr
    return number == null || number == "" || number.length < 4 ? 'XXXX' : number.substring(number.length - 4, number.length);
  }

  bool get _isDefault {
    return isDefault;
  }

  void toggleDefault() {
      isDefault = !isDefault;
      notifyListeners();
  }
}
