import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/providers/user_card.dart';
import 'package:flutter_app/screens/activation_complete.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/theme/constants.dart' as Constants;
import '../theme/secrets.dart' as Secrets;
import 'package:http/http.dart';
import 'package:encrypt/encrypt.dart' as Encrypter;

class CardsHelper {
  

  // print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  // print(encrypted.base64); // R4P

  static String encryptCard(String cardNumber) {
    final plainText = cardNumber;
    final key = Encrypter.Key.fromLength(32);
    final iv = Encrypter.IV.fromLength(8);
    final encrypter = Encrypter.Encrypter(Encrypter.Salsa20(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    print('encrypted : $encrypted');
    return encrypted.base64;
  }

  static String decryptCard(String cardNumber){
    final plainText = cardNumber;
    final key = Encrypter.Key.fromLength(32);
    final iv = Encrypter.IV.fromLength(8);
    final encrypter = Encrypter.Encrypter(Encrypter.Salsa20(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    print('decrypted : $decrypted');
    return decrypted.toString();
  }
}