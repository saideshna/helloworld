import 'package:flutter/material.dart';

void main() {
  runApp(BMIApp());
}

class BMIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BMIScreen(),
    );
  }
}

class BMIScreen extends StatefulWidget {
  @override
  _BMIScreenState createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  double? _bmi;
  String _category = "";

  void _calculateBMI() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      setState(() {
        _bmi = null;
        _category = "Please enter valid height and weight!";
      });
      return;
    }

    final heightMeters = height / 100;
    final bmi = weight / (heightMeters * heightMeters);

    String result;
    if (bmi < 18.5) {
      result = "Underweight";
    } else if (bmi < 24.9) {
      result = "Normal";
    } else if (bmi < 29.9) {
      result = "Overweight";
    } else {
      result = "Obese";
    }

    setState(() {
      _bmi = bmi;
      _category = result;
    });
  }

  Widget _buildInputCard(String label, String hint, IconData icon, TextEditingController controller) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hint,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    return Card(
      color: Colors.deepPurple.shade50,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              _bmi != null ? 'Your BMI is: ${_bmi!.toStringAsFixed(2)}' : '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            if (_category.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  _category,
                  style: TextStyle(fontSize: 20, color: Colors.deepPurple),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildInputCard("Height", "Enter height in cm", Icons.height, _heightController),
            SizedBox(height: 20),
            _buildInputCard("Weight", "Enter weight in kg", Icons.monitor_weight, _weightController),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _calculateBMI,
              icon: Icon(Icons.calculate),
              label: Text('Calculate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                textStyle: TextStyle(fontSize: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            if (_bmi != null || _category.isNotEmpty) _buildResultCard(),
          ],
        ),
      ),
    );
  }
}
