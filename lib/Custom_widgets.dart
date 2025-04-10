import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Widgets Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: CustomWidgetsScreen(),
    );
  }
}

class CustomWidgetsScreen extends StatelessWidget {
  final List<Map<String, String>> cardData = [
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRXQ3iElbcetcETXY2nTBFqs2nEG-2tajwdJg&s",
      "title": "Stranger Things",
      "description":
      "A supernatural mystery where young friends uncover hidden secrets.",
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThm32LJtzr7kV13MzjBnKsCtPVJ7cwNPoItQ&s",
      "title": "How I Met Your Mother",
      "description":
      "A hilarious story about love, friendship, and life's unexpected turns.",
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpYn8jbafndBgeXahEKPBJe_jen5nl5SGBsw&s",
      "title": "Money Heist",
      "description":
      "A thrilling drama of a mastermind orchestrating the greatest heist.",
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJ0rUlo0kFgaFQEA1wtkYn7I8NOgnjQ8XC7A&s",
      "title": "Breaking Bad",
      "description":
      "A high school teacher turned methamphetamine kingpin faces moral dilemmas.",
    },
    {
      "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ074Dr6g6xvvrcMS2AcEr27N4UOcvNXhLDeA&s",
      "title": "Never Have I Ever",
      "description":
      "A coming-of-age comedy following an Indian-American teenager's life.",
    },
    {
      "image":
      "https://rukminim2.flixcart.com/image/850/1000/l3ys70w0/poster/h/h/i/large-the-boys-poster-18-x-12-inch-300-gsm-t0146-original-imagezak7gjjk6nu.jpeg?q=90&crop=false",
      "title": "The Boys",
      "description":
      "A gritty series exposing the darker side of superheroes in a corrupt world.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Widgets"),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: cardData.length,
        itemBuilder: (context, index) {
          return CustomCard(
            image: cardData[index]["image"]!,
            title: cardData[index]["title"]!,
            description: cardData[index]["description"]!,
          );
        },
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const CustomCard({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.network(
              image,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade800,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
