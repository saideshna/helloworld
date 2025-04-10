import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image and Icons Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: ImageAndIconsScreen(),
    );
  }
}

class ImageAndIconsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image and Icons"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Featured Image",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                "https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwzNjUyOXwwfDF8c2VhcmNofDJ8fHdvcmt8ZW58MHx8fHwxNjczMTI1NjEy&ixlib=rb-1.2.1&q=80&w=400",
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Icons",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.coffee, size: 50, color: Colors.brown),
                    SizedBox(height: 8),
                    Text("Coffee", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.shopping_cart, size: 50, color: Colors.teal),
                    SizedBox(height: 8),
                    Text("Cart", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.camera_alt, size: 50, color: Colors.purple),
                    SizedBox(height: 8),
                    Text("Camera", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.flight_takeoff, size: 50, color: Colors.blue),
                    SizedBox(height: 8),
                    Text("Travel", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.music_note, size: 50, color: Colors.orange),
                    SizedBox(height: 8),
                    Text("Music", style: TextStyle(fontSize: 16)),
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.fastfood, size: 50, color: Colors.red),
                    SizedBox(height: 8),
                    Text("Food", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
