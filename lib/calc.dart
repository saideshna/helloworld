import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = '';
  String result = '';

  void onPressed(String value) {
    setState(() {
      if (value == 'C') {
        input = '';
        result = '';
      } else if (value == '=') {
        result = evaluate(input);
      } else {
        input += value;
      }
    });
  }

  // Simple calculator logic (supports +, -, *, /)
  String evaluate(String expression) {
    try {
      expression = expression.replaceAll('×', '*').replaceAll('÷', '/');
      List<String> tokens = tokenize(expression);

      // Handle multiplication and division first
      for (int i = 0; i < tokens.length; i++) {
        if (tokens[i] == '*' || tokens[i] == '/') {
          double left = double.parse(tokens[i - 1]);
          double right = double.parse(tokens[i + 1]);
          double res = tokens[i] == '*' ? left * right : left / right;
          tokens.replaceRange(i - 1, i + 2, [res.toString()]);
          i = -1; // Restart loop
        }
      }

      // Then handle addition and subtraction
      double total = double.parse(tokens[0]);
      for (int i = 1; i < tokens.length; i += 2) {
        double next = double.parse(tokens[i + 1]);
        if (tokens[i] == '+') total += next;
        if (tokens[i] == '-') total -= next;
      }

      return total.toStringAsFixed(2);
    } catch (e) {
      return 'Error';
    }
  }

  // Tokenize the expression
  List<String> tokenize(String expr) {
    List<String> tokens = [];
    String num = '';

    for (int i = 0; i < expr.length; i++) {
      String ch = expr[i];
      if ('0123456789.'.contains(ch)) {
        num += ch;
      } else if ('+-*/'.contains(ch)) {
        if (num.isNotEmpty) tokens.add(num);
        tokens.add(ch);
        num = '';
      }
    }
    if (num.isNotEmpty) tokens.add(num);

    return tokens;
  }

  Widget button(String value) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(2),
        child: ElevatedButton(
          onPressed: () => onPressed(value),
          child: Text(value),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Basic Calculator")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(input, style: TextStyle(fontSize: 24)),
                SizedBox(height: 5),
                Text(result, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Row(children: [button('7'), button('8'), button('9'), button('/')]),
                Row(children: [button('4'), button('5'), button('6'), button('*')]),
                Row(children: [button('1'), button('2'), button('3'), button('-')]),
                Row(children: [button('0'), button('.'), button('C'), button('+')]),
                Row(children: [button('=')]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
