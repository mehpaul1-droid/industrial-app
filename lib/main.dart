import 'package:flutter/material.dart';
import 'login_page.dart';
import 'dashboard.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
routes: {
  "/dashboard": (context) => DashboardPage(),
}
