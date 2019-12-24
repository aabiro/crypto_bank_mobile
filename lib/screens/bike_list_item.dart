import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bike.dart';
import 'bike_detail_view.dart';

class BikeListItem extends StatelessWidget {
  // final String id;
  // final String name;
  // final bool isActive;
  // final String imageUrl;

  // BikeListItem(this.id, this.name, this.isActive, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final bike = Provider.of<Bike>(context);
    // final BikeListItem args =
    //     ModalRoute.of(context).settings.arguments;
    // final bId = args.bikeId;
    return Padding(
      padding: EdgeInsets.all(0),
      // child: Hero(
      //   tag: "bike3",
      child: Card(
        child: InkWell(
          onTap: () => Navigator.of(context).pushNamed(
            BikeDetailScreen.routeName,
            arguments: BikeDetailScreen(bike.id),
          ),
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
                        bike.name.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        bike.isActive == true ? 'Active' : 'Deactivated',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Icon(Icons.error_outline, color: Colors.red),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Icon(Icons.arrow_forward, color: Colors.blueGrey),
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
