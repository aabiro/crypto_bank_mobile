import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/screens/bike_form.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/bikes.dart';
import '../providers/authentication.dart';
import 'add_credit_card.dart';
import 'activation_complete.dart';
import 'journey.dart';
import 'bike_form.dart';

class QrScan extends StatefulWidget {
  bool activation;
  QrScan(this.activation);

  static final routeName = 'qr_code';
  @override
  State<StatefulWidget> createState() {
    return QrScanState();
  }

  // QrScan get widget => super.activation;
}

//courtesy of medium.com
class QrScanState extends State<QrScan> {
  // Provider.of<Authentication>(context).userId();
  // bool activation;
  // QrScanState(this.activation);

  String _barcode = "";
  @override
  Widget build(BuildContext context) {
    final QrScan args = ModalRoute.of(context).settings.arguments;
    print(args.activation);
    return args.activation == false
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Constants.mainColor,
              title: new Text(
                'GivnGo',
                style: TextStyle(),
              ),
            ),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                    child: Text("Find the QR code on the GivnGo bicycle lock.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.blueGrey,
                            fontSize: 20)),
                  ),
                  //           Padding(
                  //   padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  //   child: Text("Payment method:",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.w800,
                  //           color: Colors.blueGrey,
                  //           fontSize: 15)),
                  // ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Padding(
                  //     padding: EdgeInsets.all(20),
                  //     child: Column(
                  //       // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //       children: <Widget>[
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //           children: <Widget>[
                  //             Text(
                  //               "Credit Card\n ending in XXXX",
                  //               textAlign: TextAlign.center,
                  //               style: TextStyle(
                  //                   color: Colors.blueGrey,
                  //                   fontFamily: 'Comfortaa',
                  //                   // fontWeight: FontWeight.w900,
                  //                   fontSize: 15),
                  //             ),
                  //      OutlineButton(
                  //     // minWidth: MediaQuery.of(context).size.width,
                  //     padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                  //     onPressed: () {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             fullscreenDialog: true,
                  //             builder: (context) => CreditCardScreen(),
                  //             maintainState: false));
                  //     },
                  //     child: Text(
                  //       "Change",
                  //       textAlign: TextAlign.center,
                  //       style: TextStyle(
                  //           color: Constants.mainColor,
                  //           fontWeight: FontWeight.w800,
                  //           fontSize: 16),
                  //     ),
                  //   ),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Image.asset(
                    'assets/qr_bike.png',
                    height: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80, vertical: 10.0),
                    child: RaisedButton(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      color: Constants.mainColor,
                      textColor: Colors.white,
                      splashColor: Colors.blueGrey,
                      onPressed: () {
                        bypass(args.activation);
                        // scan(args.activation);
                      },
                      child: const Text(
                        'Scan the QR code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            // fontWeight: FontWeight.w800,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    // EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(
                        "Just \$1.00 to unlock\nOnly 20 cents/min after",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: Colors.blueGrey,
                            fontSize: 15)),
                  ),
                  // Padding (
                  //     padding :
                  //         EdgeInsets.symmetric (horizontal :  16.0 , vertical :  8.0 ),
                  //     child : Text (
                  //       _barcode,
                  //       textAlign : TextAlign.center,
                  //       style :  TextStyle (color :  Colors.red),
                  //     ),
                  //   ),
                ],
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Constants.mainColor,
              title: new Text(
                'Activate Ride',
                style: TextStyle(),
              ),
            ),
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                            child: Text(
                              'Start',
                              style: TextStyle(
                                color: Constants.mainColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Constants.mainColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Comfortaa',
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                            child: Text(
                              'Scan',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Constants.mainColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Comfortaa',
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                            child: Text(
                              'Finish',
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Constants.mainColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Comfortaa',
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                  // Padding(
                  //   padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                  //   child: Text(
                  //     "Step 1",
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w800,
                  //         color: Colors.blueGrey,
                  //         decoration: TextDecoration.underline,
                  //         fontSize: 25),
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                    child: Text(
                      "Follow the directions on the label of the GivnGo lock mechanism to affix the lock to your bicycle.(Done button goes to bike detail and verification code) \n\nNext,",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.blueGrey,
                          fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 80, vertical: 10.0),
                    child: RaisedButton(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0)),
                      color: Constants.mainColor,
                      textColor: Colors.white,
                      splashColor: Colors.blueGrey,
                      onPressed: () {
                        bypass(args.activation);
                        // scan(args.activation);
                      },
                      child: const Text(
                        'Scan the QR code',
                        style: TextStyle(
                            // fontWeight: FontWeight.w800,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
  }

  void bypass(bool activation) {
    print('activation');
    print(activation);
    String barcode = '001';
    if (activation == false) {
      Navigator.of(context).popAndPushNamed(JourneyScreen.routeName,
          arguments: JourneyScreen('001'));
    } else {
      // Provider.of<Bikes>(context).addBike(
      //     Bike(
      //       qrCode: barcode,
      //       isActive: true,
      //       name: 'New Bike',
      //     ),
      //     Provider.of<Authentication>(context).userId,
      //     Provider.of<Authentication>(context).accessToken);
      Navigator.of(context).popAndPushNamed(BikeFormScreen.routeName,
          arguments: BikeFormScreen('001'));
    }
  }

  Future scan(bool activation) async {
    print('scan activation');
    print(activation);
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this._barcode = barcode);
      await new Future.delayed(const Duration(seconds: 5));
      widget.activation == false
          ? Navigator.of(context).pushReplacementNamed(JourneyScreen.routeName,
              arguments: JourneyScreen(barcode))
          : Navigator.of(context).pushReplacementNamed(
              BikeFormScreen.routeName,
              arguments: BikeFormScreen(barcode));
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this._barcode = 'The user did not give permission to use the camera!';
        });
      } else {
        setState(() => this._barcode = 'Unknown error $e');
      }
    } on FormatException {
      setState(() => this._barcode =
          'null, the user pressed the return button before scanning something)');
    } catch (e) {
      setState(() => this._barcode = 'Unknown error: $e');
    }
  }
}
