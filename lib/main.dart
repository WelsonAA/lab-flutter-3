import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/card_creation_screen.dart';
import 'screens/card_viewer_screen.dart';
import 'screens/home_screen.dart';

// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  'apiKey': "AIzaSyALENaO_mqXJqhAhrrAmox2u20ihfmyIxk",
  'authDomain': "flutter3-6ac21.firebaseapp.com",
  'projectId': "flutter3-6ac21",
  'storageBucket': "flutter3-6ac21.firebasestorage.app",
  'messagingSenderId': "661726668698",
  'appId': "1:661726668698:web:3bef2c4c61c791995b7c23",
  'measurementId': "G-YFGX8BDW8J"
};

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  WidgetsFlutterBinding.ensureInitialized();
  print("Initialized");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Card App',
      theme: ThemeData(
        // Primary color set to purple
        primaryColor: Colors.purple,
        // Use colorScheme to manage the secondary color (white for contrast)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple).copyWith(secondary: Colors.white),
        // Default background color set to white
        scaffoldBackgroundColor: Colors.white,
        // Text theme (set text to black to contrast with the white background)

        // AppBar settings with purple background and white text
        appBarTheme: AppBarTheme(
          color: Colors.purple,  // Purple AppBar background
          iconTheme: IconThemeData(color: Colors.white),  // White icons in AppBar
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),  // White text in AppBar
        ),
        // FloatingActionButton theme with purple background
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.purple,  // Purple background for FABs
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/card_creation': (context) => CardCreationScreen(),
        '/card_viewer': (context) => CardViewerScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
