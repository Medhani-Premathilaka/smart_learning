import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter/material.dart';
import 'package:slearning/screens/fav.dart';
import 'package:slearning/screens/notice.dart';
import 'package:slearning/screens/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "User"; // Default value for username
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch user data on initialization
  }

  // Method to fetch username from Firestore
  Future<void> _fetchUserData() async {
    try {
      User? user = _auth.currentUser; // Get the current user
      if (user != null) {
        // Fetch user data from Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users') // Assuming your collection name is 'users'
            .doc(user.uid) // Fetch document by UID
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          setState(() {
            username = userDoc['username'] ?? "User"; // Get username field
          });
        }
      }
    } catch (e) {
      print("Error fetching user data: $e"); // Debug log for errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Scrollable Content
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height +
                    100, // Adjust content height dynamically
                child: Stack(
                  children: [
                    // Decorative Circles
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
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green.withOpacity(0.4),
                        ),
                      ),
                    ),
                    // Greeting Text
                    Positioned(
                      top: 50,
                      left: 26,
                      child: Text(
                        "Hi, ${FirebaseAuth.instance.currentUser?.email ?? "User"}", // Display fetched username
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //       Positioned(
                    //   top: 50,
                    //   left: 20,
                    //   child: Text(
                    //      // Display user's email
                    //     style: TextStyle(
                    //       fontSize: 22,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    // Skills Section
                    _buildSkillsSection(),
                  ],
                ),
              ),
            ),
            // Footer Section
            Positioned(
              bottom: 5,
              left: MediaQuery.of(context).size.width / 2 - 190,
              child: _buildFooter(context),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build each skill box
  Widget _buildSkillBox(String skill) {
    return Container(
      width: 93,
      height: 93,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          skill,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Build Skills Section
  Widget _buildSkillsSection() {
    return Positioned(
      left: 26,
      top: 142,
      right: 26,
      child: Column(
        children: [
          // Skill Rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkillBox("HTML"),
              _buildSkillBox("CSS"),
              _buildSkillBox("JS"),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkillBox("REACT.JS"),
              _buildSkillBox("NODE.JS"),
              _buildSkillBox("R"),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkillBox("MySQL"),
              _buildSkillBox("MongoDB"),
              _buildSkillBox("Firebase"),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkillBox("Dart"),
              _buildSkillBox("Flutter"),
              _buildSkillBox("Kotlin"),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkillBox("MySQL"),
              _buildSkillBox("MongoDB"),
              _buildSkillBox("Firebase"),
            ],
          ),
          const SizedBox(height: 36),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSkillBox("Dart"),
              _buildSkillBox("Flutter"),
              _buildSkillBox("Kotlin"),
            ],
          ),
        ],
      ),
    );
  }

  // Build Footer Section
  Widget _buildFooter(BuildContext context) {
    return Container(
      width: 380,
      height: 45,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFB6EFA4),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: const Icon(Icons.home, color: Colors.green),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Fav()));
            },
            icon: const Icon(Icons.star, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Notice()));
            },
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            icon: const Icon(Icons.person, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
