import 'package:flutter/material.dart';
import 'screens/dashboard.dart';
import 'screens/login_page.dart';

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
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),

      initialRoute: '/login',

      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => const Dashboard(),
      },

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}
