import 'package:flutter/material.dart';
import 'package:flutter_app/screens/bike_list.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;

import 'become_lender.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
        return Scaffold(
        body: SingleChildScrollView(
      //add to Scroll whole screen
      child: Column(
        children: <Widget>[
          new AppBar(
            centerTitle: true,
            backgroundColor: Constants.mainColor,
            title: new Text(
              'Settings',
              style: TextStyle(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: EdgeInsets.all(20),
          //   child: Text(
          //     'Settings',
          //     textAlign: TextAlign.left,
          //     style: TextStyle(
          //       color: Colors.blueGrey,
          //       fontSize: 30,
          //       fontWeight: FontWeight.w800,
          //       fontFamily: 'Comfortaa',
          //     ),
          //   ),
          // ),
          // Padding(
          //   padding: EdgeInsets.all(20),
          //   child: Hero(
          //     tag: "credit",
          //     child: Card(
          //       child: InkWell(
          //         onTap: () => Navigator.of(context).pushNamed(BikeList.routeName),
          //         child: Container(
          //           padding: EdgeInsets.all(20),
          //           width: double.infinity,
          //           height: 85,
          //           child: Column(
          //             children: <Widget>[
          //               Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   crossAxisAlignment: CrossAxisAlignment.center,
          //                   children: <Widget>[
          //                     Padding(
          //                         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          //                         child: Text(
          //                           'Manage My Rides',
          //                           textAlign: TextAlign.left,
          //                           style: TextStyle(
          //                               color: Colors.blueGrey,
          //                               fontFamily: 'OpenSans',
          //                               fontWeight: FontWeight.bold,
          //                               fontSize: 20),
          //                         )),
          //                     Padding(
          //                       padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
          //                       child: Icon(Icons.arrow_forward,
          //                           color: Colors.blueGrey),
          //                     )
          //                   ]),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          
          Padding(
            padding: EdgeInsets.all(20),
            child: OutlineButton(
              // minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              onPressed: _showDialog,
              child: Text(
                "Delete Account",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    ),);
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
          title: new Text(
            "Are you sure you want to delete your account?",
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
                    // Navigator.popAndPushNamed(context, QrScan.routeName, arguments: QrScan(true));
                  },
                  child: Text(
                    "Yes",
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

// class SettingsScreen extends StatelessWidget {
//   static const routeName = '/settings';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       //add to Scroll whole screen
//       child: Column(
//         children: <Widget>[
//           new AppBar(
//             centerTitle: true,
//             backgroundColor: Constants.mainColor,
//             title: new Text(
//               'Settings',
//               style: TextStyle(),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           // Padding(
//           //   padding: EdgeInsets.all(20),
//           //   child: Text(
//           //     'Settings',
//           //     textAlign: TextAlign.left,
//           //     style: TextStyle(
//           //       color: Colors.blueGrey,
//           //       fontSize: 30,
//           //       fontWeight: FontWeight.w800,
//           //       fontFamily: 'Comfortaa',
//           //     ),
//           //   ),
//           // ),
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: Hero(
//               tag: "credit",
//               child: Card(
//                 child: InkWell(
//                   onTap: () => Navigator.of(context).pushNamed(BikeList.routeName),
//                   child: Container(
//                     padding: EdgeInsets.all(20),
//                     width: double.infinity,
//                     height: 85,
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                                   child: Text(
//                                     'Manage My Rides',
//                                     textAlign: TextAlign.left,
//                                     style: TextStyle(
//                                         color: Colors.blueGrey,
//                                         fontFamily: 'OpenSans',
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 20),
//                                   )),
//                               Padding(
//                                 padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
//                                 child: Icon(Icons.arrow_forward,
//                                     color: Colors.blueGrey),
//                               )
//                             ]),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
          
//           Padding(
//             padding: EdgeInsets.all(20),
//             child: OutlineButton(
//               // minWidth: MediaQuery.of(context).size.width,
//               padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
//               onPressed: () {
//                 // Navigator.pushNamed(context, '/delete');
//               },
//               child: Text(
//                 "Delete Account",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Colors.red,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 16),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ));
//   }
// }
