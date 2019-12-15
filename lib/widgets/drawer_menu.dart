import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/screens/settings.dart';
import '../screens/profile.dart';
import '../screens/settings.dart';
import '../screens/become_lender.dart';

class MenuDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function navigateTo) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'Comfortaa', fontSize: 14, fontWeight: FontWeight.bold),
      ),
      onTap: navigateTo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return new SizedBox(
       width: mediaQuery.size.width * 0.75,
       child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Color(0xff98c1d9),
              child: Text('',
                // 'Menu',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,)
                    //Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile('Settings', Icons.settings, () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            }),
            buildListTile('Profile', Icons.account_box, () {
              Navigator.of(context).pushNamed(ProfileScreen.routeName);
            }),
            buildListTile('Become a Lender', Icons.directions_bike, () {
              Navigator.of(context).pushNamed(PlansScreen.routeName);
            })
          ],
        ),
      ),
    );
  }
}
