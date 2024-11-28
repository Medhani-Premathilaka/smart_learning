import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
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

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      // Sign in user with email and password
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if email is verified
      if (!credential.user!.emailVerified) {
        debugPrint("Email not verified for user: ${credential.user!.email}");
        throw Exception("Email not verified. Please check your inbox.");
      }

      debugPrint("Sign-in successful for user: ${credential.user?.email}");
      return credential.user;
    } on FirebaseAuthException catch (e) {
      // Handle Firebase-specific errors
      _handleAuthException(e);
      return null;
    } catch (e) {
      debugPrint("Sign-in error: ${e.toString()}");
      throw Exception("An unexpected error occurred during sign-in.");
    }
  }

  // Sign out
  // Future<void> signOut() async {
  //   try {
  //     await _auth.signOut();
  //     debugPrint("User signed out successfully.");
  //   } catch (e) {
  //     debugPrint("Sign-out error: ${e.toString()}");
  //     throw Exception("Failed to sign out.");
  //   }
  // }
  

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
