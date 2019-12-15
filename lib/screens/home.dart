import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/drawer_menu.dart';
import 'package:location/location.dart';
import './camera_screen.dart';
import 'package:flutter_app/components/app_bar.dart';


class MapScreen extends StatefulWidget {
  @override
  MapScreenState createState() {
    return MapScreenState();
  }
}

class MapScreenState extends State<MapScreen> {
  
  // Future<void> _getGPSLocation() async {
  //   final gps_loc = await Location().getLocation();
  //   print(gps_loc.latitude);
  //   print(gps_loc.longitude);
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Constants.mainColor,
        title: new Text(
          'GivnGo',
          style: TextStyle(),
        ),
      ),
      drawer: MenuDrawer(),
      body: new FlutterMap(
          options: new MapOptions(
              center: new LatLng(42.983612, -81.249725), minZoom: 10.0),
          layers: [
            new TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            new MarkerLayerOptions(markers: [
              new Marker(
                  width: 45.0,
                  height: 45.0,
                  point: new LatLng(42.983612, -81.249725),
                  builder: (context) => new Container(
                        child: IconButton(
                          icon: Icon(Icons.location_on),
                          color: Constants.optionalColor,
                          iconSize: 45.0,
                          onPressed: () {
                            print('Marker tapped');
                          },
                        ),
                      ))
            ])
          ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: 
      // Material(
      // elevation: 5.0,
      // borderRadius: BorderRadius.circular(30.0),
      // color: Constants.accentColor,
      // child: 
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
                Navigator.pushNamed(context, '/camera');
              },
            )
      ),
      
            
      
    //     MaterialButton(
    //     minWidth: MediaQuery.of(context).size.width/2,
    //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    //     onPressed: () {
    //        Navigator.pushNamed(context, '/camera');
    //     },
        
    //     child: Text("Scan to Ride",
    //       textAlign: TextAlign.center,
    //       style: TextStyle(
    //         fontSize: 18,
    //         fontWeight: FontWeight.w700,
    //         color: Colors.white,
    //       ),
    //     ),
    //   ),
    // ),
       
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.center_focus_strong),
      //   onPressed: () {
      //     Navigator.pushNamed(context, '/camera');
      //   },
      // ),
    );
  }
  //   return new FlutterMap(
  //     options: new MapOptions(
  //       center: new LatLng(51.5, -0.09),
  //       zoom: 13.0,
  //     ),
  //     layers: [
  //       new TileLayerOptions(
  //         urlTemplate: "https://api.tiles.mapbox.com/v4/"
  //             "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
  // "mapbox://styles/aabiro/ck46sjhgh38m91cohk4r9tvj2" "pk.eyJ1IjoiYWFiaXJvIiwiYSI6ImNrMWsydGk3bTAzYnQzY28xMGptZXZib28ifQ.s6yg-6eFTAAYJ9wB96FPiA"
  //         additionalOptions: {
  //           'accessToken': '<PUT_ACCESS_TOKEN_HERE>',
  //           'id': 'mapbox.streets',
  //         },
  //       ),
  //       new MarkerLayerOptions(
  //         markers: [
  //           new Marker(
  //             width: 80.0,
  //             height: 80.0,
  //             point: new LatLng(51.5, -0.09),
  //             builder: (ctx) =>
  //             new Container(
  //               child: new FlutterLogo(),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

}
