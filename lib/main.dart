// lib/main.dart
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hci/screens/home_screen.dart'; //added package path
import 'package:hci/services/ai_service.dart'; //added package path
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

void main() async {
  // WidgetsFlutterBinding.ensureInitialized(); // Required for dotenv
  // await dotenv.load(fileName: ".env"); // Load the .env file
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Group 21 Mobile Money',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.orange, // Keep this for button defaults
        ).copyWith(
          primary:
              const Color(0xFFE65100), // Darker, vibrant orange (primary color)
          secondary: const Color(
              0xFFFF9800), // Lighter, standard orange (secondary color)
          background:
              const Color(0xFFFFF3E0), // Very light orange for background
          surface: Colors.white,
          onPrimary: Colors.orange, //Text and icons on top of primary color
          onSecondary: Colors.black, // Text and icons on top of secondary color
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
