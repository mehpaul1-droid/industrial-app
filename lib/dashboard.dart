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

  Widget buildKPI(String title, String value, IconData icon, Color color) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 13, color: Colors.grey[700])),
              SizedBox(height: 4),
              Text(value,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6F9),
      appBar: AppBar(
        title: Text("Industrial AI Control Panel"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [

            buildKPI("وضعیت سیستم", "آنلاین", Icons.power, Colors.green),
            buildKPI("نوع داده", "مصرف صنعتی", Icons.show_chart, Colors.blue),
            buildKPI("AI Engine", "فعال", Icons.memory, Colors.orange),

            SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: loading ? null : runAnalysis,
                    icon: Icon(Icons.analytics),
                    label: Text("تحلیل"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: loading ? null : runPrediction,
                    icon: Icon(Icons.auto_graph),
                    label: Text("پیش‌بینی"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 15),

            if (loading)
              Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("در حال پردازش AI..."),
                ],
              ),

            SizedBox(height: 10),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: Text(
                    result.isEmpty ? "نتیجه اینجا نمایش داده می‌شود..." : result,
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
