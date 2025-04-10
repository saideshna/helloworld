import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Simple Quiz App',
    debugShowCheckedModeBanner: false,
    home: QuizApp(),
  ));
}

class Question {
  final String text;
  final List<String> options;
  final int correctIndex;

  Question(this.text, this.options, this.correctIndex);
}

class QuizApp extends StatefulWidget {
  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Question> questions = [
    Question('Capital of India?', ['Mumbai', 'Delhi', 'Chennai', 'Kolkata'], 1),
    Question('Which is a programming language?', ['Python', 'Snake', 'Lion', 'Tiger'], 0),
    Question('Who wrote Macbeth?', ['Shakespeare', 'Homer', 'Tolstoy', 'Dickens'], 0),
    Question('Fastest bird?', ['Sparrow', 'Crow', 'Falcon', 'Eagle'], 2),
    Question('Water formula?', ['H2O', 'CO2', 'NaCl', 'O2'], 0),
    Question('Planet known as Red Planet?', ['Earth', 'Venus', 'Mars', 'Jupiter'], 2),
    Question('Sun rises in?', ['West', 'East', 'North', 'South'], 1),
    Question('How many days in a leap year?', ['365', '366', '367', '364'], 1),
  ];

  int currentQuestion = 0;
  int score = 0;
  int timeLeft = 20;
  Timer? timer;

  void startTimer() {
    timeLeft = 20;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          nextQuestion();
        }
      });
    });
  }

  void checkAnswer(int selected) {
    if (selected == questions[currentQuestion].correctIndex) {
      score++;
    }
    nextQuestion();
  }

  void nextQuestion() {
    timer?.cancel();
    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
      startTimer();
    } else {
      showResult();
    }
  }

  void showResult() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Quiz Over'),
        content: Text('You scored $score out of ${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetQuiz();
            },
            child: Text('Restart'),
          )
        ],
      ),
    );
  }

  void resetQuiz() {
    setState(() {
      currentQuestion = 0;
      score = 0;
    });
    startTimer();
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var q = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(title: Text('Simple GK Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Time left: $timeLeft sec', style: TextStyle(fontSize: 18, color: Colors.red)),
            SizedBox(height: 20),
            Text('Q${currentQuestion + 1}: ${q.text}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ...List.generate(
              q.options.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => checkAnswer(index),
                  child: Text(q.options[index]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
