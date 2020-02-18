import 'package:flutter/foundation.dart';

class UserCard with ChangeNotifier {
  String id;
  String userId;
  String name;
  String number;
  String expiry;
  String securityCode;
  String lastFourDigits;
  bool isDefault;

  UserCard({
    this.userId,
    this.name,
    this.number,
    this.expiry,
    this.securityCode,
    this.lastFourDigits,
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

  String get _lastFourDigits {
    return number == null || number == "" || number.length < 4 ? 'XXXX' : number.substring(number.length - 4);
  }

  bool get _isDefault {
    return isDefault;
  }

  void toggleDefault() {
      isDefault = !isDefault;
      notifyListeners();
  }
}
