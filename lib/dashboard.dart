import 'package:flutter/material.dart';
import 'api_service.dart';

class Dashboard extends StatefulWidget {
  @override
  State createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final api = ApiService();

  bool loading = false;
  String result = "";

  List<double> data = [3, 4, 3.5, 5, 4.2, 6, 5.5];

  Future<void> runAnalysis() async {
    setState(() {
      loading = true;
      result = "";
    });

    final res = await api.analyze(data);

    setState(() {
      loading = false;
      result = res.toString();
    });
  }

  Future<void> runPrediction() async {
    setState(() {
      loading = true;
      result = "";
    });

    final res = await api.predict(data);

    setState(() {
      loading = false;
      result = res.toString();
    });
  }

  Widget buildCard(String title, String value, IconData icon) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 32),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                SizedBox(height: 4),
                Text(value,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Industrial AI Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            buildCard("وضعیت سیستم", "آماده", Icons.settings),
            buildCard("نوع داده", "مصرف صنعتی", Icons.show_chart),

            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : runAnalysis,
                    child: Text("تحلیل مصرف"),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : runPrediction,
                    child: Text("پیش‌بینی"),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            if (loading)
              CircularProgressIndicator(),

            SizedBox(height: 20),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
