import 'package:flutter/material.dart';

class EmptyListItem extends StatefulWidget {
  final String text;
  EmptyListItem([this.text]);

  @override
  _EmptyListItemState createState() => _EmptyListItemState();
}

class _EmptyListItemState extends State<EmptyListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        "No ${widget.text} yet.",
        style: TextStyle(
            fontSize: 20, color: Colors.blueGrey, fontFamily: 'OpenSans'),
        textAlign: TextAlign.left,
      ),
    );
  }
}
