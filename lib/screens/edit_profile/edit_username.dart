import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:provider/provider.dart';


class EditUserName extends StatefulWidget {
  static const routeName = '/edit_username';

  @override
  _EditUserNameState createState() => _EditUserNameState();
}

class _EditUserNameState extends State<EditUserName> {
  var _isLoading = false;
  var _init = true;
  

  // Widget buildInputField(TextEditingController controller, String labelText, String hintText, String initialValue) {
  //   controller.text = initialValue;
  //   return TextFormField(
  //     obscureText: hintText == 'Password' ? true : false,
  //     controller: controller,
  //     // initialValue: initialValue,
  //     decoration: InputDecoration(
  //       hintText: hintText,
  //       labelText: labelText,
  //       hintStyle: TextStyle(
  //         color: Color(0xff2196F3),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final auth = Provider.of<Authentication>(context);
    final usernameController = TextEditingController();
    // final usernameField = buildInputField(usernameController, "Username", auth.displayName != null ? auth.displayName : "", auth.displayName != null ? auth.displayName : "");  
    String username = usernameController.text;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new AppBar(
              centerTitle: true,
              backgroundColor: Color(0xff673AB7),
              title: new Text(
                'Edit Username',
                style: TextStyle(),
              ),
            ),

            Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                child: 
                // usernameField
                TextFormField(
      // obscureText: hintText == 'Password' ? true : false,
      controller: usernameController,
      // initialValue: initialValue,
      decoration: InputDecoration(
        hintText: auth.displayName != null ? auth.displayName : "",
        labelText: "Username",
        hintStyle: TextStyle(
          color: Color(0xff2196F3),
        ),
      ),
    ),
            ),
            Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(7.0),
              color: Color(0xff2196F3),
              child: MaterialButton(
                minWidth: mediaQuery.size.width / 3,
                padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                onPressed: () async {
                  //might need spinner
                  // if (username != auth.displayName && username != "") {
                  //   await auth.updateUser(username, "photUrl");
                  //   showError("You have successfully updated your username.", context);
                  // }
                  
                  if(username != auth.displayName && username != "") { //need validation here too
                    await auth.updateUser(username, '');
                    showError("You will need to login again with your new credentials.", context);
                    auth.logout(context);
                  } 
                  Navigator.of(context).pop();
                  
                },
                child: Text("Save",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.w900)),

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

// // import 'dart:html';

// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

// import 'package:flutter/material.dart';
// // import 'package:charts_flutter/flutter.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:flutter_app/providers/authentication.dart';
// import 'package:flutter_app/theme/constants.dart' as Constants;
// import 'package:flutter_app/models/income_chart.dart';
// import 'package:flutter_app/widgets/bar_chart.dart';
// import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';

// class EditUserName extends StatefulWidget {
//   static const routeName = '/edit_username';

//   @override
//   _EditUserNameState createState() => _EditUserNameState();
// }

// class _EditUserNameState extends State<EditUserName> {
//   var _isLoading = false;
//   var _init = true;
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();
//   final emailController = TextEditingController();
//   File _image;

//   Future getImage() async {
//     var image = await ImagePicker.pickImage(source: ImageSource.camera);
//     // var image = await ImagePicker.pickImage(source: ImageSource.gallery);

//     setState(() {
//       _image = image;
//     });
//   }

//   Future uploadImage(BuildContext context) async {
//     String picFile = basename(_image.path);
//     StorageReference firebaseStorage = FirebaseStorage.instance.ref().child(picFile); 
//     StorageUploadTask sUT = firebaseStorage.putFile(_image); //add file to firestore
//     StorageTaskSnapshot sTS = await sUT.onComplete;
//     print(" image added to firebase");
//   }

//   Widget buildInputField(TextEditingController controller, String labelText, String hintText ) {
//     return TextFormField(
//       obscureText: hintText == 'Password' ? true : false,
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         labelText: labelText,
//         hintStyle: TextStyle(
//           color: Color(0xff2196F3),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final auth = Provider.of<Authentication>(context);
//     final usernameField = buildInputField(usernameController, "Username", auth.displayName != null ? auth.displayName : "");
//     final passwordField = buildInputField(passwordController, "Password", '******');
//     final emailField = buildInputField(emailController, "Email", auth.email != null ? auth.email : ""); 
//     String username = usernameController.text;
//     String password = passwordController.text;
//     String email = emailController.text;

