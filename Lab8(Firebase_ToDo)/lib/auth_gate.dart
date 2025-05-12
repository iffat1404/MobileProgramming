import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'login_screen.dart';   // We'll create this
import 'todo_list_screen.dart'; // We'll create this

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService(); // Instantiate your service

    return StreamBuilder<User?>(
      stream: authService.authStateChanges, // Use the stream from AuthService
      builder: (context, snapshot) {
        // User is not logged in
        if (!snapshot.hasData) {
          return const LoginScreen(); // Show login screen
        }

        // User is logged in
        // Pass the logged-in user to the home screen
        return TodoListScreen(user: snapshot.data!);
      },
    );
  }
}