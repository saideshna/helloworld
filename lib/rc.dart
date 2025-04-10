// Importing the Flutter material package. This is necessary to use widgets provided by Flutter.
import 'package:flutter/material.dart';

// The main function is the starting point of any Flutter app.
void main() {
  runApp(MyApp()); // Calling MyApp, which is the root widget of the application.
}

// MyApp is the main widget of the app.
// It extends StatelessWidget, which means this widget does not change (it's immutable).
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The build method returns the structure of the widget.
    return MaterialApp(
      home: Scaffold(
        // The Scaffold widget provides a basic structure for the app (like app bar, body, etc.).
        appBar: AppBar(
          // AppBar displays a bar at the top of the screen.
          title: Text('Column and Row Layouts'), // The title of the app bar.
        ),
        body: Padding(
          // Padding adds space around the entire content inside the body.
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // A Column widget arranges its children vertically.
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start of the column.
            children: [
              // Title text widget
              Text(
                'Title', // This is the text displayed.
                style: TextStyle(
                  fontSize: 24, // Font size for the text.
                  fontWeight: FontWeight.bold, // Makes the text bold.
                ),
              ),
              SizedBox(height: 8), // Adds vertical spacing between widgets.

              // Description text widget
              Text(
                'This is a description of the column layout. Here we showcase title, description, and an image.',
                style: TextStyle(fontSize: 16), // Font size for the text.
              ),
              SizedBox(height: 8), // Adds vertical spacing between widgets.

              // Image widget
              Image.network(
                'https://media.istockphoto.com/id/485371557/photo/twilight-at-spirit-island.jpg?s=612x612&w=0&k=20&c=FSGliJ4EKFP70Yjpzso0HfRR4WwflC6GKfl4F3Hj7fk=', // A placeholder image from the internet.
                height: 150, // Height of the image.
                width: double.infinity, // Makes the image stretch to full width.
                fit: BoxFit.cover, // Ensures the image covers the area without distortion.
              ),
              SizedBox(height: 16), // Adds spacing between the column and row sections.

              // Divider widget to visually separate the sections
              Divider(thickness: 2), // A line to separate layouts.

              // Title for the row section
              Text(
                'Icons with Labels', // Text displayed for the section title.
                style: TextStyle(
                  fontSize: 20, // Font size for the text.
                  fontWeight: FontWeight.bold, // Makes the text bold.
                ),
              ),
              SizedBox(height: 8), // Adds vertical spacing.

              // Row widget to display icons with labels horizontally.
              Row(
                // Aligns the child widgets in the row with equal spacing between them.
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // First column inside the row: Icon and its label.
                  Column(
                    children: [
                      Icon(
                        Icons.home, // Displays a "home" icon.
                        size: 40, // Size of the icon.
                        color: Colors.blue, // Color of the icon.
                      ),
                      SizedBox(height: 4), // Spacing between the icon and label.
                      Text('Home'), // Label for the icon.
                    ],
                  ),

                  // Second column inside the row: Icon and its label.
                  Column(
                    children: [
                      Icon(
                        Icons.search, // Displays a "search" icon.
                        size: 40, // Size of the icon.
                        color: Colors.green, // Color of the icon.
                      ),
                      SizedBox(height: 4), // Spacing between the icon and label.
                      Text('Search'), // Label for the icon.
                    ],
                  ),

                  // Third column inside the row: Icon and its label.
                  Column(
                    children: [
                      Icon(
                        Icons.settings, // Displays a "settings" icon.
                        size: 40, // Size of the icon.
                        color: Colors.orange, // Color of the icon.
                      ),
                      SizedBox(height: 4), // Spacing between the icon and label.
                      Text('Settings'), // Label for the icon.
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}