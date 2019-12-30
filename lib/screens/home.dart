import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/maps_helper.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/drawer_menu.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import './camera_screen.dart';
import '../providers/bikes.dart';
import './qr_scan.dart';
import 'package:flutter_app/components/app_bar.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  MapScreenState createState() {
    return MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {
  var _init = true;
  var _isLoading = false;
  GoogleMapController mc;
  Completer<GoogleMapController> _controller = Completer();
  LatLng toronto = LatLng(43.65, -79.38);
  Future<LocationData> userLocation = _getGPSLocation();
  List<Bikes> userBikes;
  CameraPosition torontoCP = CameraPosition(
    //make this userlocation
    target: LatLng(43.65, -79.38),
    zoom: 13,
    // bearing: 45.0,
    // tilt: 45.0
  );
  List<Marker> markers = [];
  List<Marker> userMarker = [];

  static Future<LocationData> _getGPSLocation() async {
    final gpsLoc = await Location().getLocation();
    print('user///////////////////////////////////////////////////////');
    print(gpsLoc.latitude);
    print(gpsLoc.longitude);
    return gpsLoc;
  }

  void moveToUserLocation() async {
    //will be user location
    final gpsLoc = await Location().getLocation();
    CameraPosition userUocation = CameraPosition(
      // target: LatLng(gpsLoc.latitude, gpsLoc.longitude),  //works
      target: LatLng(43.65, -79.38),
      zoom: 13,
      // bearing: 45.0,
      // tilt: 45.0
    );
    mc.animateCamera(CameraUpdate.newCameraPosition(userUocation));
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

  void mapCreated(controller) {
    setState(() {
      mc = controller;
    });
  }

  @override
  void initState() {
    var user;
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(Duration.zero).then((_) {
        Provider.of<Bikes>(context).getBikes();
      });
      Future.delayed(Duration.zero).then((_) {
        user = Provider.of<Authentication>(context);
      });
      Future.delayed(Duration.zero).then((_) {
        Provider.of<Bikes>(context)
            .getUserBikes(
                // user.accessToken,
                // user.userId
                )
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      });
      // userLocation = MapsHelper.getUserLocation(); //auto updating?

      //
      markers.add(Marker(
          markerId: MarkerId('mymarker'),
          draggable: false,
          onTap: () {
            print('clicked marker');
          },
          position: toronto //LatLng(43.65, -79.38)
          ));

      userMarker.add(Marker(
        markerId: MarkerId('userMarker'),
        draggable: true,
        onTap: () {
          print('clicked user marker');
        },
        // position:
        // position: LatLng(userLocation.latitude, userLocation.longitude)
      ));
      print(markers);
    }
    _init = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    String dropdownValue;
    var bikesProv = Provider.of<Bikes>(context);
    List<Bike> userBikes = bikesProv.userBikes;
    var array = userBikes.map((ub) => ub.bikeName).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 5,
        backgroundColor: Constants.mainColor,
        title: Text(
          'GivnGo',
          style: TextStyle(),
        ),
      ),
      drawer: MenuDrawer(),
      body: Stack(
        children: <Widget>[
          SizedBox(
            child: GoogleMap(
              onMapCreated: (GoogleMapController mc) {
                mapCreated(mc);
                MapsHelper.setStyle(mc, context);
                // _controller.complete(mc);
              },
              initialCameraPosition:
                  CameraPosition(target: LatLng(40.6281, 14.4850), zoom: 5),
              markers: Set.from(markers),
              // myLocationEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: DropdownButton<String>(
              hint: Text(
                'Find My Ride',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w800,
                    fontSize: 18),
              ),
              value: dropdownValue,
              icon: Icon(Icons.location_on, color: Constants.mainColor),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w800,
                  fontSize: 18),
              underline: Container(
                height: 2,
                color: Constants.mainColor,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
                Bike bike = bikesProv.findByName(newValue);
                moveToBikeLocation(bike.lat, bike.lng);
              },

              // items: <String>['Bike 1', 'Bike 2', 'Bmx', 'Mntn B']
              items: array.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: mediaQuery.size.width * 0.15,
              height: mediaQuery.size.height * 0.15,
              child: IconButton(
                  //my location ocation searching gps fixed gps not fixed error error outline
                  icon: Icon(
                    Icons.gps_fixed,
                    size: 30,
                  ),
                  color: Constants.accentColor,
                  // tooltip: 'Increase volume by 10',
                  onPressed: moveToUserLocation),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: mediaQuery.size.width * 0.15,
              height: mediaQuery.size.height * 0.15,
              child: IconButton(
                  //my location ocation searching gps fixed gps not fixed error error outline
                  icon: Icon(
                    Icons.error_outline,
                    size: 30,
                  ),
                  color: Constants.accentColor,
                  // tooltip: 'Increase volume by 10',

                  onPressed: moveToUserLocation),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: SizedBox(
                width: mediaQuery.size.width * 0.7,
                height: mediaQuery.size.height * 0.1,
                child: RaisedButton.icon(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0)),
                  icon: Icon(
                    Icons.center_focus_strong,
                    size: 25,
                  ),
                  textColor: Colors.white,
                  color: Constants.accentColor,
                  label: const Text('Scan to Ride',
                      style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  onPressed: () {
                    // Navigator.pushNamed(context, '/camera');
                    Navigator.of(context)
                        .pushNamed(QrScan.routeName, arguments: QrScan(false));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
