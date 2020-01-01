import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/screens/set_map_area.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/detail_fields.dart';
import 'package:provider/provider.dart';
import '../providers/bikes.dart';
import '../providers/bike.dart';

import 'alert_screen.dart';
import 'bike_list.dart';
import 'edit_bike.dart';
import 'set_map_area.dart';

class BikeDetailScreen extends StatefulWidget {
  static final routeName = '/bike_detail';
  final Bike bike;
  BikeDetailScreen(this.bike);

  @override
  _BikeDetailScreenState createState() => _BikeDetailScreenState();
}

class _BikeDetailScreenState extends State<BikeDetailScreen> {
  bool isSwitched = false;

  buildDetailFields(String title, String text) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueGrey,
                    fontFamily: 'OpenSans'),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              child: Text(
                text,
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.blueGrey,
                    fontFamily: 'OpenSans'),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ]);
  }

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
    print('yesss ${widget.bike.id}');
    // final BikeDetailScreen args = ModalRoute.of(context).settings.arguments;
    // final bike = Provider.of<Bikes>(context).findById(args.bikeId);

    // listen: false, //does not change on changeNotifier, check if does on update and open screen

    return Scaffold(
      body: SingleChildScrollView(
        //add to Scroll whole screen
        child: Column(
          children: <Widget>[
            new AppBar(
              centerTitle: true,
              backgroundColor: Color(0xff673AB7),
              title: new Text(
                widget.bike.name,
                // planType,
                style: TextStyle(),
              ),
            ),
            SizedBox(
              // height: 200,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 0),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Column(children: <Widget>[
                    Text(
                      'Details',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                    SizedBox(height: 10.0),
                    // buildInputField(nameController, 'Name'),
                    DetailField("Name", widget.bike.name),
                    SizedBox(height: 15.0),
                    // buildInputField(modelController, 'Model'),
                    DetailField("Type",
                        widget.bike.model == null ? "None" : widget.bike.model),
                    // SizedBox(height: 15.0),
                    // buildInputField(conditionController, 'Condition'),
                    // SizedBox(height: 0.30),
                    SizedBox(height: 10),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(7.0),
                      color: Color(0xff2196F3),
                      child: MaterialButton(
                        minWidth: mediaQuery.size.width / 3,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => EditBike(widget.bike.id),
                                maintainState: false),
                          );
                        },
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
                  ]),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: FlatButton.icon(
                icon: Icon(
                  Icons.pin_drop,
                  color: Colors.blueGrey,
                ),
                label: Text(
                  "Set Allowable Riding Area",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(SetMapAreaScreen.routeName);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Text(
                'Alerts',
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(10),

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

                      // height: 85,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
            ),
            SizedBox(
              // height: 200,
              // width: double.infinity,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.center,

                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text(
                                  'Deactivate',
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: 'OpenSans',
                                  ),
                                ),
                              ),
                              Switch(
                                value: widget.bike.isActive != null
                                    ? !widget.bike.isActive
                                    : true,
                                onChanged: (value) {
                                  setState(() {
                                    print(widget.bike.isActive);
                                    widget.bike.toggleActive();
                                    print(widget.bike.isActive);
                                    isSwitched = widget.bike.isActive;
                                  });
                                  Provider.of<Bikes>(context)
                                      .updateBike(widget.bike.id, widget.bike);
                                },
                                activeTrackColor: Constants.mainColor,
                                activeColor: Constants.optionalColor,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              // width: double.infinity,
              child: OutlineButton(
                // minWidth: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                onPressed: () {
                  // print(bike);
                  print(widget.bike.id);
                  _showDialog(widget.bike.id);
                },
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
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void _showDialog(String id) {
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
                  onPressed: () async {
                    try {
                      // print(id);

                      await Provider.of<Bikes>(context).deleteBike(id);
                    } catch (error) {
                      print(error);
                      print('deleting failed'); //handle this error
                      // Scaffold.of(context).showSnackBar(Snackbar(content:
                      // Text('Deleteing failed!')));
                    }
                    // Navigator.of(context).pop();

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
