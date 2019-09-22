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

  // set user_address_form(String country, String city, String street,
  //     String address, String zipcode, String addressInfo) {
  //   this.country = country;
  //   this.city = city;
  //   this.street = street;
  //   this.address = address;
  //   this.zipcode = zipcode;
  //   this.addressInfo = addressInfo;
  // }

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

  /// Constructors
  ///

  User(String userName) {
    this.username = userName;
  }

  /// Functions
  /// 
  
  //   factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     id: json["id"];
  //     username: json["username"];
  //     firstname: json["firstname"];;
  //     lastname: json["lastname"];
  //     email: json["email"];
  //     birthdate: json["birthdate"];
  //     country: json["country"];
  //     city: json["city"];
  //     street: json["street"];
  //     address: json["address"];
  //     zipcode: json["zipcode"];
  //     )
  // }
  
}
