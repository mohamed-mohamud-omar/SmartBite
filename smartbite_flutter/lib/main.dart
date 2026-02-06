import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // TODO: Member 5 - Add providers

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartBite',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PlaceholderScreen(), // TODO: Member 4 - Connect to Login/Home
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  const PlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('SmartBite - Project Ready for Teamwork'),
      ),
    );
  }
}
