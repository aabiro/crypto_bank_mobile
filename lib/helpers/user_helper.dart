import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/theme/constants.dart' as Constants;

//http requests for user

class UserHelper {
  static String getUserData() {}

  static Future<void> login(String body, BuildContext context) async {
    final url = "http://10.0.2.2:8888/auth/token";
    final clientCredentials = Constants.clientCredentials;
    try {
      await http
          .post(url,
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Basic $clientCredentials"
              },
              body: body)
          .then((http.Response response) async {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode >= 400 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          print(json.decode(response.body));
           final storage = new FlutterSecureStorage();
          var data = json.decode(response.body);
          await storage.write(
              key: "access_token",
              value: data["access_token"]);
          await storage.write(key: "id", value: data["id"].toString());
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> register(String body, BuildContext context) async {
    final url = "http://10.0.2.2:8888/register";
    final clientCredentials = Constants.clientCredentials;
    try {
      await http
          .post(url,
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Basic $clientCredentials"
              },
              body: body)
          .then((http.Response response) async {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          var data = json.decode(response.body);
          await  Constants.storage.write(
              key: "access_token",
              value: data["access_token"]);
          await  Constants.storage.write(key: "id", value: data["id"].toString());
          print(response);
          //  User(username);
          Navigator.pushNamed(context, '/home');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> updateUser(String body) async { //not tested
    String accessToken = await  Constants.storage.read(key: "access_token");
    String userId = await  Constants.storage.read(key: "id");
    final url = "http://10.0.2.2:8888/users/$userId";
    try {
      await http
          .put(url,
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $accessToken"
              },
              body: body)
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          print(json.decode(response.body));
          // Navigator.pushNamed(context, '/register/upload');
        }
        //go to next step
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> logout(BuildContext context) async {
    String accessToken = await Constants.storage.read(key: "access_token");
    final url = "http://10.0.2.2:8888/logout";
    try {
      await http
          .delete(url,
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $accessToken"
              },
              )
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          print(json.decode(response.body));
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
        }
      });
    } catch (e) {
      print(e);
      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    }
  }
}
