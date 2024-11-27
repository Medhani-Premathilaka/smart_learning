import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign up with email and password
  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optional: Send email verification
      await credential.user?.sendEmailVerification();

      return credential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e); // Handle Firebase-specific errors
      return null;
    } catch (e) {
      debugPrint("Sign-up error: ${e.toString()}");
      rethrow;
    }
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!credential.user!.emailVerified) {
        debugPrint("Email not verified for user: ${credential.user!.email}");
        // Notify user about verification
        throw Exception("Email not verified. Please check your inbox.");
      }

      return credential.user;
    } on FirebaseAuthException catch (e) {
      _handleAuthException(e); // Handle Firebase-specific errors
      return null;
    } catch (e) {
      debugPrint("Sign-in error: ${e.toString()}");
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      debugPrint("User signed out successfully.");
    } catch (e) {
      debugPrint("Sign-out error: ${e.toString()}");
      throw Exception("Failed to sign out.");
    }
  }

  // Handle Firebase-specific authentication errors
  void _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        debugPrint("Error: No user found for the provided email.");
        throw Exception("No user found for the provided email.");
      case 'wrong-password':
        debugPrint("Error: Incorrect password.");
        throw Exception("Incorrect password.");
      case 'email-already-in-use':
        debugPrint("Error: The email is already in use.");
        throw Exception("The email is already in use.");
      case 'weak-password':
        debugPrint("Error: The password is too weak.");
        throw Exception("The password is too weak.");
      case 'invalid-email':
        debugPrint("Error: Invalid email address.");
        throw Exception("Invalid email address.");
      default:
        debugPrint("Unhandled FirebaseAuthException: ${e.message}");
        throw Exception(e.message);
    }
  }
}
