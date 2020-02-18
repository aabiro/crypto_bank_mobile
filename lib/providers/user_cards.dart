import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../models/exception_handler.dart';
import '../helpers/cards_helper.dart';
import 'user_card.dart';

class UserCards with ChangeNotifier {
  String token;
  String userId;
  List<UserCard> _userCards = [];

  UserCards([this.token, this.userId, this._userCards]);

  List<UserCard> get userCards {
    return _userCards;
  }

  Future<void> updateUserCard(String id, UserCard newUserCard) async {
    final userCardIndex = userCards.indexWhere((userCard) => userCard.id == id);
    if (userCardIndex >= 0) {
      final url =
          "https://capstone-addb0.firebaseio.com/cards/$id.json?auth=$token";
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'userId': newUserCard.userId,
            'name': newUserCard.name,
            'number': CardsHelper.encryptCard(newUserCard.number),
            'expiry': newUserCard.expiry,
            'lastFourDigits': newUserCard.lastFourDigits,
            'securityCode': newUserCard.securityCode,
            'isDefault': newUserCard.isDefault
          },
        ),
      );
      if (response.statusCode >= 400) {
        print(response.statusCode);
        print("${response.toString()}");
        throw ExceptionHandler('Cannot update userCard.');
      }
      userCards[userCardIndex] = newUserCard;
      notifyListeners();
    } else {
      print('did not update');
    }
  }

  Future<void> deleteUserCard(String id) async {
    print('delete id: $id');
    final url =
        "https://capstone-addb0.firebaseio.com/cards/$id.json?auth=$token";
    //has been added to user userCards
    final userCardIndex = userCards.indexWhere((userCard) => userCard.id == id);
    var userCard = userCards[userCardIndex];
    print('delete userCard id: ${userCard.id}, at index $userCardIndex');
    userCards.removeAt(userCardIndex);
    notifyListeners();
    final response = await http.delete(url);
    // var data = json.decode(response);
    if (response.statusCode >= 400) {
      print(response.statusCode);
      print("$response");
      userCards.insert(userCardIndex,
          userCard); //keep userCard if the delete did not work, optimistic updating
      notifyListeners();
      throw ExceptionHandler('Cannot delete userCard.');
    }
    userCard = null;
  }

  Future<void> getUserUserCards() async {
    final List<UserCard> userCardsLoaded = [];
    var url;
    url =
        'https://capstone-addb0.firebaseio.com/cards.json?auth=$token&orderBy="userId"&equalTo="$userId"';
    final response = await http.get(url).then(
      (response) {
        if (response.statusCode < 200 ||
            response.statusCode >= 400 ||
            json == null) {
          throw ExceptionHandler(response.body);
        } else {
          final data = json.decode(response.body) as Map<String, dynamic>;
          print('got user userCard data: $data');
          print(data);
          data.forEach(
            (userCardId, userCardData) {
              print(userCardId);
              userCardsLoaded.add(
                UserCard(
                    id: userCardId,
                    userId: userCardData['userId'],
                    name: userCardData['name'],
                    number: userCardData['number'],
                    expiry: userCardData['expiry'],
                    lastFourDigits: userCardData['lastFourDigits'],
                    securityCode: userCardData['securityCode'],
                    isDefault: userCardData['isDefault']),
              );
            },
          );
          _userCards = userCardsLoaded;
          notifyListeners();
        }
      },
    );
  }

  UserCard findById(String id) {
    return userCards.firstWhere((userCard) => userCard.id == id);
  }

  UserCard findByUserId(String userId) {
    return userCards.firstWhere((userCard) => userCard.userId == userId);
  }

  void getDefaultPayment(){
    //after scan go to payment --create default
    //call for users cards as default 
    //if 1 then continue
    //if none check if square //if square enter card
    //if none ask go to pick default screen 
  }

  void updateDefault(String id, UserCard newDefaultUserCard) async {
    final oldDefaultIndex = userCards.indexWhere(
        (userCard) => userCard.userId == userId && userCard.isDefault == true);
    final userCardIndex =
        userCards.indexWhere((userCard) => userCard.id == newDefaultUserCard.id);

    if (oldDefaultIndex >= 0) {
      final oldDefaultCard = userCards[oldDefaultIndex];
      oldDefaultCard.toggleDefault();
      print('old default id ${oldDefaultCard.id}');
      final url =
          "https://capstone-addb0.firebaseio.com/cards/${oldDefaultCard.id}.json?auth=$token";
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'userId': oldDefaultCard.userId,
            'name': oldDefaultCard.name,
            'number': CardsHelper.encryptCard(oldDefaultCard.number),
            'expiry': oldDefaultCard.expiry,
            'lastFourDigits': oldDefaultCard.lastFourDigits,
            'securityCode': oldDefaultCard.securityCode,
            'isDefault': false
          },
        ),
      );
      if (response.statusCode >= 400) {
        print(response.statusCode);
        print("${response.toString()}");
        // print('response $data');
        // userCards.insert(userCardIndex, userCard); //keep userCard if the delete did not work, optimistic updating
        // notifyListeners();
        throw ExceptionHandler('Cannot update  old default userCard.');
      }
      userCards[oldDefaultIndex] = oldDefaultCard;
      notifyListeners();
    } else {
      print(' old default card did not update / or no old default card ');
    }

    // update new default
    print(userCardIndex);
    if (userCardIndex >= 0) {
      final url =
          "https://capstone-addb0.firebaseio.com/cards/$id.json?auth=$token";
      final response = await http.patch(
        url,
        body: json.encode(
          {
            'userId': newDefaultUserCard.userId,
            'name': newDefaultUserCard.name,
            'number': CardsHelper.encryptCard(newDefaultUserCard.number),
            'expiry': newDefaultUserCard.expiry,
            'lastFourDigits': newDefaultUserCard.lastFourDigits,
            'securityCode': newDefaultUserCard.securityCode,
            'isDefault': true
          },
        ),
      );
      if (response.statusCode >= 400) {
        print(response.statusCode);
        print("${response.toString()}");
        // print('response $data');
        // userCards.insert(userCardIndex, userCard); //keep userCard if the delete did not work, optimistic updating
        // notifyListeners();
        throw ExceptionHandler('Cannot update userCard.');
      }
      newDefaultUserCard.toggleDefault();
      userCards[userCardIndex] = newDefaultUserCard;
      notifyListeners();
    } else {
      print('did not update');
    }
    // notifyListeners();
  }

  //add userCard to the users userCard list
  void addUserCard(UserCard userCard) {
    final url = 'https://capstone-addb0.firebaseio.com/cards.json?auth=$token';
    http
        .post(url,
            body: json.encode({
              'userId': userCard.userId,
              'name': userCard.name,
              'number': CardsHelper.encryptCard(userCard.number),
              'expiry': userCard.expiry,
              'lastFourDigits': userCard.lastFourDigits,
              'securityCode': userCard.securityCode,
              'isDefault': userCard.isDefault
            }))
        .then(
      (response) {
        if (response.statusCode < 200 ||
            response.statusCode >= 400 ||
            json == null) {
          //handle exceptions
          throw ExceptionHandler(response.body);
        } else {
          var data = json.decode(response.body);
          print('response $data');
          final newUserCard = UserCard(
              id: json.decode(
                  response.body)["name"], //'name' is the id of the userCard
              userId: userCard.userId,
              name: userCard.name,
              number: userCard.number,
              expiry: userCard.expiry,
              lastFourDigits: userCard.lastFourDigits,
              securityCode: userCard.securityCode,
              isDefault: userCard.isDefault);
          print('newuserCard id: ${newUserCard.id}');
          print('newuserCard userId: ${newUserCard.userId}');
          userCards.add(newUserCard);
        }
      },
    );
    notifyListeners();
  }
}
