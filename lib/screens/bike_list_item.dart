import 'package:flutter/material.dart';
import '../providers/bike.dart';
import 'bike_detail_view.dart';

class BikeListItem extends StatefulWidget {
  final Bike bike;
  BikeListItem(this.bike);

  @override
  _BikeListItemState createState() => _BikeListItemState();
}

class _BikeListItemState extends State<BikeListItem> {

  @override
  Widget build(BuildContext context) {
    Color textColor;
    (widget.bike.isActive) == true ? textColor = Colors.blueGrey : textColor = Colors.grey[350];
    return Padding(
      padding: EdgeInsets.all(0),
      child: Card(
        child: InkWell(
          onTap: () => 
           Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => BikeDetailScreen(widget.bike),
                      maintainState: false),),
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 85,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        widget.bike.name.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: textColor,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        (widget.bike.isActive) == true ? 'Active' : 'Deactivated',
                        style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Icon(Icons.error_outline, color: Colors.red),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Icon(Icons.arrow_forward, color: textColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}