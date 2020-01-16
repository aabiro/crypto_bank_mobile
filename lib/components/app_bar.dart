import 'package:flutter/material.dart';

class GnGAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(0xff98c1d9),
      title: new Text(
        'GivnGo',
        style: TextStyle(),
      ),
    );
  }
}
