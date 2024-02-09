import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_app/src/providers/user_provider.dart';
import 'package:urban_app/src/screens/login_screen.dart';
import 'package:wordpress_client/wordpress_client.dart';
import 'package:urban_app/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Post> wordpressPosts = [];
  void fetchingPosts() async {
    final baseUrl = Uri.parse('https://by-urban.com//wp-json/wp/v2');
    final client = WordpressClient(baseUrl: baseUrl);

    client.initialize();
    final request = ListPostRequest(
      page: 1,
      perPage: 20,
    );

    final wpResponse = await client.posts.list(request);

    switch (wpResponse) {
      case WordpressSuccessResponse():
        final List<Post> data = wpResponse.data;
        setState(() {
          wordpressPosts = data;
        });
        break;
      case WordpressFailureResponse():
        final error = wpResponse.error; // WordpressError
        print(error);

        break;
    }
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.signOut();
      print('Sign-out successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      // Failed sign-out
      print('Sign-out failed: $e');
    }
  }

  @override
  void initState() {
    super.initState();

    fetchingPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 137, 196, 255),
                radius: 50.0,
                // backgroundImage: AssetImage('byurban_logo.png'),
              ),
              SizedBox(height: 16.0),
              Text(
                Provider.of<UserProvider>(context).loggedInUser?.name ?? "",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8.0),
              Text(
                Provider.of<UserProvider>(context).loggedInUser?.email ?? "",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 24.0),
              // ElevatedButton(
              //   style: ElevatedButton.styleFrom(
              //       foregroundColor: AppColors.blue,
              //       backgroundColor: AppColors.blueLow),
              //   onPressed: () {
              //   },
              //   child: Text('Edit Profile'),
              // ),
              SizedBox(height: 8.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: AppColors.blue,
                    backgroundColor: AppColors.blueLow),
                onPressed: () => _signOut(context),
                child: Text('Sign Out'),
              ),
              Expanded(
                child: ListView(
                  children: wordpressPosts.map((Post wordpressPost) {
                    return ListTile(
                        // title: Text(wordpressPost.),
                        );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
