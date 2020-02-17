import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/screens/bike_form.dart';
import 'package:flutter_app/services/mailer.dart';
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
  //scan for bike activation
  QrScan();

  static final routeName = 'qr_code';
  @override
  State<StatefulWidget> createState() {
    return QrScanState();
  }

  // QrScan get widget => super.activation;
}

//courtesy of medium.com
class QrScanState extends State<QrScan> {
  // bool activation;
  // QrScanState(this.activation);

  String _barcode = "";
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);
    return Scaffold(
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
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
              child: Text(
                  "Enter the activation code sent in your email confirmation.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.blueGrey,
                      fontSize: 20)),
            ),
            SizedBox(
              // height: 90,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter Activation Code",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  // validator: (val) {
                  //   if(val.length==0) {
                  //     return "Email cannot be empty";
                  //   }else{
                  //     return null;
                  //   }
                  // },
                  // keyboardType: TextInputType.emailAddress,
                  // style: new TextStyle(
                  //   fontFamily: "Poppins",
                  // ),
                ),
              ),
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(0),
              onPressed: () {
                Mailer.mailer(auth.email, auth.displayName, 'QR001');
              },
              child: Text("Resend code",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontFamily: 'OpenSans',
                  ),
                  textAlign: TextAlign.center),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text("Next scan the QR code on the GivnGo bicycle lock.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.blueGrey,
                      fontSize: 20)),
            ),
            Image.asset(
              'assets/qr_bike.png',
              height: 130,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10.0),
              child: RaisedButton(
                elevation: 0.5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.0)),
                color: Constants.mainColor,
                textColor: Colors.white,
                splashColor: Colors.blueGrey,
                onPressed: () {
                  bypass();
                  // scan();
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
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            //   // EdgeInsets.fromLTRB(30, 0, 30, 0),
            //   child: Text(
            //       "Just \$1.00 to unlock\nOnly 20 cents/min after",
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //           fontWeight: FontWeight.w800,
            //           color: Colors.blueGrey,
            //           fontSize: 15)),
            // ),
          ],
        ),
      ),
    );
  }

  void bypass() {
    String barcode = 'QR001';
    Navigator.of(context).popAndPushNamed(BikeFormScreen.routeName,
        arguments: BikeFormScreen(barcode));
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
    try {
      // String barcode = 'QR001'; //have a few diff to show
      String barcode = await BarcodeScanner.scan();
      setState(() => this._barcode = barcode);
      final bikeId = Provider.of<Bikes>(context).findByQrCode(barcode).id;
      // await new Future.delayed(const Duration(seconds: 5));
      // if(widget.activation == false) {
      //   Provider.of<Authentication>(context).isOnTrip = true;
      //     Navigator.of(context).pushReplacementNamed(JourneyScreen.routeName,
      //         arguments: JourneyScreen());
      // } else {
      Navigator.of(context).pushReplacementNamed(BikeFormScreen.routeName,
          arguments: BikeFormScreen(barcode));
      // }

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
      // showError(this._barcode, context);
    } catch (e) {
      setState(() => this._barcode = 'Unknown error: $e');
      showError(this._barcode, context);
    }
  }
}

// Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
//                             child: Text(
//                               'Start',
//                               style: TextStyle(
//                                 color: Constants.mainColor,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w800,
//                                 fontFamily: 'Comfortaa',
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '0',
//                             style: TextStyle(
//                               color: Constants.mainColor,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w800,
//                               fontFamily: 'Comfortaa',
//                             ),
//                           ),
//                           SizedBox(height: 30),
//                         ],
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
//                             child: Text(
//                               'Scan',
//                               style: TextStyle(
//                                 color: Colors.blueGrey,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w800,
//                                 fontFamily: 'Comfortaa',
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '0',
//                             style: TextStyle(
//                               color: Constants.mainColor,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w800,
//                               fontFamily: 'Comfortaa',
//                             ),
//                           ),
//                           SizedBox(height: 30),
//                         ],
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
//                             child: Text(
//                               'Finish',
//                               style: TextStyle(
//                                 color: Colors.blueGrey,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w800,
//                                 fontFamily: 'Comfortaa',
//                               ),
//                             ),
//                           ),
//                           Text(
//                             '0',
//                             style: TextStyle(
//                               color: Constants.mainColor,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w800,
//                               fontFamily: 'Comfortaa',
//                             ),
//                           ),
//                           SizedBox(height: 30),
//                         ],
//                       ),
//                     ],
//                   ),
