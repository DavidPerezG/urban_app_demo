import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:urban_app/src/models/user_data.dart';
import 'package:urban_app/src/screens/home_screen.dart';
import 'package:urban_app/src/providers/user_provider.dart';

class LoginScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login(
      BuildContext context, String email, String password) async {
    try {
      // Basic email and password validation
      if (email.isEmpty || password.isEmpty) {
        // Show an error message or perform other actions for invalid input
        print('Invalid email or password');
        return;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Login successful
      print('Login successful: ${userCredential.user?.email}');

      // Retrieve user data and save it to a global variable
      UserData? loggedInUser = await UserData.getCurrentUserData();
      print(loggedInUser);
      if (loggedInUser != null) {
        print(loggedInUser.email);
        // Save user data to the provider
        Provider.of<UserProvider>(context, listen: false).loggedInUser =
            loggedInUser;
      }

      // Navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      print('Login failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'views/logos/byurban_logo.png', // Replace with your logo image asset path
            //   width: 120.0,
            //   height: 120.0,
            // ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to Urban App',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () => _login(
                context,
                emailController.text.trim(),
                passwordController.text.trim(),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Login',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(builder: (context) => SignupScreen()),
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //     padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20.0),
            //     ),
            //   ),
            //   child: Text(
            //     'Go to Sign up',
            //     style: TextStyle(fontSize: 18.0),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
