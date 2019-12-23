import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:path/path.dart';

const GOOGLE_API_KEY = 'AIzaSyDoid-JXRFRIZ1XO819NyuYaCISf7ljXFo';


class MapsHelper {
  static String locationImageUrl(double lat, double lng){
    return "https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7C$lat,$lng&key=$GOOGLE_API_KEY";
  }

  static String locationImageUrlTemplate(double lat, double lng, int zoom){
    return "https://maps.googleapis.com/maps/api/staticmap?key=$GOOGLE_API_KEY&center=$lat,$lng&zoom=$zoom&format=png&maptype=roadmap&style=element:labels.text%7Ccolor:0x000000%7Cvisibility:simplified&style=element:labels.text.fill%7Chue:0xff0000&style=element:labels.text.stroke%7Ccolor:0xff0000%7Cvisibility:simplified&style=feature:administrative%7Celement:geometry.fill%7Ccolor:0xe16d6d&style=feature:administrative%7Celement:labels.text.fill%7Cvisibility:off&style=feature:administrative.country%7Celement:labels%7Ccolor:0x9b30f2%7Cvisibility:simplified&style=feature:administrative.locality%7Ccolor:0xa657e7%7Cvisibility:simplified&style=feature:administrative.locality%7Celement:labels.text.fill%7Ccolor:0x6f6f6f%7Cweight:0.01&style=feature:administrative.province%7Cvisibility:off&style=feature:landscape.man_made%7Ccolor:0xbf3636%7Cvisibility:off&style=feature:landscape.man_made%7Celement:geometry%7Ccolor:0xeaeaea%7Cvisibility:on&style=feature:landscape.man_made%7Celement:geometry.stroke%7Cvisibility:off&style=feature:landscape.man_made%7Celement:labels%7Cvisibility:off&style=feature:landscape.natural%7Cvisibility:off&style=feature:landscape.natural%7Celement:geometry%7Cvisibility:off&style=feature:landscape.natural.landcover%7Cvisibility:on&style=feature:landscape.natural.landcover%7Celement:geometry%7Ccolor:0xeaeaea%7Cvisibility:on&style=feature:landscape.natural.terrain%7Cvisibility:off&style=feature:landscape.natural.terrain%7Celement:geometry%7Ccolor:0xeaeaea%7Cvisibility:on&style=feature:poi%7Celement:geometry%7Ccolor:0xeaeaea&style=feature:poi%7Celement:labels%7Cvisibility:off&style=feature:road%7Csaturation:-100%7Clightness:45%7Cvisibility:simplified&style=feature:road.highway%7Ccolor:0xc4c6f4%7Cvisibility:simplified&style=feature:road.highway%7Celement:labels%7Ccolor:0xd3d4f3%7Cvisibility:off&style=feature:road.highway%7Celement:labels.text%7Ccolor:0x000000%7Cvisibility:simplified%7Cweight:0.01&style=feature:road.highway%7Celement:labels.text.fill%7Cvisibility:simplified%7Cweight:0.01&style=feature:transit.station.bus%7Cvisibility:off&style=feature:water%7Ccolor:0xeeeeff%7Cvisibility:on&style=feature:water%7Celement:geometry.fill%7Ccolor:0xb19dfc%7Cvisibility:on&style=feature:water%7Celement:geometry.stroke%7Ccolor:0xa43c3c%7Cvisibility:off&size=480x360";
    // return "https://maps.googleapis.com/maps/api/staticmap?key=$GOOGLE_API_KEY&center=$lat,$lng&zoom=16&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0xf5f5f5&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x616161&style=element:labels.text.stroke%7Ccolor:0xf5f5f5&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:poi%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:road%7Celement:geometry%7Ccolor:0xffffff&style=feature:road.arterial%7Celement:geometry.stroke%7Ccolor:0x50bcff&style=feature:road.arterial%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:road.highway%7Celement:geometry%7Ccolor:0xdadada&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:road.local%7Celement:geometry.stroke%7Ccolor:0xade8ff&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:transit.line%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:transit.station%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:water%7Celement:geometry%7Ccolor:0xc9c9c9&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&size=480x360";
  }

  static void setStyle(GoogleMapController mc, BuildContext context) async {
    String val = await DefaultAssetBundle.of(context).loadString('assets/map_style.json');
    mc.setMapStyle(val);
  }

