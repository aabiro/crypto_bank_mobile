// import 'dart:html';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/models/income_chart.dart';
import 'package:flutter_app/widgets/bar_chart.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class DirectDeposit extends StatefulWidget {
  static const routeName = '/direct_deposit';

  @override
  _DirectDepositState createState() => _DirectDepositState();
}

class _DirectDepositState extends State<DirectDeposit> {
  var _isLoading = false;
  var _init = true;
  final bankController = TextEditingController();
  final transitController = TextEditingController();
  final accountController = TextEditingController();
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  Future uploadImage(BuildContext context) async {
    String picFile = basename(_image.path);
    StorageReference firebaseStorage = FirebaseStorage.instance.ref().child(picFile); 
    StorageUploadTask sUT = firebaseStorage.putFile(_image); //add file to firestore
    StorageTaskSnapshot sTS = await sUT.onComplete;
    print(" image added to firebase");
  }

  Widget buildInputField(TextEditingController controller, String labelText, String hintText ) {
    return TextFormField(
      obscureText: hintText == 'Password' ? true : false,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: TextStyle(
          color: Color(0xff2196F3),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final auth = Provider.of<Authentication>(context);
    final bankField = buildInputField(bankController, "Bank Number", "");
    final transitField = buildInputField(transitController, "Transit Number", "");
    final accountField = buildInputField(accountController, "Account Number", ""); 
    String bank = bankController.text;
    String transit = transitController.text;
    String account = accountController.text;

    // @override
    // void didChangeDependencies() {
    //   if (_init) {
    //     _isLoading = true;
    //     // var accessToken = Provider.of<Authentication>(context).accessToken;
    //     Provider.of<Authentication>(context).getUserData().then((_) {
    //         _isLoading = false;
    //     });
    //   }
    //   _init = false;
    // }

    return Scaffold(
      body: SingleChildScrollView(
        //add to Scroll whole screen
        child: Column(
          children: <Widget>[
            new AppBar(
              centerTitle: true,
              backgroundColor: Color(0xff673AB7),
              title: new Text(
                'Direct Deposit',
                style: TextStyle(),
              ),
            ),
              // Padding(
              //   padding: EdgeInsets.all(20),
              //   child: SizedBox(
              //   // width: double.infinity,
              //   child: new CircleAvatar(
              //     maxRadius: mediaQuery.size.height * 0.15,
              //     // backgroundImage: NetworkImage(
              //     //   _image != null ? _image : ''
              //     // ),
              //     backgroundColor: Color(0xff9575CD),
              //     child: Icon(
                    
              //       icon: Icons.account_balance),
              //             ),
              //   ),
              // ),        
              // ),
            Padding(
                padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 15.0),
                child: bankField),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: 'Enter your bank'
            //   ),
            // ),
            Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                child: accountField
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 30.0),
                child: transitField
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(7.0),
              color: Color(0xff2196F3),
              child: MaterialButton(
                minWidth: mediaQuery.size.width / 3,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () async {
                  Navigator.of(context).pop();
                  
                },
                child: Text("Save",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w900)),
                // color: Color(),
                // style: style.copyWith(
                // //     color: Colors.white,
                // fontWeight: FontWeight.bold)
                // ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
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
}