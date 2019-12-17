import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/screens/activation_complete.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/theme/constants.dart' as Constants;

//http requests for bike

class BikeHelper {

  static Future<void> addBike(String body, BuildContext context) async {
    final url = "http://10.0.2.2:8888/bikes";
    final clientCredentials = Constants.clientCredentials;
    print('clientCredentials:');
    print(clientCredentials);
    try {
      await http
          .post(url,
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Basic $clientCredentials"
              },
              body: body)
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode >= 400 || json == null) {
          print(response);
          throw new Exception("Error while fetching data for Add Bike Route");
        } else {
          print(json.decode(response.body));
           Navigator.of(context).pushReplacementNamed(ActivationCompleteScreen.routeName);
        }
      });
    } catch (e) {
      print(e);
    }
  }

    static Future<void> getBikes(String body, BuildContext context) async {
    final url = "http://10.0.2.2:8888/bikes";
    final clientCredentials = Constants.clientCredentials;
    print('clientCredentials:');
    print(clientCredentials);
    try {
      await http
          .get(url,
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Basic $clientCredentials"
              })
          .then((http.Response response) {
        final int statusCode = response.statusCode;

        if (statusCode < 200 || statusCode >= 400 || json == null) {
          print(response);
          throw new Exception("Error while fetching data for Bike Route");
        } else {
          print(json.decode(response.body));
          // Navigator.pushReplacementNamed(context, '/home');
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
