import 'dart:async';
import 'dart:typed_data';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/helpers/maps_helper.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/providers/journey.dart';
import 'package:flutter_app/providers/journeys.dart';
import 'package:flutter_app/screens/qr_scan.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/widgets/drawer_menu.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../providers/bikes.dart';
import 'dart:ui' as ui;

import 'journey.dart';

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
  var user;
  bool userIsOnTrip = false;
  // Future<bool> userIsOnTrip;
  var allBikes;
  GoogleMapController mc;
  Completer<GoogleMapController> _controller = Completer();
  LatLng toronto = LatLng(43.65, -79.38);
  Future<LocationData> userLocation = _getGPSLocation();
  // List<Bikes> userBikes;
  // List<Bikes> allBikes;
  CameraPosition torontoCP = CameraPosition(
    //make this userlocation
    target: LatLng(43.65, -79.38),
    zoom: 13,
    // bearing: 45.0,
    // tilt: 45.0
  );
  List<Marker> markers = [];
  List<Marker> userMarker = [];

  BitmapDescriptor myIcon;
  BitmapDescriptor customIcon;
  List<Marker> markersA = [];

  String _barcode = "";

  // Uint8List markerIcon;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<Uint8List> getbits() async {
    return await getBytesFromAsset('assets/my_icon.png', 100);
  }

  static Future<LocationData> _getGPSLocation() async {
    final gpsLoc = await Location().getLocation();
    print('user gps location :');
    print(gpsLoc.latitude);
    print(gpsLoc.longitude);
    return gpsLoc;
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

  void refreshBikes() {
    //update widget?
    //update bikess
    //both at once or one?
  }

  void mapCreated(controller) {
    if (mounted) {
      setState(() {
        mc = controller;
      });
    }
  }

  @override
  void initState() {
    var markerIcon;
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      // Future.delayed(Duration.zero).then((_) {
      //   Provider.of<Bikes>(context).getUserBikes(allBikes: true);
      //   // .then((_) {
      //   //   print(allBikes);

      //   // });
      //   // print(allBikes);
      // });
      Future.delayed(Duration.zero).then((_) {
        user = Provider.of<Authentication>(context);
        userIsOnTrip = false;
      });
      // Future.delayed(Duration.zero).then((_) {
      //   userIsOnTrip = Provider.of<Journeys>(context).userIsOnTrip();
      //   // user.isOnTrip = Provider.of<Journeys>(context).userIsOnTrip();
      // });
      Future.delayed(Duration.zero).then((_) {
        Provider.of<Bikes>(context)
            .getUserBikes(
                // user.accessToken,
                // user.userId,
                )
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      });

      // BitmapDescriptor.fromAssetImage(
      //   ImageConfiguration(size: Size(48, 48)), 'assets/my_icon.png')
      //   .then((onValue) {
      //     myIcon = onValue;
      //   },);
      // userLocation = MapsHelper.getUserLocation(); //auto updating?

      // Future.delayed(Duration.zero).then((_) {
      //   Provider.of<MapHelp>(context).getbits().then((response) {
      //     print(response);
      //     markerIcon = response;
      //   });
      // markerIcon =  Provider.of<MapHelp>(context).getbits();
      // markerIcon = getbits();
      // markerIcon = getBytesFromAsset('assets/my_icon.png', 100);
      // final Marker marker = Marker(icon: BitmapDescriptor.fromBytes(markerIcon), markerId: null);
      // markerIcon = Provider.of<MapHelp>(context).getMarkerIcon("assets/my_icon.png", Size(150.0, 150.0));
      // });

      //  Provider.of<MapHelp>(context).getbits().then((response) {
      //   print(response);
      //   markerIcon = response;
      //  });

      //
      // allBikes.forEach((bikeId, bikeData) {
      markersA.add(
        //change to current position
        Marker(
          markerId: MarkerId('mymarker'),
          draggable: false,
          onTap: () {
            print(markerIcon);
            print('clicked marker');
            print(BitmapDescriptor.fromBytes(markerIcon));
          },
          // position: LatLng(bikeData.lat, bikeData.lng),
          position: toronto,
          // icon: customIcon //icon loads
          // icon: BitmapDescriptor.fromBytes(markerIcon), //LatLng(43.65, -79.38)
        ),
      );

      Future.delayed(Duration.zero).then(
        (_) {
          Provider.of<Bikes>(context).getAllUserBikes().then(
            (response) {
              response.forEach(
                (bike) {
                  // print('bike lat : ${bike.lat} and bike lng ${bike.lng}');
                  markersA.add(
                    Marker(
                      markerId: MarkerId(bike.id.toString()),
                      draggable: false,
                      onTap: () {
                        // print(markerIcon);
                        // print('clicked marker');
                        // print(BitmapDescriptor.fromBytes(markerIcon));
                      },

                      position: LatLng(bike.lat, bike.lng),
                      // position: toronto,
                      // icon: customIcon
                      // icon: BitmapDescriptor.fromBytes(markerIcon), //LatLng(43.65, -79.38)
                    ),
                  );
                },
              );
            },
          );
        },
      );
    }
    _init = false;
    super.initState();
  }

  createMarker(context) {
    if (customIcon == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);
      BitmapDescriptor.fromAssetImage(configuration, 'assets/my_icon.png')
          .then((icon) {
        setState(() {
          customIcon = icon;
        });
      });
    }
  }

  void setStyle(GoogleMapController mc, BuildContext context) async {
    String val = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mc.setMapStyle(val);
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    final mediaQuery = MediaQuery.of(context);
    String dropdownValue;
    var bikesProv = Provider.of<Bikes>(context);
    List<Bike> userBikes = bikesProv.userBikes;
    List<Bike> allBikes = bikesProv.allBikes;
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
                onMapCreated: (mc) {
                  mapCreated(mc);
                  // mc.setMapStyle(mapStyle)
                  MapsHelper.setStyle(mc, context);
                  // setStyle(mc, context);
                  // _controller.complete(mc);
                },
                initialCameraPosition:
                    CameraPosition(target: LatLng(40.6281, 14.4850), zoom: 5),
                markers: Set.from(markersA), //works
                // markers: Set.from(addBikeMarkers()),
                // myLocationEnabled: false,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                onTap: (pos) {
                  // print(pos);
                  // Marker m = Marker(
                  //     markerId: MarkerId('1'), icon: customIcon, position: pos);
                  // setState(() {
                  //   markersA.add(m);
                  // });
                }),
          ),
          Align(
              alignment: Alignment.topCenter,
              child: userBikes != null && userBikes.length > 0
                  ? DropdownButton<String>(
                      hint: Text(
                        'Find My Ride',
                        style: TextStyle(
                            color: Colors.grey[410],
                            fontFamily: 'OpenSans',
                            fontWeight: FontWeight.w800,
                            fontSize: 18),
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
                        moveToBikeLocation(bike.lat, bike.lng);
                      },
                      items:
                          array.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  : null),
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
                    // Icons.error_outline,
                    Icons.cached,
                    size: 30,
                  ),
                  color: Constants.accentColor,
                  onPressed: refreshBikes),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: SizedBox(
<<<<<<< HEAD
                width: mediaQuery.size.width * 0.7,
                height: mediaQuery.size.height * 0.1,
                child: 
                userIsOnTrip != null && userIsOnTrip == false
                    ? 
                    RaisedButton.icon(
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
                          // print(
                              // 'user.isOnTrip : ${user.isOnTrip} in the home screen');
                          scan();
                          //works for now >>>>>>>>>
                          // String barcode = '001';
                          // String userId = Provider.of<Authentication>(context).userId;
                          // // String bikeId = Provider.of<Bikes>(context).findByQrCode(barcode).id;

                          // Provider.of<Journeys>(context).addJourney(
                          //   Journey(
                          //     startTime: DateTime.now(),
                          //     dayOfTheWeek: DateTime.now().weekday,
                          //     // userId: userId,
                          //     // bikeId: bikeId,
                          //   ),
                          // );

                          // Navigator.of(context)
                          //     .pushNamed(JourneyScreen.routeName);

                          //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

                          // Provider.of<Authentication>(context).isOnTrip =
                          //     true; //not needed with Journeys now,?
                          // // query if user is on journey or not on init => if so get journey id to pass in below instead ...
                          // Navigator.of(context).pushReplacementNamed(JourneyScreen.routeName,
                          //     arguments: JourneyScreen(userId: userId, bikeId: bikeId));


                          // Navigator.of(context).pushNamed(QrScan.routeName);
                          // Provider.of<Journeys>(context).addJourney(
                          // Journey(
                          //   startTime: DateTime.now(),
                          //   dayOfTheWeek: DateTime.now().weekday,
                          //   // userId: _userId,
                          //   // bikeId: _bikeId,
                          // ));
                          // Navigator.of(context).pushNamed(QrScan.routeName);
                        },
                      )
                    : 
                    RaisedButton(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40.0)),
                        textColor: Colors.white,
                        color: Constants.accentColor,
                        child: Text(
                          'Trip Summary',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(JourneyScreen.routeName);
                        },
                      ),
              ),
