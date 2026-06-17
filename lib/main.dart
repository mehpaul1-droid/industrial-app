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
  title: 'سامانه ایران پروتئین',
  builder: (context, child) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: child!,
    );
  },
  home: const Dashboard(),
);
    );
  }
}
