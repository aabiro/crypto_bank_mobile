import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../screens/login.dart';
import '../config_reader.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class Authentication with ChangeNotifier {
  static String fireBaseApi = ConfigReader.getSecretKey("fbAPI");
  // static String fireBaseApi = Secrets.fbAPI;
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
  bool _isOnTrip;

  bool get isOnTrip {
    return _isOnTrip;
  }

  set isOnTrip(bool isOnTrip) {
    this._isOnTrip = isOnTrip;
  }

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

  String get photoUrl {
    return _photoUrl;
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
          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
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
      await http
          .post(
        url,
        body: json.encode(
          {'idToken': _accessToken, 
          'email': _email,
          },
        ),
      )
          .then((response) {
        var data = json.decode(response.body);
        // var msg = data['error']['message'];
        print('getting user data...');
        _email = data["email"];
        _displayName = data["displayName"];
        _photoUrl = data["photoUrl"];
        notifyListeners();
        return data;
      });
    } catch (e) {
      print('cannot get userdata: $e');
    }
  }

  Future<void> updateEmail(String newEmail, BuildContext context) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:update?key=$fireBaseApi";
    try {
      await http
          .post(
        url,
        body: json.encode(
          {
            'idToken': _accessToken,
            'email': newEmail,
            'returnSecureToken': true
          },
        ),
      )
          .then((response) {
        var data = json.decode(response.body);
        var msg = data['error']['message'];

        if (response.statusCode < 200 ||
            response.statusCode >= 400 ||
            json == null) {
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
          notifyListeners();
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
      notifyListeners();
    } catch (e) {
      print('password not reset: $e');
    }
  }

  void toggleIsOnTrip() {
      if(_isOnTrip == null) {
        //
      }
      _isOnTrip = !_isOnTrip;
      notifyListeners();
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
          .post(url,
              body: json.encode({
                'idToken': _accessToken,
                'displayName': displayName,
                // 'photoUrl': _photoUrl,
                'deleteAttribute': "PHOTO_URL",
                'returnSecureToken': true
              }))
          .then((http.Response response) async {
        var data = json.decode(response.body);
        // var msg = data['error']['message'];
        print('update all : $data');
        // _displayName = ;
        final int statusCode = response.statusCode;
        print('update user email status  $statusCode');
        if (statusCode < 200 || statusCode >= 400 || json == null) {
          //handle exceptions
          // var data = json.decode(response.body);
          // var msg = data['error']['message'];
          // showError(msg, context);

          throw new Exception(response.body);
        } else {
          var data = json.decode(response.body);
          // var msg = data['displayName'];
          _displayName = data['displayName'];
          print('user updated');
          print('new displayName : $_displayName');
          notifyListeners();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void initiateFacebookLogin(BuildContext context) async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        //  await facebookLogin.logInWithReadPermissions(['email']);
        await facebookLogin.logIn(['email']);
        // .then((response) {
        //   _accessToken = response.accessToken;//facebookLoginResult']['accessToken'].token;
        // });
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        // onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");

        final url =
            "https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${facebookLoginResult.accessToken.token}";
        var graphResponse = await http.get(url);

        var profileData = json.decode(graphResponse.body);
        print(profileData.toString());

        _photoUrl = profileData['picture']['data']['url'];
        _displayName = profileData['name'];
        _email = profileData['email'];

        var facebookAccessToken = facebookLoginResult.accessToken.token;
        var providerId = 'facebook.com';
        var requestUri = ConfigReader.getSecretKey("requestUri");
        // var requestUri = Secrets.requestUri;
        final firebaseOAuthUrl =
            "https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp?key=$fireBaseApi";
        
        try {
          await http
              .post(
            firebaseOAuthUrl,
            body: json.encode(
              {
                'requestUri': requestUri,
                'postBody':
                 'access_token=$facebookAccessToken&providerId=$providerId',
                'returnSecureToken': true,
                'returnIdpCredential': true
              },
            ),
          )
              .then(
            (response) async {
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
                  _userId = data["localId"];
                  _photoUrl = profileData['picture']['data']['url'];
                  _displayName = data['firstName'];
                  _email = data['email'];
                  _accessToken = data['idToken'];
                  _isOnTrip = null;
                  _expiry = DateTime.now()
                    .add(Duration(seconds: int.parse(data['expiresIn'])));
                   _logoutAuto(context);
                print('user updated');
                // print('new displayName : $msg');
                notifyListeners();
                Navigator.pushReplacementNamed(
                    context, '/home'); //should move to home page here
              }
            },
          );
        } catch (e) {
          print(e);
        }

        notifyListeners();
        Navigator.pushReplacementNamed(context, '/home');
        break;
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
                'email': email,
                'password': password,
                'returnSecureToken': true
                // 'email': 'myem@gmail.com',
                // 'password': 'test10',
                // 'returnSecureToken': true
                // 'email': 'aaryn@gmail.com',
                // 'password': 'password22',
                // 'returnSecureToken': true
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
          _accessToken = data["idToken"];
          _userId = data["localId"];
          _email = data["email"];
          _isOnTrip = false;
          _expiry = DateTime.now()
              .add(Duration(seconds: int.parse(data['expiresIn'])));
          _logoutAuto(context);
          notifyListeners();
          // await storage.write(
          //     key: "access_token",
          //     value: data["access_token"]);
          // await storage.write(key: "id", value: data["id"].toString());
          // Navigator.pushReplacementNamed(context, '/home');
          Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
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
          _isOnTrip = false;
          _expiry = DateTime.now()
              .add(Duration(seconds: int.parse(data['expiresIn'])));
          _logoutAuto(context);
          notifyListeners();
          // await storage.write(
          //     key: "access_token",
          //     value: data["access_token"]);
          // await storage.write(key: "id", value: data["id"].toString());
          // Navigator.pushReplacementNamed(context, '/home');
          Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
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
    _isOnTrip = null;
    _photoUrl = null;
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
