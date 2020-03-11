import 'package:flutter/material.dart';
import 'package:flutter_app/providers/user_cards.dart';
import 'package:flutter_app/screens/add_credit_card.dart';
import 'package:flutter_app/screens/card_list.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:provider/provider.dart';
import 'direct_deposit.dart';

class WalletScreen extends StatefulWidget {
  static final routeName = 'wallet';

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  var cards;
  var lastDefaultDigits;
  @override
  void initState() {
      Future.delayed(Duration.zero).then(
        (_) {
          lastDefaultDigits = Provider.of<UserCards>(context).defaultDigits;
        },
      );
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    print(lastDefaultDigits);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              AppBar(
                centerTitle: true,
                backgroundColor: Constants.mainColor,
                title: new Text(
                  'Wallet',
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => CreditCardScreen(),
                            maintainState: false)),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 75,
                      child: Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.credit_card,
                                    color: Colors.blueGrey),
                                Expanded(
                                  child: Text(
                                    'Add Payment Method',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  child: InkWell(
                    onTap: () => Navigator.of(context).pushNamed(DirectDeposit.routeName),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: double.infinity,
                      height: 75,
                      child: Column(
                        children: <Widget>[
                          Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.account_balance,
                                    color: Colors.blueGrey),
                                Expanded(
                                  child: Text(
                                    ' Enroll in Direct Deposit',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Text(
                  'Default Payment Method:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Comfortaa',
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Credit Card\n ending in ${lastDefaultDigits != null ? lastDefaultDigits : "XXXX"}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontFamily: 'Comfortaa',
                                fontSize: 15),
                          ),
                          OutlineButton(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      fullscreenDialog: true,
                                      builder: (context) => CardScreen(chooseDefault: true, chooseForJourney: false),
                                      maintainState: false));
                            },
                            child: Text(
                              "Change",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Constants.mainColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),         
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: SizedBox(
                          width: mediaQuery.size.width * 0.5,
                          height: mediaQuery.size.height * 0.07,
                          child: RaisedButton(
                            elevation: 0.5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.0)),
                            textColor: Colors.white,
                            color: Constants.accentColor,
                            child: const Text('Claim Credit',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                            onPressed: () {
                              Navigator.of(context).pushNamed(DirectDeposit.routeName);
                            },
                          )),
              ),
            ],
          ),
        ),);
  }
}