//     // @override
//     // void didChangeDependencies() {
//     //   if (_init) {
//     //     _isLoading = true;
//     //     // var accessToken = Provider.of<Authentication>(context).accessToken;
//     //     Provider.of<Authentication>(context).getUserData().then((_) {
//     //         _isLoading = false;
//     //     });
//     //   }
//     //   _init = false;
//     // }

//     return Scaffold(
//       body: SingleChildScrollView(
//         //add to Scroll whole screen
//         child: Column(
//           children: <Widget>[
//             new AppBar(
//               centerTitle: true,
//               backgroundColor: Color(0xff673AB7),
//               title: new Text(
//                 'Profile',
//                 style: TextStyle(),
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: SizedBox(
//               // width: double.infinity,
//               child: new CircleAvatar(
//                 maxRadius: mediaQuery.size.height * 0.15,
//                 backgroundImage: NetworkImage(
//                   _image != null ? _image : ''
//                 ),
//                 backgroundColor: Color(0xff9575CD),
//                 child: Text(
//                     (auth.photoUrl == null || auth.photoUrl == "") &&
//                     auth.displayName != null
//                     ? auth.displayName[0] : '',
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 40,
//                         fontWeight: FontWeight.w900)),
//               ),
//             ),        
//             ),
//             SizedBox(height: 0),
//             FloatingActionButton(
//               onPressed: getImage,
//               // tooltip: 'Pick Image',
//               child: Icon(Icons.add_a_photo),
//             ),
//             Padding(
//                 padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 15.0),
//                 child: usernameField),
//             // TextFormField(
//             //   decoration: InputDecoration(
//             //     labelText: 'Enter your username'
//             //   ),
//             // ),
//             Padding(
//                 padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
//                 child: emailField
//             ),
//             Padding(
//                 padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 30.0),
//                 child: passwordField
//             ),
//             Material(
//               elevation: 5.0,
//               borderRadius: BorderRadius.circular(7.0),
//               color: Color(0xff2196F3),
//               child: MaterialButton(
//                 minWidth: mediaQuery.size.width / 3,
//                 padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//                 onPressed: () async {
//                   //might need spinner
//                   if (username != auth.displayName && username != "") {
//                     await auth.updateUser(username, "photUrl");
//                     showError("You have successfully updated your username.", context);
//                   }
                  
//                   if(email != auth.email && email != "") { //need validation here too
//                     await auth.updateEmail(email, context);
//                     showError("You will need to login again with your new credentials.", context);
//                     // auth.logout(context);
//                   } 
//                   //  await auth.resetPassword(password); //mask this
//                   uploadImage(context);
//                   auth.updateUser(auth.displayName, _image.path);
//                   Navigator.of(context).pop();
//                   // Navigator.of(context).pushNamed('/home');
                  
//                 },
//                 child: Text("Save",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         // fontSize: 40,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w900)),
//                 // color: Color(),
//                 // style: style.copyWith(
//                 // //     color: Colors.white,
//                 // fontWeight: FontWeight.bold)
//                 // ),
//               ),
//             ),
//             SizedBox(height: 30),
//           ],
//         ),
//       ),
//     );
//   }

//   void showError(String message, BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//               title: Text('Error'),
//               content: Text(message),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Okay'),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 )
//               ],
//             ));
//   }
// }


///if need to change
///            SizedBox(height: 30),
            // Padding(
            //     padding: EdgeInsets.all(30),
            //     child: usernameField
            // ),
            // Padding(
            //     padding: EdgeInsets.all(30),
            //     child: 
                
            //     Row(
            //       children: <Widget>[
            //       emailField,
                  
            //     ], ),
                
                
            //     ),
            // // TextFormField(
            // //   decoration: InputDecoration(
            // //     labelText: 'Enter your username'
            // //   ),
            // // ),
            
            // Padding(
            //     padding: EdgeInsets.all(30),
            //     child: Row(
            //       children : <Widget>[
            //       passwordField,
            //        IconButton(
            //       icon: Icon(Icons.arrow_forward),
            //       onPressed: () {
            //         Navigator.pushReplacementNamed(context, '/change_password');
            //         // Navigator.of(context).pushReplacement(MapScreen.routeName);
            //       })

            //     ],)
            // ),
            // Material(
            //   elevation: 5.0,
            //   borderRadius: BorderRadius.circular(7.0),
            //   color: Color(0xff2196F3),
            //   child: MaterialButton(
            //     minWidth: mediaQuery.size.width / 3,
            //     padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            //     onPressed: () {
            //       Provider.of<Authentication>(context).updateUser(username, "photUrl");
            //       Navigator.of(context).pop();
            //     },
            //     child: Text("Save",
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