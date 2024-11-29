import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      // Create user with email and password
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification after successful registration
      await credential.user?.sendEmailVerification();
      debugPrint("Email verification sent to: ${credential.user?.email}");

      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      _handleAuthException(e);
      return null;
    } catch (e) {
      debugPrint("Sign-up error: ${e.toString()}");
      throw Exception("An unexpected error occurred during sign-up.");
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      // Create user with email and password
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification after successful registration
      await credential.user?.sendEmailVerification();
      debugPrint("Email verification sent to: ${credential.user?.email}");

      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      _handleAuthException(e);
      return null;
    } catch (e) {
      debugPrint("Sign-up error: ${e.toString()}");
      throw Exception("An unexpected error occurred during sign-up.");
    }
  }

  // Handle Firebase-specific authentication errors
  void _handleAuthException(FirebaseAuthException e) {
    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = "No user found for the provided email.";
        break;
      case 'wrong-password':
        errorMessage = "Incorrect password.";
        break;
      case 'email-already-in-use':
        errorMessage = "The email is already in use.";
        break;
      case 'weak-password':
        errorMessage = "The password is too weak.";
        break;
      case 'invalid-email':
        errorMessage = "Invalid email address.";
        break;
      default:
        errorMessage = e.message ?? "An unknown error occurred.";
    }
    debugPrint("FirebaseAuthException: $errorMessage");
    throw Exception(errorMessage);
  }
  
}
