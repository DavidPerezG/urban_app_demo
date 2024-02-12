import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:urban_app/src/screens/image_zoom_screen.dart';
import 'package:urban_app/src/widgets/comments_widget.dart';

class MoodboardScreen extends StatefulWidget {
  @override
  _MoodboardScreenState createState() => _MoodboardScreenState();
}

class _MoodboardScreenState extends State<MoodboardScreen> {
  TextEditingController commentController = TextEditingController();
  List<String>? selectedImages = [
    "https://thewowdecor.com/wp-content/uploads/2015/07/Master-Bedroom.jpeg",
    "https://thewowdecor.com/wp-content/uploads/2015/07/Master-Bedroom-Design-with-Queen-Size-Bed.jpg",
    "https://thewowdecor.com/wp-content/uploads/2015/07/Luxury-And-Elegant-Master-Bedroom-Ideas.jpg"
  ];
  int _currentIndex = 0;

  List<Comment> comments = [
    Comment(
        name: 'Ludov Garcia',
        text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
        images: [
          'https://thewowdecor.com/wp-content/uploads/2015/07/Master-Bedroom.jpeg',
          'https://thewowdecor.com/wp-content/uploads/2015/07/Master-Bedroom.jpg',
          'https://thewowdecor.com/wp-content/uploads/2015/07/Master-Bedroom-Design-with-Queen-Size-Bed.jpg',
          'https://www.designyourway.net/blog/wp-content/uploads/2016/04/64669296959.jpg'
        ]),
    Comment(name: 'Dave P.', text: 'Otro ejemplo de comentario numero 2'),
    Comment(name: 'Dave P.', text: 'Otro ejemplo de comentario numero 2'),
    Comment(name: 'Dave P.', text: 'Otro ejemplo de comentario numero 2'),
  ];

  void _showImageZoomDialog(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageZoomScreen(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moodboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          selectedImages != null
              ? Stack(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250.0,
                        enableInfiniteScroll: false,
                        viewportFraction: 1.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: selectedImages!.map((String imageUrl) {
                        return InkWell(
                          onTap: () {
                            _showImageZoomDialog(imageUrl);
                          },
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: DotsIndicator(
                        dotsCount: selectedImages!.length,
                        position: _currentIndex,
                        decorator: DotsDecorator(
                          color: Colors.grey, // Inactive dot color
                          activeColor: Colors.blue, // Active dot color
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Text(
                    'No selected images',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
          SizedBox(height: 16.0),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    CommentsWidget(comments: comments),
                    SizedBox(height: 16.0),
                    // Add Comment Form

                    ElevatedButton(
                      onPressed: () {
                        // Implement logic to add an image
                        // You can use image picker or any other method
                      },
                      child: Text('Add a Comment'),
                    ),
                    SizedBox(height: 8.0),
                    // Submit Comment Button
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
