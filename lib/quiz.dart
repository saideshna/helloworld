import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

  // flutter_riverpod: ^2.4.9  

void main() {
  runApp(ProviderScope(child: QuizApp()));
}

// 📌 Question Model
class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}

// 📌 Quiz Questions (Hardcoded)
final List<Question> questions = [
  Question(
    question: "What is the capital of France?",
    options: ["Paris", "London", "Berlin", "Madrid"],
    correctAnswer: 0,
  ),
  Question(
    question: "What is 2 + 2?",
    options: ["3", "4", "5", "6"],
    correctAnswer: 1,
  ),
  Question(
    question: "Which planet is known as the Red Planet?",
    options: ["Earth", "Mars", "Jupiter", "Saturn"],
    correctAnswer: 1,
  ),
  Question(
    question: "What is the largest ocean on Earth?",
    options: ["Atlantic", "Indian", "Pacific", "Arctic"],
    correctAnswer: 2,
  ),
  Question(
    question: "Who wrote 'Romeo and Juliet'?",
    options: ["Shakespeare", "Hemingway", "Tolstoy", "Austen"],
    correctAnswer: 0,
  ),
];

// 📌 Quiz Provider
final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>((ref) {
  return QuizNotifier();
});

// 📌 Quiz State Management
class QuizNotifier extends StateNotifier<QuizState> {
  QuizNotifier() : super(QuizState());

  void loadQuestions() {
    state = state.copyWith(questions: questions, currentIndex: 0, score: 0);
  }

  void answerQuestion(int selectedIndex) {
    final isCorrect =
        selectedIndex == state.questions[state.currentIndex].correctAnswer;
    final newScore = isCorrect ? state.score + 1 : state.score;

    if (state.currentIndex < state.questions.length - 1) {
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        score: newScore,
        timeLeft: 10,
      );
    } else {
      state = state.copyWith(score: newScore, isFinished: true);
    }
  }

  void resetQuiz() {
    state = QuizState(questions: state.questions);
  }

  void updateTimer(int time) {
    state = state.copyWith(timeLeft: time);
  }
}

// 📌 Quiz State
class QuizState {
  final List<Question> questions;
  final int currentIndex;
  final int score;
  final bool isFinished;
  final int timeLeft;

  QuizState({
    this.questions = const [],
    this.currentIndex = 0,
    this.score = 0,
    this.isFinished = false,
    this.timeLeft = 10,
  });

  QuizState copyWith({
    List<Question>? questions,
    int? currentIndex,
    int? score,
    bool? isFinished,
    int? timeLeft,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      score: score ?? this.score,
      isFinished: isFinished ?? this.isFinished,
      timeLeft: timeLeft ?? this.timeLeft,
    );
  }
}

// 📌 Main App
class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuizScreen(),
    );
  }
}

// 📌 Quiz Screen UI
class QuizScreen extends ConsumerStatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _loadQuestions() {
    Future.microtask(() {
      ref.read(quizProvider.notifier).loadQuestions();
      _startTimer();
    });
  }


  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final timeLeft = ref.read(quizProvider).timeLeft;
      if (timeLeft > 0) {
        ref.read(quizProvider.notifier).updateTimer(timeLeft - 1);
      } else {
        ref.read(quizProvider.notifier).answerQuestion(-1); // Auto move to next
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);

    if (quizState.isFinished) {
      return Scaffold(
        appBar: AppBar(title: Text("Quiz Finished")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Your Score: ${quizState.score} / ${quizState.questions.length}",
                  style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ref.read(quizProvider.notifier).resetQuiz();
                  _startTimer();
                },
                child: Text("Restart Quiz"),
              ),
            ],
          ),
        ),
      );
    }

    final question = quizState.questions[quizState.currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Quiz App")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Question ${quizState.currentIndex + 1}/${quizState.questions.length}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text(question.question, style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: quizState.timeLeft / 10,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 10),
            Text("Time Left: ${quizState.timeLeft}s", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ...List.generate(question.options.length, (index) {
              return ElevatedButton(
                onPressed: () {
                  ref.read(quizProvider.notifier).answerQuestion(index);
                  _startTimer();
                },
                child: Text(question.options[index]),
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
