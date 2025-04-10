import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CalculatorApp(),
  ));
}

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String result = "0";
  double num1 = 0;
  double num2 = 0;
  String op = "";

  void handleButton(String btn) {
    setState(() {
      if (btn == "C") {
        result = "0";
        num1 = 0;
        num2 = 0;
        op = "";
      } else if (["+", "-", "*", "/"].contains(btn)) {
        num1 = double.parse(result);
        op = btn;
        result = "0";
      } else if (btn == "=") {
        num2 = double.parse(result);
        if (op == "+") result = (num1 + num2).toString();
        if (op == "-") result = (num1 - num2).toString();
        if (op == "*") result = (num1 * num2).toString();
        if (op == "/") result = (num1 / num2).toString();
      } else {
        result = result == "0" ? btn : result + btn;
      }
    });
  }

  Widget buildButton(String text) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: ElevatedButton(
          onPressed: () => handleButton(text),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(22),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(text, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                result,
                style: const TextStyle(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Row(children: [
            buildButton("7"),
            buildButton("8"),
            buildButton("9"),
            buildButton("/")
          ]),
          Row(children: [
            buildButton("4"),
            buildButton("5"),
            buildButton("6"),
            buildButton("*")
          ]),
          Row(children: [
            buildButton("1"),
            buildButton("2"),
            buildButton("3"),
            buildButton("-")
          ]),
          Row(children: [
            buildButton("C"),
            buildButton("0"),
            buildButton("="),
            buildButton("+")
          ]),
        ],
      ),
    );
  }
}
