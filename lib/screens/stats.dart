import 'package:flutter/material.dart';



class StatsScreen extends StatelessWidget {
  static const routeName = '/stats';

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Completed", () => 5);
    dataMap.putIfAbsent("In Progress", () => 3);
    // dataMap.putIfAbsent("Xamarin", () => 2);
    // dataMap.putIfAbsent("Ionic", () => 2);

    return Container(
      
    );
  }
}