  static moveToLocation(GoogleMapController mc, LatLng target, double zoom) {
    mc.animateCamera(CameraUpdate.newCameraPosition(
    CameraPosition(
      target: LatLng(43.65, -79.38),
      zoom: 3,
      bearing: 45.0,
      tilt: 45.0)));
  }

  static Future<LocationData> getUserLocation() async {
    LocationData currentLocation;

    var location = new Location();

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      currentLocation = await location.getLocation();
    } 
    // on PlatformException catch (e) {
    //   if (e.code == 'PERMISSION_DENIED') {
    //     error = 'Permission denied';
    //   } 
    //   currentLocation = null;
    // } 
    catch (e) {
       currentLocation = null;
      print(e);
    }

    location.onLocationChanged().listen((LocationData currentLocation) {
      print(currentLocation.latitude);
      print(currentLocation.longitude);
    });
    print(currentLocation);
    return currentLocation;
    //from flutter location package

//     class LocationData {
//   final double latitude; // Latitude, in degrees
//   final double longitude; // Longitude, in degrees
//   final double accuracy; // Estimated horizontal accuracy of this location, radial, in meters
//   final double altitude; // In meters above the WGS 84 reference ellipsoid
//   final double speed; // In meters/second
//   final double speedAccuracy; // In meters/second, always 0 on iOS
//   final double heading; //Heading is the horizontal direction of travel of this device, in degrees
//   final double time; //timestamp of the LocationData
// }


// enum LocationAccuracy { 
//   POWERSAVE, // To request best accuracy possible with zero additional power consumption, 
//   LOW, // To request "city" level accuracy
//   BALANCED, // To request "block" level accuracy
//   HIGH, // To request the most accurate locations available
//   NAVIGATION // To request location for navigation usage (affect only iOS)
// }
  }
}




// const staticAPI = "https://maps.googleapis.com/maps/api/staticmap?key=$GOOGLE_API_KEY&center=$lat,$lng&zoom=16&format=png&maptype=roadmap&style=element:geometry%7Ccolor:0xf5f5f5&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x616161&style=element:labels.text.stroke%7Ccolor:0xf5f5f5&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:poi%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:road%7Celement:geometry%7Ccolor:0xffffff&style=feature:road.arterial%7Celement:geometry.stroke%7Ccolor:0x50bcff&style=feature:road.arterial%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:road.highway%7Celement:geometry%7Ccolor:0xdadada&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:road.local%7Celement:geometry.stroke%7Ccolor:0xade8ff&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:transit.line%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:transit.station%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:water%7Celement:geometry%7Ccolor:0xc9c9c9&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&size=480x360";

const mapJSON = [ { "elementType": "geometry", "stylers": [ { "color": "#f5f5f5" } ] }, { "elementType": "labels.icon", "stylers": [ { "visibility": "off" } ] }, { "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "elementType": "labels.text.stroke", "stylers": [ { "color": "#f5f5f5" } ] }, { "featureType": "administrative.land_parcel", "elementType": "labels.text.fill", "stylers": [ { "color": "#bdbdbd" } ] }, { "featureType": "poi", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "poi", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "poi.park", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "poi.park", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "road", "elementType": "geometry", "stylers": [ { "color": "#ffffff" } ] }, { "featureType": "road.arterial", "elementType": "geometry.stroke", "stylers": [ { "color": "#50bcff" } ] }, { "featureType": "road.arterial", "elementType": "labels.text.fill", "stylers": [ { "color": "#757575" } ] }, { "featureType": "road.highway", "elementType": "geometry", "stylers": [ { "color": "#dadada" } ] }, { "featureType": "road.highway", "elementType": "labels.text.fill", "stylers": [ { "color": "#616161" } ] }, { "featureType": "road.local", "elementType": "geometry.stroke", "stylers": [ { "color": "#ade8ff" } ] }, { "featureType": "road.local", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] }, { "featureType": "transit.line", "elementType": "geometry", "stylers": [ { "color": "#e5e5e5" } ] }, { "featureType": "transit.station", "elementType": "geometry", "stylers": [ { "color": "#eeeeee" } ] }, { "featureType": "water", "elementType": "geometry", "stylers": [ { "color": "#c9c9c9" } ] }, { "featureType": "water", "elementType": "labels.text.fill", "stylers": [ { "color": "#9e9e9e" } ] } ];