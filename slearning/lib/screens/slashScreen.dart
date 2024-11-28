import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'register.dart';

class SlashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left circles
          Positioned(
            top: -71,
            left: -56,
            child: Container(
              width: 170,
              height: 162,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.3),
              ),
            ),
          ),
          Positioned(
            top: 35,
            left: 25,
            child: Container(
              width: 121,
              height: 121,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withOpacity(0.5),
              ),
            ),
          ),
          // Centered SVG Image
          Center(
            child: SvgPicture.asset(
              'assets/splash_screen.svg', // Replace with your SVG path
              height: 180,
              fit: BoxFit.contain,
              placeholderBuilder: (BuildContext context) =>
                  CircularProgressIndicator(), // Display a loader if SVG fails to load
            ),
          ),
          // GET STARTED Button
          Positioned(
            bottom: 60, // 30px above the bottom text
            left: 40,
            right: 40,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to the Register page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Register()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Button background color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: Text(
                "GET STARTED",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Bottom Powered By Text
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Powered by SLearning with ❤️",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
