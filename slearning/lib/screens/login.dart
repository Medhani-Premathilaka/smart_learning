import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slearning/screens/home.dart';
import 'package:slearning/screens/register.dart';
import 'package:slearning/services/firebaseAuthServices.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
      body: Stack(
        children: [
          // Decorative Top Circles
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
            top: 250,
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: const Text(
              "WELCOME!",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // SVG Image

          Positioned(
            top: 320,
            left: MediaQuery.of(context).size.width / 2 - 60,
            child: SvgPicture.asset(
              'assets/login.svg', // Replace with your SVG path
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          // Email Input Field
          Positioned(
            top: 470,
            left: 40,
            right: 40,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.23),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _emailController,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
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

          // Password Input Field
          Positioned(
            top: 530,
            left: 40,
            right: 40,
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.23),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: const InputDecoration(
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

          // Login Button
          Positioned(
            bottom: 120,
            left: 40,
            right: 40,
            child: ElevatedButton(
              onPressed: _signin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      "LOGIN",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),

          // Sign Up with Google Button
          Positioned(
            bottom: 60,
            left: 40,
            right: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Register()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const TextSpan(text: "Sign Up with "),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Image.asset(
                          'assets/google.png', // Replace with your Google icon asset
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login Method
  void _signin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email and Password cannot be empty."),
          backgroundColor: Color.fromARGB(159, 10, 174, 49),
        ),
      );
      return;
    }

    //setState(() => _isLoading = false);

    try {
      User? user = await _auth.signInWithEmailAndPassword(email, password);

      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Successfully Logged in! Welcome!"),
            backgroundColor: Color.fromRGBO(00, 00, 00, 0.0),
          ),
        );

        // Navigate to Home Page
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: const Color.fromARGB(159, 10, 174, 49),
        ),
      );
    } finally {
      //setState(() => _isLoading = false);
    }
  }
}
