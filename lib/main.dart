import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1er',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RegisterPage();
  }
  // return Builder<User>(
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.active) {
  //         FirebaseUser user = snapshot.data;
  //         if (user == null) {
              // return SignInPage();
  //         }
  //         return HomePage();
  //       })
 
  //   return StreamBuilder<FirebaseUser>(
  //     stream: FirebaseAuth.instance.onAuthStateChanged,
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.active) {
  //         FirebaseUser user = snapshot.data;
  //         if (user == null) {
  //           return SignInPage();
  //         }
  //         return HomePage();
  //       } else {
  //         return Scaffold(
  //           body: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         );
  //       }
  //     },
  //   );
  // }
}

class RegisterPage extends StatelessWidget {
  static final clientID = "com.example.flutter_app"; 
  static final mysecret = "mysecret";
  final clientCredentials = Base64Encoder().convert("$clientID:$mysecret".codeUnits);
  final url = "http://10.0.2.2:8888/register";

  final myUsernameController = TextEditingController();
  final myPasswordController = TextEditingController();

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   myController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    final emailField = TextField(
      obscureText: false,
      controller: myUsernameController,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextField(
      obscureText: true,
      controller: myPasswordController,
      // style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final email = myUsernameController.text;
    final password = myPasswordController.text;

    final body = "{\"username\":\"$email\", \"password\": \"$password\"}";
    Future<void> _register() async {
      try {
        await http.post(
          url,
          headers: {
          "Content-Type": "application/json",
          "Authorization": "Basic $clientCredentials"
          },
          body: body
        ).then((http.Response response) {
          final int statusCode = response.statusCode;
      
          if (statusCode < 200 || statusCode > 400 || json == null) {
            throw new Exception("Error while fetching data");
          }
          return json.decode(response.body);
        });
      } catch (e) {
        print(e);
      }
    }

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: _register,
        child: Text("Register",
            textAlign: TextAlign.center),
            // ,
            // style: style.copyWith(
            //     color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButon,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  Future<void> _signOut() async {
    try {
      // await FirebaseAuth.instance.signOut();
      print('add signout function');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    const _heroesUrl = 'http://10.0.2.2:8888/users';

    List<User> createUsersList(List data) {
      List<User> list = new List();

      for (int i = 0; i < data.length; i++) {
        String username = data[i]["username"];
        int id = data[i]["id"];
        User hero = new User(username: username, id: id);
        list.add(hero);
      }

      return list;
    }

    Future<List<User>> getAll() async {
      final response = await http.get(_heroesUrl);
      print(response.body);
      List responseJson = json.decode(response.body.toString());
      List<User> userList = createUsersList(responseJson);
      return userList;
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("List from Database"),
          actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
        ),
        body: new Container(
          child: new FutureBuilder<List<User>>(
            future: getAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return new ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(snapshot.data[index].username,
                          style: new TextStyle(fontWeight: FontWeight.bold)),
                        new Divider()
                      ]
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Home Page'),
  //       actions: <Widget>[
  //         FlatButton(
  //           child: Text(
  //             'Logout',
  //             style: TextStyle(
  //               fontSize: 18.0,
  //               color: Colors.white,
  //             ),
  //           ),
  //           onPressed: _signOut,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class User {
  User({this.id, this.username});
  final int id;
  String username;
}

/////////////////try auth # 1//////////////////////////

// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:async';
// import 'package:http/http.dart' as http;


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // @override
//   // State<StatefulWidget> createState () {
//   //   return MyAppState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter login UI',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Login'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

//   @override
//   Widget build(BuildContext context) {

//     void authenticate() async {
//       final clientID = "bob";
//       final body = "username=bob&password=password&grant_type=password";

//       // Note the trailing colon (:) after the clientID.
//       // A client identifier secret would follow this, but there is no secret, so it is the empty string.
//       final clientCredentials = Base64Encoder().convert("$clientID:".codeUnits);

//       final response = await http.post(
//         "http://10.0.2.2:8888/register",
//         headers: {
//         "Content-Type": "application/x-www-form-urlencoded",
//         "Authorization": "Basic $clientCredentials"
//         },
//         body: body
//       );
//       if(response != null){
//         print('got register endpoint response: $response');
//       }
//     }

//     final emailField = TextField(
//       obscureText: false,
//       // style: style,
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Email",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
//     );
//     final passwordField = TextField(
//       obscureText: true,
//       // style: style,
//       decoration: InputDecoration(
//           contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//           hintText: "Password",
//           border:
//               OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
//     );
//     final loginButon = Material(
//       elevation: 5.0,
//       borderRadius: BorderRadius.circular(30.0),
//       color: Color(0xff01A0C7),
//       child: MaterialButton(
//         minWidth: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
//         onPressed: authenticate,
//         child: Text("Login",
//             textAlign: TextAlign.center),
//             // ,
//             // style: style.copyWith(
//             //     color: Colors.white, fontWeight: FontWeight.bold)),
//       ),
//     );

//     return Scaffold(
//       body: Center(
//         child: Container(
//           color: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(36.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 155.0,
//                   child: Image.asset(
//                     "assets/logo.png",
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 SizedBox(height: 45.0),
//                 emailField,
//                 SizedBox(height: 25.0),
//                 passwordField,
//                 SizedBox(
//                   height: 35.0,
//                 ),
//                 loginButon,
//                 SizedBox(
//                   height: 15.0,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



/////////////////////Return objects////////////////////

// class MyAppState extends State<MyApp> {
//   static const _heroesUrl = 'http://10.0.2.2:8888/reads';

//   Future<List<Hero>> getAll() async {
//     final response = await http.get(_heroesUrl);
//     print(response.body);
//     List responseJson = json.decode(response.body.toString());
//     List<Hero> userList = createHeroesList(responseJson);
//     return userList;
//   }

//   List<Hero> createHeroesList(List data) {
//     List<Hero> list = new List();

//     for (int i = 0; i < data.length; i++) {
//       String author = data[i]["author"];
//       int id = data[i]["id"];
//       Hero hero = new Hero(author: author, id: id);
//       list.add(hero);
//     }

//     return list;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("List from Database"),
//         ),
//         body: new Container(
//           child: new FutureBuilder<List<Hero>>(
//             future: getAll(),
//             builder: (context, snapshot) {

//               if (snapshot.hasData) {
//                 return new ListView.builder(
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (context, index) {
//                     return new Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         new Text(snapshot.data[index].author,
//                           style: new TextStyle(fontWeight: FontWeight.bold)),
//                         new Divider()
//                       ]
//                     );
//                   }
//                 );
//               } else if (snapshot.hasError) {
//                 return new Text("${snapshot.error}");
//               }

//               // By default, show a loading spinner
//               return new CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Hero {
//   Hero({this.id, this.author});
//   final int id;
//   String author;
// }
