import 'package:flutter/material.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(const FarmAIApp());
}

class FarmAIApp extends StatelessWidget {
  const FarmAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Industrial Farm AI',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Dashboard(),
    );
  }
}
