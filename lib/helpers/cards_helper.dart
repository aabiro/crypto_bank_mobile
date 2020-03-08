import 'package:encrypt/encrypt.dart' as Encrypter;

class CardsHelper {

  static String encryptCard(String cardNumber) {
    //Salsa20
    final plainText = cardNumber;
    final key = Encrypter.Key.fromLength(32);
    final iv = Encrypter.IV.fromLength(8);
    final encrypter = Encrypter.Encrypter(Encrypter.Salsa20(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // final decrypted = encrypter.decrypt(encrypted, iv: iv); //to dycrypt
    print('encrypted : $encrypted');
    return encrypted.base64;
  }

  static String decryptCard(String cardNumber){
    // final Encrypter.Encrypted plainText = cardNumber as Encrypter.Encrypted;
    // needs encrypted class 
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