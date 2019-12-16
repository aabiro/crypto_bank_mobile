import 'dart:async';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../helpers/maps_helper.dart';
import '../models/place.dart';
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

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    Completer<GoogleMapController> _controller = Completer();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.mainColor,
        title: new Text(
          'GivnGo',
          style: TextStyle(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'map',
              child: Container(
                  height: mediaQuery.size.height * 0.8,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController mc) {
                      MapsHelper.setStyle(mc, context);
                      _controller.complete(mc);
                    },
                    // initialCameraPosition: widget.initalLocation,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(widget.initalLocation.lat,
                            widget.initalLocation.lng),
                        zoom: 8),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
