import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/maps_helper.dart';
import 'package:flutter_app/models/place.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as prefix0;
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
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
  Completer<GoogleMapController> _controller = Completer();
  prefix0.LatLng ll = new prefix0.LatLng(43.65, -79.38);

  // Future<void> _getGPSLocation() async {
  //   final gps_loc = await Location().getLocation();
  //   print(gps_loc.latitude);
  //   print(gps_loc.longitude);
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

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
      body: 
      //blue snazzy
      GoogleMap(
        onMapCreated: (GoogleMapController mc) {
          MapsHelper.setStyle(mc, context);
          _controller.complete(mc);
        },
        initialCameraPosition: CameraPosition(
            target: ll,
            zoom: 7),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: 
      SizedBox(
        width: mediaQuery.size.width * 0.7,
        height: mediaQuery.size.height * 0.1,
        child: RaisedButton.icon(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0)),
                icon: Icon(Icons.center_focus_strong),
                textColor: Colors.white,
                color: Constants.accentColor,
                label: const Text('Scan to Ride', style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  )
                ),
                onPressed: () {
                  // Navigator.pushNamed(context, '/camera');
                  Navigator.of(context).pushNamed(QrScan.routeName);
                },
            )
      ),
    );
  }
}
