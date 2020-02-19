import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_app/theme/constants.dart' as Constants;
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import '../models/credit_card.dart';
import '../models/credit_card_form.dart';


class CreditCardScreen extends StatefulWidget {
  static final routeName = 'credit_card';

  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  Color cardbgColor = Constants.mainColor;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return
     Scaffold(
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: Constants.mainColor,
        title: new Text(
            'Givngo',
            style: TextStyle(),
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
          children: <Widget>[
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              height: 170,
              cardbgColor: cardbgColor,
              animationDuration: Duration(milliseconds: 800),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: CreditCardForm(
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
              ),
            ),    
          ],
          ),
      ),
    );
  }

    void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}