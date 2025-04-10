import 'package:flutter/material.dart';

void main() => runApp(MyWeatherApp());

class MyWeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue[50],
      ),
      home: WeatherHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Fake weather data
Map<String, Map<String, String>> weatherData = {
  "pondicherry": {
    "temperature": "31°C",
    "weather": "Cloudy",
    "date": "Thursday, April 10",
  },
  "chennai": {
    "temperature": "35°C",
    "weather": "Hot & Sunny",
    "date": "Thursday, April 10",
  },
  "hyderabad": {
    "temperature": "29°C",
    "weather": "Light Showers",
    "date": "Thursday, April 10",
  },
  "bangalore": {
    "temperature": "26°C",
    "weather": "Cool Breeze",
    "date": "Thursday, April 10",
  },
};

class WeatherHomePage extends StatefulWidget {
  @override
  _WeatherHomePageState createState() => _WeatherHomePageState();
}

class _WeatherHomePageState extends State<WeatherHomePage> {
  String? selectedCity;
  Map<String, String>? currentData;

  void searchCity(String input) {
    String cityKey = input.trim().toLowerCase();
    if (weatherData.containsKey(cityKey)) {
      setState(() {
        selectedCity = capitalize(cityKey);
        currentData = weatherData[cityKey];
      });
    } else {
      setState(() {
        selectedCity = null;
        currentData = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Oops! Weather for '$input' not available.")),
      );
    }
  }

  String capitalize(String s) =>
      s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : s;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Weather"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Type a city like Chennai...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: searchCity,
            ),

            SizedBox(height: 30),

            // Show weather only if data is available
            if (currentData != null) ...[
              Text(
                selectedCity!,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                currentData!["date"]!,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 30),
              Text(
                currentData!["temperature"]!,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                currentData!["weather"]!,
                style: TextStyle(fontSize: 24),
              ),
            ] else ...[
              Text(
                "No city selected",
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
