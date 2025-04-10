import 'package:flutter/material.dart';

class BMICalculatorScreen extends StatefulWidget {
  const BMICalculatorScreen({Key? key}) : super(key: key);

  @override
  State<BMICalculatorScreen> createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightInchesController = TextEditingController();

  double? _bmiResult;
  String? _bmiCategory;

  void _calculateBMI() {
    final double? weight = double.tryParse(_weightController.text);
    final double? heightInches = double.tryParse(_heightInchesController.text);

    if (weight != null && heightInches != null && heightInches > 0) {
      final double heightMeters =
          heightInches * 0.0254; // 1 inch = 0.0254 meters
      final double bmi = weight / (heightMeters * heightMeters);

      String category;
      if (bmi < 18.5) {
        category = 'Underweight';
      } else if (bmi < 25) {
        category = 'Normal';
      } else if (bmi < 30) {
        category = 'Overweight';
      } else {
        category = 'Obese';
      }

      setState(() {
        _bmiResult = bmi;
        _bmiCategory = category;
      });
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text(
            'Please enter valid numbers for weight and height in inches.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildResult() {
    if (_bmiResult == null) return const SizedBox.shrink();

    return Column(
      children: [
        Text(
          'Your BMI: ${_bmiResult!.toStringAsFixed(2)}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Category: $_bmiCategory',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInputField(
                label: 'Enter weight (kg)',
                controller: _weightController,
              ),
              const SizedBox(height: 16),
              _buildInputField(
                label: 'Enter height (inches)',
                controller: _heightInchesController,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateBMI,
                child: const Text('Calculate BMI'),
              ),
              const SizedBox(height: 24),
              _buildResult(),
            ],
          ),
        ),
      ),
    );
  }
}
