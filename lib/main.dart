import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState () {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questionIndex = 0;

  void answerQuestion() {
    setState(() {
      questionIndex = questionIndex + 1;
    });
    print(questionIndex);
  }

  @override
  Widget build(BuildContext context) {
    var questions = ["What's your fav colour?", "Whats your favourite animal?"];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My App Title"),
        ),
        body: Column(
          children: [
            Text(questions.elementAt(questionIndex)),
            RaisedButton(
              child: Text('Answer 1'),
              onPressed: answerQuestion,
            ),
            RaisedButton(
              child: Text('Answer 2'),
              onPressed: () => print('Answer 2 chosen'),
            ),
            RaisedButton(
              child: Text('Answer 3'),
              onPressed: () {
                print('awswer 3 chosen');
              },
            ),
          ],
        ),
      ),
    );
  }
}

//    return MaterialApp(home: Text('Hello Aaryn!'));
//  }
//}
