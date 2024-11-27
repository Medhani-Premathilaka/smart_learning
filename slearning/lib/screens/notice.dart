import 'package:flutter/material.dart';
import 'package:slearning/screens/fav.dart';
import 'package:slearning/screens/home.dart';
import 'package:slearning/screens/profile.dart';

class Notice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Circle decorations
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
                  color: Colors.green.withOpacity(0.4),
                ),
              ),
            ),

            // Notification content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Notification message
                  Text(
                    "No notifications found.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8), // Space between text and icon
                  // Notification icon
                  Icon(
                    Icons.notifications_none,
                    size: 40,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            // Floating footer section
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 190, // Center horizontally
              child: Container(
                width: 380,
                height: 45,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Color(0xFFB6EFA4), // Light green background color
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5), // Shadow position
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Handle Home action
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => HomePage()));
                        //Navigator.pop(context);
                      },
                      icon: Icon(Icons.home, color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle Favorites action
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Fav()));
                      },
                      icon: Icon(Icons.star, color: Colors.black),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle Notifications action
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Notice()));
                      },
                      icon: Icon(Icons.notifications, color: Colors.green),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle Profile action
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Profile()));
                      },
                      icon: Icon(Icons.person, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
