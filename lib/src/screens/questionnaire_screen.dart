import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Comment {
  String name;
  String text;
  List<String> images;

  Comment({required this.name, required this.text, this.images = const []});
}

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  TextEditingController commentController = TextEditingController();

  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(
        'https://docs.google.com/forms/d/e/1FAIpQLSepN3AsrBxHJYdtt0MOeuWrqAHo9NsGzwtnSoJewS97KAH6eg/viewform?usp=sf_link'));

  List<Comment> comments = [
    Comment(
        name: 'Ludov Garcia',
        text: 'Ejemplo de comentaio numemero 1',
        images: [
          'https://thewowdecor.com/wp-content/uploads/2015/07/Master-Bedroom.jpeg',
          'https://thewowdecor.com/wp-content/uploads/2015/07/Master-Bedroom.jpg'
        ]),
    Comment(name: 'Dave P.', text: 'Otro ejemplo de comentario numero 2'),
    Comment(name: 'Dave P.', text: 'Otro ejemplo de comentario numero 2'),
    Comment(name: 'Dave P.', text: 'Otro ejemplo de comentario numero 2'),
  ];

  void _openCommentModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
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
                Container(
                  height: 250,
                  child: ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(comments[index].name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(comments[index].text),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                // Add Comment Form

                // Comment Text Field
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Enter your comment...',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0),
                // Add Image Button
                ElevatedButton(
                  onPressed: () {
                    // Implement logic to add image
                    // You can use image picker or any other method
                  },
                  child: Text('Add a Comment'),
                ),
                SizedBox(height: 8.0),
                // Submit Comment Button
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire'),
      ),
      body: Column(
        children: [
          // WebView for displaying Google Form
          Expanded(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openCommentModal(context);
        },
        child: Icon(Icons.comment),
      ),
    );
  }
}

// List to store comments
List<String> comments = [
  "This is a fake comment 1",
  "This is a fake comment 2",
  "This is a fake comment 3",
  // Add more fake comments as needed
];
