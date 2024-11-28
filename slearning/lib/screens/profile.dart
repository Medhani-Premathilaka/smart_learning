import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:slearning/screens/fav.dart';
import 'package:slearning/screens/home.dart';
import 'package:slearning/screens/login.dart';
import 'package:slearning/screens/notice.dart';
import 'package:slearning/screens/register.dart';
import 'package:slearning/services/firebaseAuthServices.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  Future<void> _submitFeedback() async {
    String feedback = _feedbackController.text.trim();

    if (feedback.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Feedback cannot be empty."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      // Save feedback to Firestore
      await FirebaseFirestore.instance.collection('feedbacks').add({
        'feedback': feedback,
        'userId': FirebaseAuth.instance.currentUser?.uid ?? "Anonymous",
        'timestamp': FieldValue.serverTimestamp(),
      });

      // Clear the input field
      _feedbackController.clear();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Thank you for your valuable feedback!"),
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0.79),
        ),
      );
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error submitting feedback: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _signOut() async {
    try {
      // Sign out from Firebase
      await FirebaseAuth.instance.signOut();

      // Add a small delay before navigating to the next screen
      // This ensures the sign-out is completed properly before the navigation
      //await Future.delayed(Duration(seconds: 0));

      // Navigate to the Login screen (or Register if you prefer)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(), // Redirect to the Login screen
        ),
      );
    } catch (e) {
      // If there's an error, show a Snackbar with the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error signing out: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: 1000,
          child: Stack(
            children: [
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
              // Positioned(
              //   top: 80,
              //   right: 16,
              //   child: ElevatedButton.icon(
              //     onPressed: _signOut,
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.green,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //     ),
              //     icon: Icon(
              //       Icons.logout,
              //       color: Colors.white,
              //     ),
              //     label: Text(
              //       "Sign Out",
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontSize: 14,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              // Positioned(
              //   bottom: 60,
              //   left: 20,
              //   right: 20,
              //   child: ElevatedButton(
              //     onPressed: _signOut, // Sign-out button
              //     child: Text("Sign Out"),
              //   ),
              // ),

              // Positioned(
              //   top: 50,
              //   left: 20,
              //   child: Text(
              //     "  ${FirebaseAuth.instance.currentUser?.email ?? "User"}", // Display user's email
              //     style: TextStyle(
              //       fontSize: 22,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              // Feedback form or other content goes here

              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 150),
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "  ${FirebaseAuth.instance.currentUser?.email ?? "User"}",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "BEGINNER LEVEL",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(135, 0, 0, 0),
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Feedback",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _feedbackController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type here...",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 120,
                right: 50,
                left: 50,
                child: ElevatedButton(
                  onPressed: _submitFeedback,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                right: 50,
                left: 50,
                child: ElevatedButton(
                  onPressed: _signOut,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(135, 0, 0, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text(
                    "SIGN OUT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: MediaQuery.of(context).size.width / 2 - 190,
                child: Container(
                  width: 380,
                  height: 45,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFB6EFA4),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        icon: const Icon(Icons.home, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Fav()));
                        },
                        icon: const Icon(Icons.star, color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Notice()));
                        },
                        icon: const Icon(Icons.notifications,
                            color: Colors.black),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                        icon: const Icon(Icons.person, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
