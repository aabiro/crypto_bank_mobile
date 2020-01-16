import 'package:flutter/material.dart';
import 'package:flutter_app/providers/authentication.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:provider/provider.dart';

class UserCardDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final auth = Provider.of<Authentication>(context);

    return Container(
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 35, 10, 10),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            height: mediaQuery.size.height * 0.25,
            width: mediaQuery.size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment,
              children: <Widget>[
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      maxRadius: mediaQuery.size.height * 0.07,
                      backgroundColor: Constants.optionalColor,
                      backgroundImage: NetworkImage(auth.photoUrl != null
                          ? auth.photoUrl
                          : ''), //user photoUrl
                      child: Text(
                        (auth.photoUrl == null || auth.photoUrl == "") && auth.displayName != null
                            ? auth.displayName[0]
                            : '',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                // Row(
                //    mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //   Text('Hi User',
                //       style: TextStyle(
                //           color: Colors.blueGrey,
                //           fontSize: 20,
                //           fontFamily: 'Comfortaa',
                //           fontWeight: FontWeight.w900)),

                // ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
