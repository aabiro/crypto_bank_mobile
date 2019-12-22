import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'add_credit_card.dart';
import 'journey.dart';

class QrScan extends StatefulWidget {
  static final routeName = 'qr_code';
  @override
  State<StatefulWidget> createState() {
    return QrScanState();
  }
}

//courtesy of medium.com
class QrScanState extends State<QrScan> {
  String _barcode = "";
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: Text(
                    "Ready to ride? Find the QR code on the bicycle lock and unlock your ride to start your journey.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.blueGrey,
                        fontSize: 15)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Text("Payment method:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.blueGrey,
                        fontSize: 15)),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Credit Card\n ending in XXXX",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontFamily: 'Comfortaa',
                                // fontWeight: FontWeight.w900,
                                fontSize: 15),
                          ),
                          OutlineButton(
                            // minWidth: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => CreditCardScreen(),
                                      maintainState: false));
                            },
                            child: Text(
                              "Change",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Constants.mainColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Image.asset(
                'assets/gnglogo.png',
                height: 150,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 10.0),
                child: RaisedButton(
                  color: Constants.mainColor,
                  textColor: Colors.white,
                  splashColor: Colors.blueGrey,
                  onPressed: scan,
                  child: const Text('Scan the QR code'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  _barcode,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this._barcode = barcode);
      // await new Future.delayed(const Duration(seconds : 5));
      Navigator.of(context).pushReplacementNamed(JourneyScreen.routeName);
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
