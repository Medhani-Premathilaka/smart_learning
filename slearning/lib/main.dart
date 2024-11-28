import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slearning/firebaseOptions.dart';
import 'package:slearning/screens/home.dart';
import 'package:slearning/screens/login.dart';
import 'package:slearning/screens/profile.dart';
import 'package:slearning/screens/register.dart';
import 'package:slearning/screens/slashScreen.dart'; // Import the SplashScreen file

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  // Activate Firebase App Check (Android/iOS and web)
  try {
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.playIntegrity, // For Android
    );
  } catch (e) {
    debugPrint("Firebase App Check activation error: $e");
  }

  // Set Firebase Auth language to English
  await FirebaseAuth.instance.setLanguageCode('en');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SLearning App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/login', // Initial route
      routes: {
        '/slashscreen': (context) => SlashScreen(),
        '/register': (context) => Register(),
        '/login': (context) => Login(),
        '/home': (context) => HomePage(),
        '/profile': (context) => Profile(),
      },
    );
  }
}
