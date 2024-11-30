import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/card_creation_screen.dart';
import 'screens/card_viewer_screen.dart';
import 'screens/home_screen.dart';



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
        // Primary color set to white
        primaryColor: Colors.white,
        // Use colorScheme to manage the secondary color
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white).copyWith(secondary: Colors.blue),
        // Default background color set to white
        scaffoldBackgroundColor: Colors.white,
        // Text theme (set text to white to contrast with the white background)
        
        // AppBar settings to have a white background with blue icons/text
        appBarTheme: AppBarTheme(
          color: Colors.white,  // white AppBar background
          iconTheme: IconThemeData(color: Colors.blue),  // blue icons
          titleTextStyle: TextStyle(color: Colors.blue, fontSize: 20),  // blue text in AppBar
        ),
        // FloatingActionButton theme to match the color scheme
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue,  // blue background for FABs
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
