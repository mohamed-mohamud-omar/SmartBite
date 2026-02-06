import 'package:flutter/material.dart';

/**
 * FLUTTER UI - MEMBER 4 (jundi9444@gmail.com)
 * JIRA ID: KAN-6
 * 
 * TASKS:
 * 1. Design a professional Login Screen.
 * 2. Add text fields for Email and Password.
 * 3. Add a Login button.
 * 4. Add a link to the Signup Screen.
 */

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: const Center(child: Text('Login Screen UI - To be developed by Member 4')),
    );
  }
}
