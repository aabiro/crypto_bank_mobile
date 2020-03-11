import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/screens/edit_profile/reset_email.dart';
import 'package:flutter_app/screens/edit_profile/reset_password.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'edit_profile/edit_username.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _isLoading = false;
  var _init = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  File _image;

  Future getImage() async {
    // var image = await ImagePicker.pickImage(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

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

  Widget buildInputField(String title, String value, BuildContext context) {
    return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Material(
                    child: Column(
                      children: <Widget>[                   
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 1.6,
                          onPressed: () {
                            if(title == 'Password') {
                              Navigator.of(context).pushNamed(EditPassword.routeName);
                            } else if (title == 'Email') {
                              Navigator.of(context).pushNamed(EditEmail.routeName);
                            }
                          } ,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        title,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.blueGrey,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blueGrey,
                              ),                   
                            ],
                          ),
                        ),
                        Padding(
                           padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Divider(
                          color: Colors.blueGrey,
                      ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final auth = Provider.of<Authentication>(context);
    // final usernameField = buildInputField(usernameController, "Username", auth.displayName != null ? auth.displayName : "");
    // final passwordField = buildInputField(passwordController, "Password", '******');
    // final emailField = buildInputField(emailController, "Email", auth.email != null ? auth.email : "");
    // String username = usernameController.text;
    // String password = passwordController.text;
    String email = auth.email == null ? "None" : auth.email;

    @override
    void didChangeDependencies() {
      if (_init) {
        _isLoading = true;
        // var accessToken = Provider.of<Authentication>(context).accessToken;
        Provider.of<Authentication>(context).getUserData().then((_) {
          _isLoading = false;
        });
      }
      _init = false;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new AppBar(
              centerTitle: true,
              backgroundColor: Constants.mainColor,
              title: new Text(
                'Profile',
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: SizedBox(
                child: CircleAvatar(
                  maxRadius: mediaQuery.size.height * 0.15,
                  backgroundImage: auth.photoUrl != null && auth.photoUrl.isNotEmpty
                  ? NetworkImage(auth.photoUrl)
                  : null,
                  backgroundColor: Color(0xff9575CD),
                  child: Text(
                    (auth.photoUrl == null || auth.photoUrl == "") &&
                            auth.displayName != null
                        ? auth.displayName[0]
                        : '',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            FloatingActionButton(
              onPressed: () {},
              // getImage,
              // tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
            SizedBox(height: 15.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Material(
                    child: Column(
                      children: <Widget>[                
                        MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 1.6,
                          onPressed: () {
                            Navigator.of(context).pushNamed(EditUserName.routeName);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        'Username',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      child: Text(
                                        auth.displayName == null
                                            ? "None"
                                            : auth.displayName,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.blueGrey,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.blueGrey,
                              ),                   
                            ],
                          ),
                        ),
                        Padding(
                           padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Divider(
                          color: Colors.blueGrey,
                      ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 15.0),
            buildInputField("Email", email, context),
            buildInputField("Password", "******", context),
            SizedBox(height: 30),
            // Padding(
            //     padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 15.0),
            //     child: usernameField),
            // // TextFormField(
            // //   decoration: InputDecoration(
            // //     labelText: 'Enter your username'
            // //   ),
            // // ),
            // Padding(
            //     padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
            //     child: emailField
            // ),
            // Padding(
            //     padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 30.0),
            //     child: passwordField
            // ),
            // Material(
            //   elevation: 5.0,
            //   borderRadius: BorderRadius.circular(7.0),
            //   color: Color(0xff2196F3),
            //   child: MaterialButton(
            //     minWidth: mediaQuery.size.width / 3,
            //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            //     onPressed: () {
            //       // Navigator.of(context).pushNamed(EditProfileScreen.routeName);
            //       // //might need spinner
            //       // if (username != auth.displayName && username != "") {
            //       //   await auth.updateUser(username, "photUrl");
            //       //   showError("You have successfully updated your username.", context);
            //       // }

            //       // if(email != auth.email && email != "") { //need validation here too
            //       //   await auth.updateEmail(email, context);
            //       //   showError("You will need to login again with your new credentials.", context);
            //       //   // auth.logout(context);
            //       // }
            //       // //  await auth.resetPassword(password); //mask this

            //       // // Navigator.of(context).pop();
            //       // Navigator.of(context).pushNamed('/home');
            //     },
            //     child: Text("Edit",
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             // fontSize: 40,
            //             color: Colors.white,
            //             fontWeight: FontWeight.w900)),
            //     // color: Color(),
            //     // style: style.copyWith(
            //     // //     color: Colors.white,
            //     // fontWeight: FontWeight.bold)
            //     // ),
            //   ),
            // ),
            // SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  void showError(String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
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
