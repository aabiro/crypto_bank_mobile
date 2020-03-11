import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/screens/bike_form.dart';
import 'package:flutter_app/services/mailer.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/authentication.dart';
import 'bike_form.dart';

class QrScan extends StatefulWidget {
  //scan for bike activation
  QrScan();

  static final routeName = 'qr_code';
  @override
  State<StatefulWidget> createState() {
    return QrScanState();
  }
}

class QrScanState extends State<QrScan> {
  final activationCodeController = TextEditingController();
  String _barcode = "";

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Authentication>(context);  
    // String activationCode = activationCodeController.text.toString().trim(); //TODO with QRCode
    String activationCode = "QR001";

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.mainColor,
        title: new Text(
          'Givngo',
          style: TextStyle(),
        ),
      ),
      body: SingleChildScrollView(
          child: Builder(
          builder: (BuildContext context) {
            return Container(
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: TextFormField(
                        controller: activationCodeController,
                        decoration: new InputDecoration(
                          labelText: "Enter Activation Code",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
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
                    child: Text(
                        "Next scan the QR code on the Givngo bicycle lock.",
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
                        // bypass(activationCode, context);
                        scan(activationCode, context);
                      },
                      child: const Text(
                        'Scan the QR code',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void bypass(String activationCode, BuildContext _context) {
    String barcode = 'QR001';
    activationCode = 'QR001';
    if (barcode != activationCode) {
      final snackBar = SnackBar(
        content: Text('Activation code not correct.'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {},
        ),
      );
      Scaffold.of(_context).showSnackBar(snackBar);
    } else {
      Navigator.of(context).popAndPushNamed(BikeFormScreen.routeName,
          arguments: BikeFormScreen(barcode));
    }
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

  Future scan(String activationCode, BuildContext _context) async {
    try {
      // String barcode = 'QR001'; //have a few diff to show
      String barcode = await BarcodeScanner.scan();
      // if (barcode == activationCode) { //implement later
      if (true) {
        setState(() => this._barcode = barcode); 
        Navigator.of(context).pushReplacementNamed(BikeFormScreen.routeName,
            arguments: BikeFormScreen(barcode));
      } else {
        final snackBar = SnackBar(
          content: Text('Activation code not correct.'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {},
          ),
        );
        Scaffold.of(_context).showSnackBar(snackBar);
      }
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