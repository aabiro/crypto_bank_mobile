import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import '../providers/authentication.dart';

// Create a Form widget.
class RegisterScreen extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<RegisterScreen> {
  final myEmailController = TextEditingController();
  final myPasswordController = TextEditingController();
  final myConfirmPasswordController = TextEditingController();

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

  Widget buildInputField(TextEditingController controller, String hintText) {
    return TextFormField(
      obscureText: false,
      controller: controller,
      decoration: InputDecoration(
        labelText: hintText,
        hintStyle: TextStyle(
          color: Color(0xff2196F3),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final emailField = buildInputField(myEmailController, "Email");
    final passwordField = buildInputField(myPasswordController, "Password");
    final confirmPasswordField =
        buildInputField(myConfirmPasswordController, "Confirm Password");

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Constants.mainColor,
              automaticallyImplyLeading: false,
              expandedHeight: 140.0,
              elevation: 5,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  "Givngo",
                  style: TextStyle(),
                ),
                background: Image.asset(
                  "assets/coolbike.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    emailField,
                    SizedBox(height: 15.0),
                    passwordField,
                    SizedBox(height: 15.0),
                    confirmPasswordField,
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 35.0,
                          width: 220,
                          child: Material(
                            elevation: 2.0,
                            borderRadius: BorderRadius.circular(30.0),
                            color: Constants.mainColor,
                            child: MaterialButton(
                              minWidth: MediaQuery.of(context).size.width / 1.6,
                              onPressed: () {
                                if (myPasswordController.text.toString().trim() == myConfirmPasswordController.text.toString().trim()) {
                                  print('email text : ${myEmailController.text}');
                                  Provider.of<Authentication>(context,
                                          listen: false)
                                      .register(myEmailController.text.toString().trim(), 
                                      myPasswordController.text.toString().trim(), 
                                      context);
                                } else {
                                  showError("Passwords do not match!", context);
                                }
                              },
                              child: Text(
                                "Register",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text("Or Login",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'OpenSans',
                          ),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
