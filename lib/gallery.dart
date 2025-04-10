
// flutter_riverpod: ^2.0.0
// hive: ^2.2.3
// hive_flutter: ^1.1.0
// path_provider: ^2.0.11
// image_picker: ^1.0.0
// http: ^0.13.6
// cached_network_image: ^3.3.0

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ImageGallery extends StatefulWidget {
  const ImageGallery({super.key});

  @override
  _ImageGalleryState createState() => _ImageGalleryState();
}

class _ImageGalleryState extends State<ImageGallery> {
  late Future<List<String>> imageUrlsFuture;

  @override
  void initState() {
    super.initState();
    imageUrlsFuture = fetchImages();
  }

  Future<List<String>> fetchImages() async {
    const String apiUrl = 'https://picsum.photos/v2/list?page=1&limit=20';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<String> urls = data.map((item) => item['download_url'] as String).toList();
        urls.shuffle();
        return urls;
      } else {
        debugPrint("Error: HTTP ${response.statusCode}");
        return [];
      }
    } catch (e) {
      debugPrint('Error fetching images: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            imageUrlsFuture = fetchImages();
          });
        },
        child: FutureBuilder<List<String>>(
          future: imageUrlsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 50, color: Colors.red),
                    const SizedBox(height: 10),
                    const Text("Failed to load images. Please try again."),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          imageUrlsFuture = fetchImages();
                        });
                      },
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            List<String> imageUrls = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = (constraints.maxWidth ~/ 150).clamp(2, 4);
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return kIsWeb
                          ? Image.network(
                        imageUrls[index],
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error, color: Colors.red),
                        fit: BoxFit.cover,
                      )
                          : CachedNetworkImage(
                        imageUrl: imageUrls[index],
                        placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error, color: Colors.red),
                        fit: BoxFit.cover,
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            imageUrlsFuture = fetchImages();
          });
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
