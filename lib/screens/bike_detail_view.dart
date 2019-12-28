import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/set_location.dart';
import 'package:provider/provider.dart';
import '../providers/bikes.dart';

import 'alert_screen.dart';
import 'bike_list.dart';

class BikeDetailScreen extends StatefulWidget {
  static final routeName = '/bike_detail';
  final String bikeId;
  BikeDetailScreen(this.bikeId);

  @override
  _BikeDetailScreenState createState() => _BikeDetailScreenState();
}

class _BikeDetailScreenState extends State<BikeDetailScreen> {
  bool isSwitched = false;

  buildInputField(TextEditingController controller, String hintText) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        obscureText: false,
        controller: controller,
        decoration: InputDecoration(
          labelText: hintText,
          hintStyle: TextStyle(
            color: Color(0xff2196F3),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final nameController = TextEditingController();
    final modelController = TextEditingController();
    final conditionController = TextEditingController();
    final BikeDetailScreen args = ModalRoute.of(context).settings.arguments;
    final bike = Provider.of<Bikes>(
      context,
      // listen: false, //does not change on changeNotifier, check if does on update and open screen
      ).findById(args.bikeId);
    return Scaffold(
      body: SingleChildScrollView(
        //add to Scroll whole screen
        child: Column(
          children: <Widget>[
            new AppBar(
              centerTitle: true,
              backgroundColor: Color(0xff673AB7),
              title: new Text(
                'bike.name',
                // planType,
                style: TextStyle(),
              ),
            ),
            SizedBox(
              // height: 200,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Alerts',
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Comfortaa',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          // child: Hero(
                          //   tag: "bike",
                            child: Card(
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: true,
                                        builder: (context) => AlertScreen(),
                                        maintainState: false)),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: double.infinity,
                                  height: 85,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              child: Text(
                                                '12 Messages',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: Colors.blueGrey,
                                                    fontFamily: 'OpenSans',
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20),
                                              )),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 0),
                                            child: Icon(Icons.arrow_forward,
                                                color: Colors.blueGrey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          // ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                'Detail',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
            
            buildInputField(nameController, 'Name'),
            SizedBox(height: 15.0),
            buildInputField(modelController, 'Model'),
            SizedBox(height: 15.0),
            buildInputField(conditionController, 'Condition'),
            SizedBox(height: 15.0),
            // SizedBox(height: 20),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(7.0),
              color: Color(0xff2196F3),
              child: MaterialButton(
                minWidth: mediaQuery.size.width / 3,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {},
                child: Text("Edit",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w900)),
                // color: Color(),
                // style: style.copyWith(
                // //     color: Colors.white,
                // fontWeight: FontWeight.bold)
                // ),
              ),
            ),
            SizedBox(
              // height: 200,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'Deactivate',
                                style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'Comfortaa',
                                ),
                              ),
                            ),
                            Switch(
                              value: !bike.isActive,
                              onChanged: (value) {
                                setState(() {
                                  print(bike.isActive);
                                  bike.toggleActive();
                                  print(bike.isActive);
                                  isSwitched = bike.isActive;                        
                                });
                              },
                              activeTrackColor: Constants.mainColor,
                              activeColor: Constants.optionalColor,
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: SetLocation(),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: OutlineButton(
                  // minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  onPressed: _showDialog,
                  child: Text(
                    "Remove from Platform",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Constants.mainColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

   void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(
            "Are you sure you want to remove this ride?",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => BikeList(),
                            maintainState: false));
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
