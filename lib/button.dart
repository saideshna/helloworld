import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Button Click Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ButtonClickScreen(),
    );
  }
}

class ButtonClickScreen extends StatefulWidget {
  const ButtonClickScreen({super.key});

  @override
  State<ButtonClickScreen> createState() => _ButtonClickScreenState();
}

class _ButtonClickScreenState extends State<ButtonClickScreen> {
  String _message = "Press the button!";

  void _updateText() {
    setState(() {
      _message = "Button Clicked!";
    });
  }

  void _showSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: const Text("Button Clicked!"),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.blue,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Button Click'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _message,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateText();
                _showSnackBar(context);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text("Click Me!"),
            ),
          ],
        ),
      ),
    );
  }
}
