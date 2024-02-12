import 'package:flutter/material.dart';
import 'package:urban_app/src/screens/image_zoom_screen.dart';

class CommentsWidget extends StatelessWidget {
  final List<Comment> comments;

  CommentsWidget({required this.comments});

  @override
  Widget build(BuildContext context) {
    void _showImageZoomDialog(String imageUrl) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageZoomScreen(imageUrl: imageUrl),
        ),
      );
    }

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comments[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(comments[index].text),
                SizedBox(height: 8.0),
                if (comments[index].images.isNotEmpty)
                  Container(
                    height: 100.0,
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: comments[index].images.length,
                      itemBuilder: (context, imageIndex) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            onTap: () {
                              _showImageZoomDialog(
                                  comments[index].images[imageIndex]);
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                comments[index].images[imageIndex],
                                width: 100.0,
                                height: 100.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Comment {
  String name;
  String text;
  List<String> images;

  Comment({required this.name, required this.text, this.images = const []});
}
