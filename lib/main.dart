import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz_app/questionBank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: QizzPage(),
        ),
      ),
    );
  }
}

class QizzPage extends StatefulWidget {
  @override
  _QizzPageState createState() => _QizzPageState();
}

class _QizzPageState extends State<QizzPage> {
  List<Widget> scoreKeeper = [];

  QuestionBank questionBank = QuestionBank();

  checkAnswer({bool isTrue}) {
    if (questionBank.isEOL()) {

      Alert(
        context: context,
        type: AlertType.warning,
        title: "ALERT",
        desc: "you reached the End of the QUIZZ",
        buttons: [
          DialogButton(
            child: Text(
              "RESTART",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                questionBank.restartQuizz();
                scoreKeeper = [];
              });
              Navigator.pop(context);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
          ),
        ],
      ).show();
    } else {
      if (questionBank.getAnswer() == isTrue) {
        setState(() {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        });
      } else {
        setState(() {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        });
      }
      questionBank.incrementQues();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 6,
          child: Center(
            child: Text(
              questionBank.getQuestions(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: RaisedButton(
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(isTrue: true);
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              padding: EdgeInsets.all(8.0),
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(isTrue: false);
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
            child: Row(
              children: scoreKeeper,
            ),
        ),
      ],
    );
  }
}
