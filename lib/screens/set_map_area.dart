import 'dart:async';
import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart' as prefix0;
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
  var radius = 7;

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
                        height: mediaQuery.size.height * 0.5,
                        child: Column(
                          children: <Widget>[
                            GoogleMap(
                          onMapCreated: (GoogleMapController mc) {
                            MapsHelper.setStyle(mc, context);
                            _controller.complete(mc);
                          },
                          // initialCameraPosition: widget.initalLocation,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(widget.initalLocation.lat,
                                  widget.initalLocation.lng),
                              zoom: 8),
                        ),

                        ],
                        ),
                    ),
                        
                  ),
                  Row(children: <Widget>[
                     SizedBox(height: 10,),
                          Text(
                              'Center on the map the area \nyou would like to service',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20
                                  ),
                            ),
                  ],),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                          SizedBox(height: 10,),
                          Text(
                              'Area Radius ',
                              // textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20
                                  ),
                            ),
                           Text(
                          radius.toString(),
                          style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20            
                              ),
                        ),

                        Text(
                          ' km',
                          style: TextStyle(
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20
                              ),
                        ),
                      ],
                    ),
                    
                  ),
                  Row(
                    children: <Widget>[
                      prefix0.SliderTheme(
                        data: prefix0.SliderTheme.of(context).copyWith(
                          activeTrackColor: Constants.accentColor,
                          thumbColor: Constants.accentColor,
                          overlayColor: Constants.accentColor,
                          thumbShape: prefix0.RoundSliderThumbShape(
                            enabledThumbRadius: 15.0,
                          ),
                          overlayShape: prefix0.RoundSliderOverlayShape(
                            overlayRadius: 30.0
                          )

                        ),
                      child: prefix0.Slider(
                        value: radius.toDouble(),
                        min: 1.0,
                        max: 120.0,
                        activeColor: Constants.mainColor,
                        inactiveColor: Colors.grey,
                        onChanged: (double newVal) {
                          setState(() {
                            radius = newVal.round();
                          });
                        } ,
                      )
                      ),
                      OutlineButton(
              // minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              onPressed: () {
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
                    ],
                  )
                ]
                )
                )
                );
  }
}
