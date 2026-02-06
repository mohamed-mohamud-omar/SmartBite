import 'package:flutter/material.dart';

/**
 * FLUTTER UI - MEMBER 4 (jundi9444@gmail.com)
 * 
 * TASKS:
 * 1. Design the Menu Dashboard.
 * 2. Display food items in a Grid or List.
 * 3. Add a Search bar.
 * 4. Implement navigation to Food Details.
 */

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: const Center(child: Text('Menu Screen UI - To be developed by Member 4')),
    );
  }
}
