import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const QuickNotesApp());

class QuickNotesApp extends StatelessWidget {
  const QuickNotesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Notes',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const HomeScreen(),
    );
  }
}