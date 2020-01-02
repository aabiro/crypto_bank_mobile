import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:provider/provider.dart';


class EditEmail extends StatefulWidget {
  static const routeName = '/edit_email';

  @override
  _EditEmailState createState() => _EditEmailState();
}

class _EditEmailState extends State<EditEmail> {
  var _isLoading = false;
  var _init = true;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

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
    final emailField = buildInputField(emailController, "Email", auth.email != null ? auth.email : ""); 
    String email = emailController.text;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new AppBar(
              centerTitle: true,
              backgroundColor: Color(0xff673AB7),
              title: new Text(
                'Reset Email',
                style: TextStyle(),
              ),
            ),

            Padding(
                padding: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
                child: emailField
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
                  
                  if(email != auth.email && email != "") { //need validation here too
                    await auth.updateEmail(email, context);
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