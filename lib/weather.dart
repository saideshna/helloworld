import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//http: ^0.13.6

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WeatherApp(),
  ));
}

class WeatherApp extends StatefulWidget {
  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  TextEditingController cityController = TextEditingController();
  String weather = "";
  String temp = "";
  String icon = "";
  bool loading = false;

  void getWeather(String city) async {
    if (city.isEmpty) return;

    setState(() {
      weather = "Loading...";
      temp = "";
      icon = "";
      loading = true;
    });

    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=211922dc4575ca7aa489da81548a4965&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        temp = "${data['main']['temp']}°C";
        weather = data['weather'][0]['description'];
        icon = data['weather'][0]['icon'];
      });
    } else {
      setState(() {
        weather = "City not found!";
        temp = "";
        icon = "";
      });
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather App"),
        backgroundColor: Colors.grey, // still default for AppBar
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: cityController,
              decoration: InputDecoration(
                hintText: "Enter City",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          TextButton(
            onPressed: () => getWeather(cityController.text),
            child: Text("Get Weather"),
          ),
          SizedBox(height: 20),
          if (loading) CircularProgressIndicator(),
          SizedBox(height: 10),
          if (temp.isNotEmpty) Text(temp),
          if (weather.isNotEmpty) Text(weather),
          if (icon.isNotEmpty)
            Image.network("https://openweathermap.org/img/wn/$icon@2x.png", height: 100),
        ],
      ),
    );
  }
}
