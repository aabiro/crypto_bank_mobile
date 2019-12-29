import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'dart:async';
import '../screens/login.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class Authentication with ChangeNotifier {
  static String fireBaseApi = Constants.fbAPI;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String loginUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$fireBaseApi";
  String registerUrl =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$fireBaseApi";
  String _accessToken;
  DateTime _expiry;
  String _userId;
  String _email;
  String _displayName;
  Timer _signInTimer;
  String _photoUrl;

  bool get isLoggedIn {
    return accessToken != null;
  }

  String get userId {
    return _userId;
  }

  String get email {
    return _email;
  }

  String get displayName {
    return _displayName;
  }

  String get accessToken {
    if (_expiry != null &&
        _expiry.isAfter(DateTime.now()) &&
        _accessToken != null) {
      return _accessToken;
    } else {
      return null;
    }
  }

  void showError(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Error'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  Future<void> getUserData() async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:lookup?key=$fireBaseApi";
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'idToken': _accessToken,
            'email': _email
          },
        ),
      ).then((response) {
        var data = json.decode(response.body);
        // var msg = data['error']['message'];
        print('getting user data...');
        _email = data["email"];
        _displayName = data["displayName"];
        _photoUrl = data["photoUrl"];
      });
    } catch (e) {
      print('cannot get userdata: $e');
    }
  }

  Future<void> updateEmail(String newEmail, BuildContext context) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$fireBaseApi";
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'idToken': _accessToken,
            'email': newEmail,
            'returnSecureToken': true
          },
        ),
      ).then((response) {
        var data = json.decode(response.body);
        var msg = data['error']['message'];

        if (response.statusCode < 200 || response.statusCode >= 400 || json == null) {
          //handle exceptions
          // var data = json.decode(response.body);
          // var msg = data['error']['message'];
          // showError(msg, context);
          showError(msg, context);
          throw new Exception(response.body);
        } else {
          print('user updated: $data');

           _email = data["email"];
          _accessToken = data["idToken"];

          // print(data);
        }
       
        

      });
    } catch (e) {
      print('email not reset: $e');
    }

  }

  Future<void> resetPassword(String newPassword) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$fireBaseApi";
    try {
      await http.post(
        url,
        body: json.encode(
          {
            'idToken': _accessToken,
            'password': newPassword,
            'returnSecureToken': true
          },
        ),
      );
    } catch (e) {
      print('password not reset: $e');
    }
  }

  Future<void> updateUser(String displayName, String photUrl) async {
//     idToken	string	A Firebase Auth ID token for the user.
//      displayName	string	User's new display name.
//      photoUrl	string	User's new photo url.
//      deleteAttribute	List of strings	List of attributes to delete, "DISPLAY_NAME" or "PHOTO_URL". This will nullify these values.
//      returnSecureToken	boolean	Whether or not to return an ID and refresh token.
    final String url =
        "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$fireBaseApi";
    try {
      await http
          .post(registerUrl,
              body: json.encode({
                'idToken': accessToken,
                'displayName': displayName,
                'returnSecureToken': true
              }))
          .then((http.Response response) async {
          var data = json.decode(response.body);
          // var msg = data['error']['message'];
          print('update all : $data');
          // _displayName = ;
        final int statusCode = response.statusCode;
        print('update status $statusCode');
        if (statusCode < 200 || statusCode >= 400 || json == null) {
          //handle exceptions
          // var data = json.decode(response.body);
          // var msg = data['error']['message'];
          // showError(msg, context);

          throw new Exception(response.body);
        } else {
          var data = json.decode(response.body);
          var msg = data['displayName'];
          print('user updated');
           print('new displayName : $msg');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> register(
      String email, String password, BuildContext context) async {
    // final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // )).user;
    // print('user created');
    // print(user.uid);

    try {
      // FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await http
          .post(registerUrl,
              body: json.encode({
                'email': 'aaryn@gmail.com',
                'password': 'password22',
                'returnSecureToken': true
              }))
          .then((http.Response response) async {
        final int statusCode = response.statusCode;
        print(statusCode);
        if (statusCode < 200 || statusCode >= 400 || json == null) {
          //handle exceptions weak password invalid email/password etc.
          // throw new Exception(response.body);
          var data = json.decode(response.body);
          var msg = data['error']['message'];
          showError(msg, context);
          throw new Exception(response.body);
        } else {
          print(json.decode(response.body));
          // final storage = new FlutterSecureStorage();
          var data = json.decode(response.body);
          // await storage.write(
          //     key: "access_token",
          //     value: data["access_token"]);
          // await storage.write(key: "id", value: data["id"].toString());
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    } catch (e) {
      print(e);
    }
    // print(json.decode(response.body));
  }

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      await http
          .post(loginUrl,
              body: json.encode({
                'email': 'neww@gmail.com',
                'password': 'test10',
                'returnSecureToken': true,
                // 'email': 'aaryn@gmail.com',
                // 'password': 'password22',
                // 'returnSecureToken': true,
                // 'email': email,
                // 'password': password,
                // 'returnSecureToken': true
              }))
          .then((http.Response response) async {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode >= 400 || json == null) {
          var data = json.decode(response.body);
          var msg = data['error']['message'];
          showError(msg, context);
          throw new Exception(response.body);
        } else {
          print(json.decode(response.body));
          // final storage = new FlutterSecureStorage();
          var data = json.decode(response.body);
          _accessToken = data["idToken"];
          _userId = data["localId"];
          _email = data["email"];
          _expiry = DateTime.now()
              .add(Duration(seconds: int.parse(data['expiresIn'])));
          _logoutAuto(context);
          notifyListeners();
          // await storage.write(
          //     key: "access_token",
          //     value: data["access_token"]);
          // await storage.write(key: "id", value: data["id"].toString());
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void logout(BuildContext context) {
    _expiry = null;
    _accessToken = null;
    _userId = null;
    if (_signInTimer != null) {
      _signInTimer.cancel();
      _signInTimer = null;
    }
    print('hit logout');
    notifyListeners();
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  void _logoutAuto(BuildContext context) {
    if (_signInTimer != null) {
      _signInTimer.cancel();
    }
    _signInTimer = Timer(
        Duration(seconds: _expiry.difference(DateTime.now()).inSeconds), () {
      logout(context);
    });
  }
}