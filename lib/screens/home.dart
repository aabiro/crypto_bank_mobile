import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/maps_helper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/drawer_menu.dart';
import 'package:location/location.dart';
import './camera_screen.dart';
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
  GoogleMapController mc;
  Completer<GoogleMapController> _controller = Completer();
  LatLng toronto = new LatLng(43.65, -79.38);
  Future<LocationData> userLocation = _getGPSLocation();
  CameraPosition torontoCP = CameraPosition(
    //make this userlocation
    target: LatLng(43.65, -79.38),
    zoom: 13,
    // bearing: 45.0,
    // tilt: 45.0
  );

  static Future<LocationData> _getGPSLocation() async {
    final gpsLoc = await Location().getLocation();
    print('user///////////////////////////////////////////////////////');
    print(gpsLoc.latitude);
    print(gpsLoc.longitude);
    return gpsLoc;
  }

  void moveToLocation() {
    mc.animateCamera(CameraUpdate.newCameraPosition(torontoCP));
  }

  void mapCreated(controller) {
    setState(() {
      mc = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    Future<LocationData> userLocation;
    List<Marker> markers = [];
    List<Marker> userMarker;

    @override
    void initState() {
      super.initState();
      // userLocation = MapsHelper.getUserLocation();
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
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                  CameraPosition(target: LatLng(43.65, 79.38), zoom: 7),
              markers: Set.from(markers),
            ),
          ),
          
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: mediaQuery.size.width * 0.15,
              height: mediaQuery.size.height * 0.15,
              child: IconButton(
                  //my location ocation searching gps fixed gps not fixed error error outline
                  icon: Icon(Icons.gps_fixed),
                  color: Constants.accentColor,
                  // tooltip: 'Increase volume by 10',
                  onPressed: moveToLocation),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: mediaQuery.size.width * 0.15,
              height: mediaQuery.size.height * 0.15,
              child: IconButton(
                  //my location ocation searching gps fixed gps not fixed error error outline
                  icon: Icon(Icons.error_outline),
                  color: Constants.accentColor,
                  // tooltip: 'Increase volume by 10',
                  onPressed: moveToLocation),
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
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)),
                      icon: Icon(Icons.center_focus_strong),
                      textColor: Colors.white,
                      color: Constants.accentColor,
                      label: const Text('Scan to Ride',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 20)),
                      onPressed: () {
                        // Navigator.pushNamed(context, '/camera');
                        Navigator.of(context).pushNamed(QrScan.routeName);
                      },
                    )),
              )),
        ],
      ),
    );
  }
}
