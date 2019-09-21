import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/register/steps.dart';
import 'package:flutter_app/screens/register.dart';
import 'package:flutter_app/screens/register/register_personal.dart';
import 'package:flutter_app/screens/register/register_address.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1er',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: LoginScreen(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/register/steps': (context) => UserStepsScreen(),
        '/register/info': (context) => UserInfoScreen(),
        '/register/address': (context) => UserAddressScreen()
      },
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

    final mysecrettoken = '';

    Future<List<User>> getAll() async {
      final response = await http.get(
        _heroesUrl,
        headers: {
          "bearer": mysecrettoken
        }
      );
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


}

class User {
  User({this.id, this.username});
  final int id;
  String username;
}

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
