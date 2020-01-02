import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '../models/exception_handler.dart';
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
            'number': newUserCard.number,
            'expiry': newUserCard.expiry,
            'securityCode': newUserCard.securityCode,
            'isDefault': newUserCard.isDefault
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
    //no token or userId here, when coming back to map...
    print('token get user userCards $token');
    final List<UserCard> userCardsLoaded = [];
    var url;
    // if (token == null) {
    //   url =
    //       'https://capstone-addb0.firebaseio.com/userCards.json&orderBy="userId"&equalTo="$userId"';
    // } else {
      url =
          'https://capstone-addb0.firebaseio.com/cards.json?auth=$token&orderBy="userId"&equalTo="$userId"';
      final response = await http.get(url).then(
        (response) {
          if (response.statusCode < 200 ||
              response.statusCode >= 400 ||
              json == null) {
            //handle exceptions
            throw ExceptionHandler(response.body);
          } else {
            final data = json.decode(response.body) as Map<String, dynamic>;
            // print(json.decode(response.body));
            print('got user userCard data: $data');

            // if (data != null) {
            print(data);
            data.forEach((userCardId, userCardData) {
              //watch out for called on null
              print(userCardId);
              userCardsLoaded.add(
                //loads the userCards when called
                UserCard(
                    id: userCardId,
                    userId: userCardData['userId'],
                    name: userCardData['name'],
                    number: userCardData['number'],
                    expiry: userCardData['expiry'],
                    securityCode: userCardData['securityCode'],
                    isDefault: userCardData['isDefault']
                    ),
              );
            });
            _userCards = userCardsLoaded;
            notifyListeners();
          }
        },
      );
    // }
  }

  UserCard findById(String id) {
    return userCards.firstWhere((userCard) => userCard.id == id);
  }

  UserCard findByUserId(String userId) {
    return userCards.firstWhere((userCard) => userCard.userId == userId);
  }

  //add userCard to the users userCard list
  void addUserCard(UserCard userCard, [String _token]) {
    print('token add userCard $_token');
    final url = 'https://capstone-addb0.firebaseio.com/cards.json?auth=$_token';
    http
        .post(url,
            body: json.encode({
              'userId': userCard.userId,
              'name': userCard.name,
              'number': userCard.number,
              'expiry': userCard.expiry,
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
          id: json.decode(response.body)["name"], //'name' is the id of the userCard
          userId: userCard.userId,
          name: userCard.name,
          number: userCard.number,
          expiry: userCard.expiry,
          securityCode: userCard.securityCode,
          isDefault: userCard.isDefault
        );
        print('newuserCard id: ${newUserCard.id}');
        print('newuserCard userId: ${newUserCard.userId}');
        print('token add userCard $token');
        userCards.add(newUserCard);
        notifyListeners();
      }
      },
    );
  }
}
