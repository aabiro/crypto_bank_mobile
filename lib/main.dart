import 'package:flutter/material.dart';

void main() {
   runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("My App Title"),
          ),
          body: Text("This is the body text widget"),
        ),
    );
  }
}
//    return MaterialApp(home: Text('Hello Aaryn!'));
//  }
//}