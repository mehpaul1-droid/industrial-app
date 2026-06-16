import 'package:flutter/material.dart';
import 'api_service.dart';

class Dashboard extends StatefulWidget {
  @override
  State createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final api = ApiService();
  String result = "";

  List<double> data = [3, 4, 3.5, 5, 4.2, 6, 5.5];

  void analyze() async {
    final res = await api.analyze(data);
    setState(() {
      result = res.toString();
    });
  }

  void predict() async {
    final res = await api.predict(data);
    setState(() {
      result = res.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Industrial AI Dashboard")),
      body: Column(
        children: [
          SizedBox(height: 20),

          ElevatedButton(
            onPressed: analyze,
            child: Text("تحلیل مصرف"),
          ),

          ElevatedButton(
            onPressed: predict,
            child: Text("پیش‌بینی مصرف"),
          ),

          SizedBox(height: 20),

          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              result,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
