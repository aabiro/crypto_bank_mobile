import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/theme/constants.dart' as Constants;

//http requests for user

class UserHelper {  
  static String getUserData() {}

  // final body = "{\"username\":\"$username\", \"password\": \"$password\", \"grant_type\": \"password\"}";

  static Future<void> login(String body, BuildContext context) async {
    final url = "http://10.0.2.2:8888/auth/token";
    // final storage = new FlutterSecureStorage();
    // String accessToken = await storage.read(key: "access_token");

    // final clientID = "com.example.flutter_app";
    // final mysecret = "mysecret";
    final clientCredentials = Constants.clientCredentials;
    try {
      await http
          .post(url,
              headers: {
                "Content-Type": "application/x-www-form-urlencoded",
                "Authorization": "Basic $clientCredentials"
              },
              body: body)
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode >= 400 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          print(json.decode(response.body));
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
            final storage = new FlutterSecureStorage();
            var data = json.decode(response.body);
            //  var accesstoken = data["authorization"]["access_token"];
            await storage.write(
                key: "access_token",
                value: data["authorization"]["access_token"]);
            await storage.write(key: "id", value: data["id"].toString());
            print(response);
            //  User(username);
            Navigator.pushNamed(context, '/home');
          }
        });
      } catch (e) {
        print(e);
      }
    }
}
