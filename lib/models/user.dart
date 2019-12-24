import 'package:flutter_app/providers/bike.dart';

class User {
  int id;
  String username;
  String firstname;
  String lastname;
  String email;
  String birthdate;
  String country;
  String city;
  String street;
  String address;
  String zipcode;
  String addressInfo;
  String formattedAddress;
  String hashedpassword;
  String salt;
  String accesstoken;
  String userType;
  bool active;
  List<Bike> bikes;

  /// Setters
  /// 
  set userId(int id) {
    this.id = id;
  }
  
  set userName(String userName) {
    this.username = userName;
  }

  set userFirstname(String userFirstname) {
    this.firstname = userFirstname;
  }

  set userLastname(String userLastname) {
    this.lastname = userLastname;
  }

  set userEmail(String userEmail) {
    this.email = userEmail;
  }

  set userBirthdate(String userBirthdate) {
    this.birthdate = userBirthdate;
  }

  set userAccessToken(String userAccessToken) {
    this.accesstoken = userAccessToken;
  }

  /// Getters
  ///
  String get userName {
    return username;
  }

  String get userFirstname {
    return firstname;
  }

  String get userLastname {
    return lastname;
  }

  String get userEmail {
    return email;
  }

  String get userBirthdate {
    return birthdate;
  }

  String get userAccessToken {
    return accesstoken;
  }

  List<Bike> get bikeList {
    return bikes;
  }



  /// Constructors
  ///

  User(String userName) {
    this.username = userName;
  }

  /// Functions
  /// 

  void addBike(Bike b) {
    this.bikes.add(b);
  }

  void removeBike(Bike b) {
    this.bikes.remove(b); //also deactivate the bike
  }

}
