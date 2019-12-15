import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SetLocation extends StatefulWidget {
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  String map_image;

  Future<void> _getGPSLocation() async {
    final gpsLoc = await Location().getLocation();
    print(gpsLoc.latitude);
    print(gpsLoc.longitude);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: <Widget>[
        Container(
          height: mediaQuery.size.height * 0.2,
          width: double.infinity,
          child: map_image == null ? Text('No Location', textAlign: TextAlign.center) : Image.network(map_image, fit: BoxFit.cover, width: double.infinity),
          ),
          Row(children: <Widget>[
            FlatButton.icon(icon: Icon(Icons.navigation,), label: Text("Select Area"), onPressed: _getGPSLocation,) 
          ],),
          Row(children: <Widget>[

          ],)
      ],
      
    );
  }
}