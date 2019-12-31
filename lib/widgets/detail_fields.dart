import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/models/income_chart.dart';
import 'package:flutter/material.dart';

class DetailField extends StatelessWidget {
  String title;
  String text;
  DetailField(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 15, color: Colors.blueGrey),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Divider(
              color: Colors.blueGrey,
            ),
          ),
        ]);
  }
}
