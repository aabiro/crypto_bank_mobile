import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/providers/journeys.dart';
import 'package:flutter_app/providers/user_cards.dart';
import 'package:flutter_app/screens/alert_screen.dart';
import 'package:flutter_app/screens/bike_form.dart';
import 'package:flutter_app/screens/bike_list.dart';
import 'package:flutter_app/screens/card_list.dart';
import 'package:flutter_app/screens/direct_deposit.dart';
import 'package:flutter_app/screens/edit_profile/edit_username.dart';
import 'package:flutter_app/screens/edit_profile/reset_email.dart';
import 'package:flutter_app/screens/edit_profile/reset_password.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/profile.dart';
import 'package:flutter_app/screens/extra_screens/register_steps.dart';
import 'package:flutter_app/screens/qr_scan.dart';
import 'package:flutter_app/screens/register.dart';
import 'package:flutter_app/services/service_locator.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter_app/screens/settings.dart';
import './screens/login.dart';
import './screens/home.dart';
import './screens/profile.dart';
import './screens/stats.dart';
import './screens/become_lender.dart';
import './screens/journey.dart';
import './screens/wallet.dart';
import './screens/bike_list.dart';
import './screens/order_locks.dart';
import './screens/add_credit_card.dart';
import './screens/set_map_area.dart';
import './screens/order_complete.dart';
import './screens/qr_scan.dart';
import './screens/edit_bike.dart';
import './screens/activation_complete.dart';
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import './providers/bikes.dart';
import './providers/authentication.dart';
import './config_reader.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Authentication(),
        ),
        ChangeNotifierProxyProvider<Authentication, Bikes>(
          create: (_) => Bikes(
          ),
          update: (_, auth, prevBikes) => Bikes(
            auth.accessToken, 
            auth.userId,
            prevBikes.allBikes
            ),
          ),
          //send in user information for endpoints access
          ChangeNotifierProxyProvider<Authentication, UserCards>(
          create: (_) => UserCards( 
            ),
          update: (_, auth, prevCards) => UserCards(
            auth.accessToken, 
            auth.userId,
            prevCards.userCards
            ),
          ),
          ChangeNotifierProxyProvider<Authentication, Journeys>(
          create: (_) => Journeys( 
            ),
          update: (_, auth, prevJourneys) => Journeys(
            auth.accessToken, 
            auth.userId,
            prevJourneys.journeys
            ),
          ),
      ],
      child: Consumer<Authentication>(
        builder: (context, auth, _) => MaterialApp(
          theme: ThemeData(
            accentColor: Constants.accentColor,
            fontFamily: 'Comfortaa',
            textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'Comfortaa',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
            ),
          ),
          home: auth.isLoggedIn ? MapScreen() : LoginScreen(),
          initialRoute: '/login',
          routes: {
            '/login': (context) => LoginScreen(),
            '/register': (context) => RegisterScreen(),
            '/register/steps': (context) => UserStepsScreen(),
            '/home': (context) => MapScreen(),
            // '/camera': (context) => CameraScreen(cameras),
            LoginScreen.routeName: (context) => LoginScreen(),
            MapScreen.routeName: (context) => MapScreen(),
            SettingsScreen.routeName: (context) => SettingsScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            PlansScreen.routeName: (context) => PlansScreen(),
            StatsScreen.routeName: (context) => StatsScreen(),
            JourneyScreen.routeName: (context) => JourneyScreen(),
            SetMapAreaScreen.routeName: (context) => SetMapAreaScreen(),
            WalletScreen.routeName: (context) => WalletScreen(),
            CreditCardScreen.routeName: (context) => CreditCardScreen(),
            BikeList.routeName: (context) => BikeList(),
            ActivationCompleteScreen.routeName: (context) =>
                ActivationCompleteScreen(),
            CardScreen.routeName: (context) => CardScreen(),
            BikeFormScreen.routeName: (context) => BikeFormScreen(''),
            // EditBike.routeName: (context) => EditBike(''),
            EditUserName.routeName: (context) => EditUserName(),
            EditPassword.routeName: (context) => EditPassword(),
            EditEmail.routeName: (context) => EditEmail(),
            DirectDeposit.routeName: (context) => DirectDeposit(),
            AlertScreen.routeName: (context) => AlertScreen(),
            QrScan.routeName: (context) => QrScan(),
            OrderLocksScreen.routeName: (context) => OrderLocksScreen(),
            OrderCompleteScreen.routeName: (context) => OrderCompleteScreen()
            // CameraScreen.routeName: (context) => CameraScreen(cameras)
          },
        ),
      ),
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
                  TextSpan(
                      text: 'Home',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const RaisedButton(
              onPressed: null,
              child: Text('Logout', style: TextStyle(fontSize: 20)),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              onPressed: _goToMap,
              child: const Text('To Map', style: TextStyle(fontSize: 20)),
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
                child: const Text('Logout', style: TextStyle(fontSize: 20)),
              ),
            ),
            MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back", textAlign: TextAlign.center),
            ),
          ],
        ),
      ),
    ));
  }
}