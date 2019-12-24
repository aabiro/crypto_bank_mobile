import 'package:flutter/material.dart';
import 'package:flutter_app/screens/alert_screen.dart';
import 'package:flutter_app/screens/bike_list.dart';
import 'package:flutter_app/providers/bike.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/screens/extra_screens/register_steps.dart';
import 'package:flutter_app/screens/qr_scan.dart';
import 'package:flutter_app/screens/register.dart';
import 'package:flutter_app/services/service_locator.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/screens/extra_screens/register_info.dart';
import 'package:flutter_app/screens/extra_screens/register_address.dart';
import 'package:flutter_app/screens/extra_screens/choose_upload.dart';
import 'package:flutter_app/screens/extra_screens/photo_id.dart';
import 'package:flutter_app/screens/settings.dart';
import './screens/login.dart';
import './screens/home.dart';
import './screens/profile.dart';
import './screens/camera_screen.dart';
import './screens/stats.dart';
import './screens/become_lender.dart';
import './screens/journey.dart';
import './screens/wallet.dart';
import './screens/bike_list.dart';
import './screens/bike_detail_view.dart';
import './screens/order_locks.dart';
import './screens/add_credit_card.dart';
import './screens/set_map_area.dart';
import './screens/order_complete.dart';
import './screens/qr_scan.dart';
import './screens/activation_complete.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import './providers/bikes.dart';
// import './models/bike.dart';


List<CameraDescription> cameras;

Future<Null> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Bikes()),
      ],
      child:  MaterialApp(
      // title: '1er',
      //The app theme
      theme: ThemeData(
        // primarySwatch: Colors.indigo,
        accentColor: Constants.accentColor,
        fontFamily: 'Comfortaa',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(
            fontFamily: 'OpenSans', 
            fontWeight: FontWeight.bold,
            fontSize: 18)
        ),
        //appBar theme
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold
              ),
            ), 
        ),
      ),
      home: LoginScreen(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/register/steps': (context) => UserStepsScreen(),
        '/home': (context) => MapScreen(),
        '/camera': (context) => CameraScreen(cameras),
        // 'bike_list': (context) => BikeList(),
        MapScreen.routeName: (context) => MapScreen(),
        SettingsScreen.routeName: (context) => SettingsScreen(),
        ProfileScreen.routeName: (context) => ProfileScreen(),
        PlansScreen.routeName: (context) => PlansScreen(),
        StatsScreen.routeName: (context) => StatsScreen(),
        JourneyScreen.routeName: (context) => JourneyScreen(''),
        SetMapAreaScreen.routeName: (context) => SetMapAreaScreen(),
        WalletScreen.routeName: (context) => WalletScreen(),
        CreditCardScreen.routeName: (context) => CreditCardScreen(),
        BikeList.routeName: (context) => BikeList(),
        ActivationCompleteScreen.routeName: (context) => ActivationCompleteScreen(''),
        BikeDetailScreen.routeName: (context) => BikeDetailScreen(''),
        AlertScreen.routeName: (context) => AlertScreen(),
        // FlutterBarcodeScanner.routeName: (context) => FlutterBarcodeScanner(),
        QrScan.routeName: (context) => QrScan(false),
        // OrderLocksScreen.routeName: (context) => OrderLocksScreen(),
        OrderCompleteScreen.routeName: (context) => OrderCompleteScreen()
        
        // CameraScreen.routeName: (context) => CameraScreen(cameras)
      },
    )
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

  
  class HomeScreenState extends State<HomeScreen> {

  Future<void> _signOut() async {
    try {
      Navigator.pushNamed(context, '/login');
    } catch (e) {
      print(e);
    }
  }

  Future<void> _goToMap() async {
    try {
      Navigator.pushNamed(context, '/map');
    } catch (e) {
      print(e);
    }
  }

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
        color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(text: 'Home', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const RaisedButton(
                onPressed: null,
                child: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20)
                ),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: _goToMap,
                child: const Text(
                  'To Map',
                  style: TextStyle(fontSize: 20)
                ),
              ),
              const SizedBox(height: 30),
              RaisedButton(
                onPressed: _signOut,
                textColor: Colors.white,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color(0xFF0D47A1),
                        Color(0xFF1976D2),
                        Color(0xFF42A5F5),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 20)
                  ),
                ),
              ),
              MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  onPressed: () {
                      Navigator.pop(context);
                  },
                  child: Text("Back",
                      textAlign: TextAlign.center
                  ),
                ),
            ],
          ),
        ),
      )
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
