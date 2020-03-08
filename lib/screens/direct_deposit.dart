import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
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
    StorageReference firebaseStorage =
        FirebaseStorage.instance.ref().child(picFile);
    StorageUploadTask sUT =
        firebaseStorage.putFile(_image); //add file to firestore
    StorageTaskSnapshot sTS = await sUT.onComplete;
    print(" image added to firebase");
  }

  Widget buildInputField(
      TextEditingController controller, String labelText, String hintText) {
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
    final bankField = buildInputField(bankController, "Institution Number", "");
    final transitField =
        buildInputField(transitController, "Transit Number", "");
    final accountField =
        buildInputField(accountController, "Account Number", "");

    return Scaffold(
      body: SingleChildScrollView(
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
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                child: bankField),
            Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                child: accountField),
            Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 30.0),
                child: transitField),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(7.0),
              color: Color(0xff2196F3),
              child: MaterialButton(
                minWidth: mediaQuery.size.width / 3,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Done",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900)),
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        title: Text('Error'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
