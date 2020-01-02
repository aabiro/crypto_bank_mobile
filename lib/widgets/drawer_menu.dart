import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/screens/bike_list.dart';
import 'package:flutter_app/screens/journey.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/settings.dart';
import 'package:flutter_app/screens/wallet.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:provider/provider.dart';
import '../screens/profile.dart';
import '../screens/settings.dart';
import '../screens/become_lender.dart';
import '../screens/stats.dart';
import '../screens/journey.dart';
import '../helpers/user_helper.dart';
import 'user_card.dart';

class MenuDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function navigateTo) {
    return ListTile(
      leading: Icon(icon, size: 26, color: Colors.blueGrey,),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'Comfortaa', fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueGrey,),
      ),
      onTap: navigateTo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return new SizedBox(
      width: mediaQuery.size.width * 0.75,
      child: Stack(
        children: <Widget>[
          
          Drawer(
          child: Column(
            children: <Widget>[
              Container(
                height: 80,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                // color: Color(0xff98c1d9),
                color: Constants.mainColor,
                child: Text('',
                    // 'Menu',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )
                    //Theme.of(context).primaryColor),
                    ),
              ),
              SizedBox(
                height: 45,
              ),
              buildListTile('Profile', Icons.account_box, () {
                Navigator.of(context).popAndPushNamed(ProfileScreen.routeName);
              }),
              buildListTile('My Bikes', Icons.directions_bike, () {
                Navigator.of(context).pushNamed(BikeList.routeName);
              }),
              buildListTile('Wallet', Icons.attach_money, () {
                Navigator.of(context).popAndPushNamed(WalletScreen.routeName);
              }),
              buildListTile('My Stats', Icons.assessment, () {
                Navigator.of(context).popAndPushNamed(StatsScreen.routeName);
              }),
              buildListTile('Become a Lender', Icons.star, () {
                Navigator.of(context).popAndPushNamed(PlansScreen.routeName);
              }),
              buildListTile('Settings', Icons.settings, () {
                Navigator.of(context).popAndPushNamed(SettingsScreen.routeName);
              }),
              ListTile(
                leading: Icon(Icons.exit_to_app, size: 26,color: Colors.blueGrey),
                title: Text(
                  'Sign Out',
                  style: TextStyle(
                      fontFamily: 'Comfortaa',
                      fontSize: 14,
                      fontWeight: FontWeight.bold, 
                      color: Colors.blueGrey),
                ),
                onTap: () {
                  // UserHelper.logout(context);
                  Navigator.of(context).pop();
                  Provider.of<Authentication>(context).logout(context);
                },
              ),
              // buildListTile('Route for Trip', Icons.explore, () {
              //   Navigator.of(context).popAndPushNamed(JourneyScreen.routeName);
              // }),
            ],
          ),
        ),
        UserCardDrawer(),
          ],
      ),
    );
  }
}
