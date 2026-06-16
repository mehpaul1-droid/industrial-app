import 'package:flutter/material.dart';
import 'api_service.dart';

class AIPanel extends StatefulWidget {
  @override
  State<AIPanel> createState() => _AIPanelState();
}

class _AIPanelState extends State<AIPanel> {
  TextEditingController farmController = TextEditingController();
  String result = "";
  bool loading = false;

  void analyze() async {
    setState(() {
      loading = true;
      result = "";
    });

    final res = await ApiService.analyzeFarm(
      farmController.text,
      "chicken",
    );

    setState(() {
      loading = false;
      result = res["optimized_ration"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            "🧠 AI Feed Optimizer",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 15),

          TextField(
            controller: farmController,
            decoration: InputDecoration(
              labelText: "Farm Name",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 10),

          ElevatedButton(
            onPressed: analyze,
            child: Text("Run AI Analysis"),
          ),

          SizedBox(height: 20),

          if (loading) CircularProgressIndicator(),

          if (result.isNotEmpty)
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  result,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
