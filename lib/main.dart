// lib/main.dart

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_app/src/providers/user_provider.dart';
import 'package:urban_app/src/screens/home_screen.dart';
import 'package:urban_app/src/screens/login_screen.dart';
import 'package:urban_app/utils/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'By Urban',
      theme: ThemeData(
          primaryColor: Colors.lightBlue[800],
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: AppColors.blue,
          )),
      home: LoginScreen(),
    );
  }
}
