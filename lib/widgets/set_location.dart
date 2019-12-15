import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../helpers/maps_helper.dart';
import '../screens/set_map_area.dart';

class SetLocation extends StatefulWidget {
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  String map_image;
  LocationData coordinates;

  Future<void> _getGPSLocation() async {
    final gpsLoc = await Location().getLocation();
    
    final gpsImageUrl = MapsHelper.locationImageUrlTemplate(gpsLoc.latitude, gpsLoc.longitude);
    // final gpsImageUrl = MapsHelper.locationImageUrl(gpsLoc.latitude, gpsLoc.longitude);

    setState(() {
      map_image = gpsImageUrl;
      coordinates = gpsLoc;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getGPSLocation();
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        Hero(
          tag: 'map',
          child:
            Container(
              height: mediaQuery.size.height * 0.4,
              width: double.infinity,
              child: map_image == null ? Text('No Location', textAlign: TextAlign.center) : Image.network(map_image, fit: BoxFit.cover, width: double.infinity),
            ),
          ),     
          Row(children: <Widget>[
            FlatButton.icon(icon: Icon(Icons.navigation,), label: Text("Set Allowable Riding Area"), onPressed: () {
              // Navigator.of(context).pushNamed(SetMapAreaScreen.routeName);
              Navigator.of(context).push(MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => SetMapAreaScreen(isEditing: false,
                  // initalLocation: 
                  //   coordinates.latitude, 
                  //   coordinates.longitude 
                    )
                )
              );
            },
            ) 
          ],),
          Row(children: <Widget>[

          ],)
      ],
      
    );
  }
}