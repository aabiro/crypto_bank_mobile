import 'package:flutter/material.dart';
import 'package:flutter_app/models/bike.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:http/src/response.dart';
import '../helpers/bike_helper.dart';
import 'bike_detail_view.dart';
import 'qr_scan.dart';

class BikeList extends StatefulWidget {
  // BikeList(this.bikes);
  static final routeName = '/bike_list';

  @override
  _BikeListState createState() => _BikeListState();
}

class _BikeListState extends State<BikeList> {
  //get bikes from the db from the user id
  List<Bike> bikes = [
    Bike(1, "bike 1", 1919, true, true, false, "Active"),
    Bike(2, "bike 2", 1919, true, true, false, "Deactivated")
  ];

  @override
  Widget build(BuildContext context) {
    // Future<void> bikes2 = BikeHelper.getBikes();
    // print(bikes2);

    Future<void> bikes2 = BikeHelper.getBike();
    // print(bikes2);

    // bikes =
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Constants.mainColor,
            title: new Text(
              'My Bikes',
              style: TextStyle(),
            ),
            leading: IconButton(icon: Icon(Icons.arrow_back),
              onPressed:() => Navigator.popAndPushNamed(context, '/home'),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _showDialog();
                  }),
            ]),
        body: SizedBox(
          height: mediaQuery.size.height,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ListView(
              children: bikes.map(
                (b) {
                  return Padding(
                    padding: EdgeInsets.all(0),
                    // child: Hero(
                    //   tag: "bike3",
                    child: Card(
                      child: InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed(BikeDetailScreen.routeName),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          height: 85,
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Text(
                                      b.model.toString(),
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
                                      b.imageUrl.toString(),
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Icon(Icons.error_outline,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // ),
                  );
                  // return Card(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: <Widget>[
                  //       Container(
                  //         margin: EdgeInsets.symmetric(
                  //           vertical: 10,
                  //           horizontal: 15,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           border: Border.all(
                  //             color: Constants.accentColor,
                  //             width: 2,
                  //           ),
                  //         ),
                  //         padding: EdgeInsets.all(10),
                  //         child: Text(
                  //           b.model.toString(),
                  //           style: TextStyle(
                  //               color: Colors.blueGrey,
                  //               fontWeight: FontWeight.w800,
                  //               fontSize: 20),
                  //         ),
                  //       ),
                  //       Align(
                  //         //only show if they are lenders
                  //         alignment: Alignment.centerRight,
                  //         child: SizedBox(
                  //             width: mediaQuery.size.width * 0.15,
                  //             height: mediaQuery.size.height * 0.15,
                  //             child: Icon(
                  //               Icons.error_outline,
                  //               color: Colors.redAccent,
                  //               semanticLabel: 'Alert!',
                  //             )),
                  //       ),
                  //       Align(
                  //         //only show if they are lenders
                  //         alignment: Alignment.topRight,
                  //         child: SizedBox(
                  //           width: mediaQuery.size.width * 0.15,
                  //           height: mediaQuery.size.height * 0.15,
                  //           child: IconButton(
                  //               //my location ocation searching gps fixed gps not fixed error error outline
                  //               icon: Icon(Icons.arrow_forward),
                  //               color: Constants.accentColor,
                  //               onPressed: () {
                  //                 Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       fullscreenDialog: true,
                  //                       builder: (context) => BikeDetailScreen(),
                  //                       maintainState: false),
                  //                 );
                  //               }),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
              ).toList(),
            ),
          ),
        ));
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Have a GivnGo lock?",
            style:
                TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.w800),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OutlineButton(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  onPressed: () {
                    Navigator.popAndPushNamed(context, QrScan.routeName, arguments: QrScan(true));
                  },
                  child: Text(
                    "Activate Ride",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
                OutlineButton(
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Cancel",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
