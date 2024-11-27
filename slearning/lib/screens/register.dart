import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:slearning/screens/home.dart';
import 'package:slearning/screens/login.dart';
import 'package:slearning/services/FirebaseAuthServices.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
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
            // Welcome Text
            Positioned(
              top: 270,
              left: MediaQuery.of(context).size.width / 2 - 60,
              child: Text(
                "WELCOME!",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              top: 350,
              left: MediaQuery.of(context).size.width / 2 - 30,
              child: Opacity(
                opacity: 0.6,
                child: Image.asset(
                  'assets/hello.png', // Replace with your Google icon asset
                  height: 60,
                  width: 60,
                ),
              ),
            ),
            // Email Input Box
            Positioned(
              top: 470,
              left: 40,
              right: 40,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.23),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: _emailController,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.44),
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            // Password Input Box
            Positioned(
              top: 530,
              left: 40,
              right: 40,
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.23),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter your password",
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 0.44),
                        fontSize: 16,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            // Register Button
            Positioned(
              bottom: 60,
              left: 40,
              right: 40,
              child: ElevatedButton(
                onPressed: _signup,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Register Now!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
            // Navigate to Login
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                    children: [
                      TextSpan(text: "Already Signed up? "),
                      TextSpan(
                        text: "Sign in",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signup() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All fields are required."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    //setState(() => _isLoading = false);

    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration Successful! Welcome, $email."),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to Login Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage()), // Use direct navigation
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
