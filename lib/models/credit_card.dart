import 'dart:core';

import 'package:flutter/material.dart';

class CreditCardModel {
  
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused = false;
  Colors cardbgColor;
  int height;
  TextStyle textStyle;
  int width;
  Duration animationDuration;

  CreditCardModel(
      this.cardNumber,
      this.expiryDate,
      this.cardHolderName,
      this.cvvCode,
      this.isCvvFocused,
      // this.height
      // this.cardbgColor,
      // this.height,
      // this.textStyle,
      // this.width,
      // this.animationDuration
  );
}

// class CreditCardScreen extends StatelessWidget {
//   static final routeName = 'credit_card';
//   @override
//   Widget build(BuildContext context) {
//     return CreditCardWidget(
//         cardNumber: cardNumber,
//         expiryDate: expiryDate,
//         cardHolderName: cardHolderName,
//         cvvCode: cvvCode,
//         showBackView: isCvvFocused,
//         cardbgColor: Colors.black,
//         height: 175,
//         textStyle: TextStyle(color: Colors.yellowAccent),
//         width: MediaQuery.of(context).size.width,
//         animationDuration: Duration(milliseconds: 1000),
//         );
//   }
// }

// class CreditCardModel {

//   CreditCardModel(this.cardNumber, this.expiryDate, this.cardHolderName, this.cvvCode, this.isCvvFocused);

//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
// }