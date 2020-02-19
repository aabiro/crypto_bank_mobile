import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/providers/bikes.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../helpers/maps_helper.dart';
import '../models/place.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/services.dart' show rootBundle;

class SetMapAreaScreen extends StatefulWidget {
  static const routeName = '/map_area';
  final Place initalLocation;
  final bool isEditing;

  //need to use phone gps again
  SetMapAreaScreen(
      {this.initalLocation = const Place(lat: 37.422, lng: -122.084),
      this.isEditing = false});

  @override
  _SetMapAreaScreenState createState() => _SetMapAreaScreenState();
}

class _SetMapAreaScreenState extends State<SetMapAreaScreen> {
  // void _setStyle(GoogleMapController mc) async {
  //   String val = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
  //   mc.setMapStyle(val);
  // }
  GoogleMapController mc;
  var radius = 7;

  void mapCreated(controller) {
    setState(() {
      mc = controller;
    });
  }

  void moveToBikeLocation(double lat, double lng) {
    mc.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 18,
        ),
      ),
    );
  }

  void moveToUserLocation() async {
    //will be user location
    final gpsLoc = await Location().getLocation();
    CameraPosition userUocation = CameraPosition(
      // target: LatLng(gpsLoc.latitude, gpsLoc.longitude),  //works as london
      target: LatLng(43.65, -79.38), //toronto
      // target: LatLng(43.0095971,-81.2759223), //london
      zoom: 13,
      // bearing: 45.0,
      // tilt: 45.0
    );
    mc.animateCamera(CameraUpdate.newCameraPosition(userUocation));
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue;
    GoogleMapController mc;
    var bikesProv = Provider.of<Bikes>(context);
    final mediaQuery = MediaQuery.of(context);
    Completer<GoogleMapController> _controller = Completer();
    List<Bike> userBikes = bikesProv.userBikes;
    var array = userBikes.map((ub) => ub.bikeName).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.mainColor,
        title: Text(
          'Givngo',
          style: TextStyle(),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: mediaQuery.size.height / 1.7,
            // width: mediaQuery.size.width,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Stack(
                children: <Widget>[
                  SizedBox(
                    height: mediaQuery.size.height,
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController mc) {
                        mapCreated(mc);
                        MapsHelper.setStyle(mc, context);
                        _controller.complete(mc);
                      },
                      myLocationButtonEnabled: false,
                      mapToolbarEnabled: false,
                      // initialCameraPosition: widget.initalLocation,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(widget.initalLocation.lat,
                              widget.initalLocation.lng),
                          zoom: 8),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: SizedBox(
                      // width: mediaQuery.size.width * 0.8,
                                        child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  // height: 20,
                                  child: AutoSizeText(
                                    'Center on the map the area you \nwould like to service.\nHighlight with a circle or polygon.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

             
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: DropdownButton<String>(
                            hint: Text(
                              'Find My Ride',
                              style: TextStyle(
                                  color: Colors.grey[410],
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15),
                            ),
                            value: dropdownValue,
                            icon: Icon(Icons.location_on,
                                color: Constants.optionalColor),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontFamily: 'OpenSans',
                                fontWeight: FontWeight.w800,
                                fontSize: 18),
                            underline: Container(
                              height: 2,
                              color: Constants.optionalColor,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                              Bike bike = bikesProv.findByName(newValue);
                              MapsHelper.moveToBikeLocation(mc, bike.lat, bike.lng);
                            },

                            // items: <String>['Bike 1', 'Bike 2', 'Bmx', 'Mntn B']
                            items:
                                array.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
     Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: mediaQuery.size.width * 0.2,
              height: mediaQuery.size.height * 0.12,
              child: IconButton(
                  //my location ocation searching gps fixed gps not fixed error error outline
                  icon: Icon(
                    Icons.gps_fixed,
                    size: 30,
                  ),
                  color: Constants.accentColor,
                  // tooltip: 'Increase volume by 10',
                  onPressed: (){
                    moveToUserLocation();
                  }),
            ),
          ),


                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: RaisedButton(
                        color: Colors.white,
                        // minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Navigator.pushNamed(context, '/delete');
                        },
                        child: Text(
                          "Done",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Constants.mainColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),

                  //aligns of buttons here
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Column(
                      children: <Widget>[
                        Text(
                      'Area Radius:',
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                    ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                      radius.toString(),
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w800,
                          fontSize: 18),
                    ),
                                        Column(
                        children: <Widget>[
                      Text(
                        ' km',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
                      ),
                      ],
                    ),
                      ]
                    ), 
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                          activeTrackColor: Constants.accentColor,
                          thumbColor: Constants.accentColor,
                          overlayColor: Constants.accentColor,
                          thumbShape: RoundSliderThumbShape(
                            enabledThumbRadius: 15.0,
                          ),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 30.0)),
                      child: Slider(
                        value: radius.toDouble(),
                        min: 1.0,
                        max: 120.0,
                        activeColor: Constants.mainColor,
                        inactiveColor: Colors.grey,
                        onChanged: (double newVal) {
                          setState(
                            () {
                              radius = newVal.round();
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    OutlineButton(
                      // minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      onPressed: () {
                        // Navigator.pushNamed(context, '/delete');
                      },
                      child: Text(
                        "Draw Polygon",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Constants.mainColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