=======
                  width: mediaQuery.size.width * 0.7,
                  height: mediaQuery.size.height * 0.1,
                  child: 
                  // user.isOnTrip != null && user.isOnTrip == false
                  //     ? 
                      RaisedButton.icon(
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
                            print(
                                'user.isOnTrip : ${user.isOnTrip} in the home screen');
                            Navigator.of(context).pushNamed(QrScan.routeName,
                                arguments: QrScan(false));
                            // scan();
                          },
                        )
                      // :
                      //  RaisedButton(
                      //     elevation: 5,
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(40.0)),
                      //     // icon: Icon(
                      //     //   Icons.center_focus_strong,
                      //     //   size: 25,
                      //     // ),
                      //     textColor: Colors.white,
                      //     color: Constants.accentColor,
                      //     child: Text(
                      //       'Trip Summary',
                      //       style: TextStyle(
                      //           fontFamily: 'OpenSans',
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 15),
                      //     ),
                      //     onPressed: () {
                      //       print(
                      //           'user.isOnTrip : ${user.isOnTrip} in the home screen');
                      //       Navigator.of(context)
                      //           .pushNamed(JourneyScreen.routeName);
                      //     },
                      //   )
                        
                        ),
>>>>>>> adding setup code
            ),
          ),
        ],
      ),
    );
  }

  void showError(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              title: Text('Error'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  Future scan() async {
    // String barcode = '001'; //have a few diff to show
    // String barcode = await BarcodeScanner.scan();
    // setState(() => this._barcode = barcode);
    // String _userId = Provider.of<Authentication>(context).userId;
    // String _bikeId = Provider.of<Bikes>(context).findByQrCode(barcode).id;

    // Provider.of<Journeys>(context).addJourney(
    //   Journey(
    //     startTime: DateTime.now(),
    //     dayOfTheWeek: DateTime.now().weekday,
    //     // userId: _userId,
    //     // bikeId: _bikeId,
    //   ),
    // );

    // Provider.of<Authentication>(context).isOnTrip = true; //not needed with Journeys now,?
    // query if user is on journey or not on init => if so get journey id to pass in below instead ...
    // Navigator.of(context).pushReplacementNamed(  //gives error on func call
    //   JourneyScreen.routeName,
    //   arguments: JourneyScreen(
    //     // userId: _userId,
    //     // bikeId: _bikeId,
    //   ),
    // );
    try {
      // String barcode = 'QR001'; //have a few diff to show
      String barcode = await BarcodeScanner.scan();
      setState(() => this._barcode = barcode);
      // String userId = Provider.of<Authentication>(context).userId;
      // String bikeId = Provider.of<Bikes>(context).findByQrCode(barcode).id;

      // Provider.of<Authentication>(context).isOnTrip =
      //     true; //not needed with Journeys now,?
      // query if user is on journey or not on init => if so get journey id to pass in below instead ...
      // Navigator.of(context).pushReplacementNamed(JourneyScreen.routeName,
      //     arguments: JourneyScreen(userId: userId, bikeId: bikeId));


      // String barcode = '001';
      // // String userId = Provider.of<Authentication>(context).userId;
      // // String bikeId = Provider.of<Bikes>(context).findByQrCode(barcode).id;

      Provider.of<Journeys>(context).addJourney(
        Journey(
          startTime: DateTime.now(),
          dayOfTheWeek: DateTime.now().weekday,
          // userId: userId,
          // bikeId: bikeId,
        ),
      );

      Navigator.of(context)
          .pushNamed(JourneyScreen.routeName);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._barcode = 'The user did not give permission to use the camera!';
          showError(this._barcode, context);
        });
      } else {
        setState(() => this._barcode = 'Unknown error $e');
        showError(this._barcode, context);
      }
    } on FormatException {
      setState(() => this._barcode =
          'null, the user pressed the return button before scanning something)');
    } catch (e) {
      setState(() => this._barcode = 'Unknown error: $e');
      showError(this._barcode, context);
    }
  }
}
