import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:urban_app/utils/colors.dart';

class IntakeScreen extends StatefulWidget {
  @override
  _IntakeScreenState createState() => _IntakeScreenState();
}

class _IntakeScreenState extends State<IntakeScreen> {
  TextEditingController commentController = TextEditingController();
  List<XFile>? selectedImages;
  int _currentIndex = 0;

  Future<void> _pickImages() async {
    final List<XFile>? result = await ImagePicker().pickMultiImage();
    if (result != null) {
      setState(() {
        selectedImages = result;
        _currentIndex = 0; // Reset index when new images are selected
      });
    }
  }

  void _submitForm() {
    // Implement form submission logic here
    // Access commentController.text for the comment
    // Access selectedImages for the selected images
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intake'),
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
                      items: selectedImages!.map((XFile image) {
                        return Image.file(
                          File(image.path),
                          fit: BoxFit.cover,
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.blue,
                backgroundColor: AppColors.blueLow,
              ),
              onPressed: _pickImages,
              child: Text('Select Files'),
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Add a note',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.blue,
                    backgroundColor: AppColors.blueLow,
                  ),
                  onPressed: _submitForm,
                  child: Text('Submit'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: IntakeScreen(),
  ));
}
