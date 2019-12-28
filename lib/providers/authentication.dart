import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/theme/constants.dart' as Constants;
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';


class Authentication with ChangeNotifier {
  static String fireBaseApi = Constants.fbAPI;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String loginUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$fireBaseApi";
  String registerUrl = "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$fireBaseApi";
  String _accessToken;
  DateTime _expiry;
  String _userId;

  bool get isLoggedIn {
    return accessToken != null;
  }

  String get userId {
    return _userId;
  }

  String get accessToken {
    if (_expiry != null && _expiry.isAfter(DateTime.now()) && _accessToken != null) {
      return _accessToken;
    } else {
      return null;
    }
  }
 
  void showError(String message, BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(title: Text('Error'), content: Text(message), actions: <Widget>[
      FlatButton(child: Text('Okay'),onPressed: () {Navigator.of(context).pop();},)
    ],));
  }

  Future<void> register(String email, String password, BuildContext context) async {
    // final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: password,
    // )).user;
    // print('user created');
    // print(user.uid);

      try {
        // FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await http.post(registerUrl, body: json.encode({    
              'email': 'aaryn@gmail.com', 
              'password': 'password22', 
              'returnSecureToken': true
            }
          )
          
          )
          .then((http.Response response) async {
        final int statusCode = response.statusCode;
        print(statusCode);
        if (statusCode < 200 || statusCode >= 400 || json == null) {
          //handle exceptions weak password invalid email/password etc.
          // throw new Exception(response.body);
          showError(response.body, context);
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

  Future<void> login(String email, String password, BuildContext context) async {
    try {
      await http.post(loginUrl, body: json.encode({    
              'email': 'aaryn@gmail.com', 
              'password': 'password22', 
              'returnSecureToken': true
            }
          ))
          .then((http.Response response) async {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode >= 400 || json == null) {
          showError(response.body, context);
          throw new Exception("Error while fetching data");
        } else {
          print(json.decode(response.body));
          // final storage = new FlutterSecureStorage();
          var data = json.decode(response.body);
          _accessToken = data["idToken"];
          _userId = data["localId"];
          _expiry = DateTime.now().add(Duration(seconds: int.parse(data['expiresIn'])));
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
}