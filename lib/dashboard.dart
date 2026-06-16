import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final res = await ApiService.getDashboard();
    setState(() {
      data = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final consumption = data!["today_consumption"];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Farm AI Dashboard"),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🟢 KPI SECTION
            Row(
              children: [
                _buildKPI("Corn", consumption["corn"].toString(), Icons.grain),
                SizedBox(width: 10),
                _buildKPI("Soy", consumption["soybean"].toString(), Icons.eco),
              ],
            ),

            SizedBox(height: 10),

            Row(
              children: [
                _buildKPI("Bran", consumption["bran"].toString(), Icons.agriculture),
                SizedBox(width: 10),
                _buildKPI("Insect", consumption["insect_protein"].toString(), Icons.bug_report),
              ],
            ),

            SizedBox(height: 25),

            Text(
              "📊 Feed Composition",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 15),

            Container(
              height: 250,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(show: false),
                  barGroups: [
                    _bar(0, consumption["corn"]),
                    _bar(1, consumption["soybean"]),
                    _bar(2, consumption["bran"]),
                    _bar(3, consumption["insect_protein"]),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            _buildCard(
              "🔮 AI Prediction",
              data!["prediction"],
              Icons.insights,
            ),

            _buildCard(
              "🍽 AI Feed Optimization",
              data!["ai_ration_tip"],
              Icons.smart_toy,
            ),

            _buildCard(
              "📈 Profit Trend",
              data!["profit_trend"],
              Icons.trending_up,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPI(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.green),
            SizedBox(height: 8),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.green),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(subtitle),
              ],
            ),
          )
        ],
      ),
    );
  }

  BarChartGroupData _bar(int x, dynamic y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: (y ?? 0).toDouble(), width: 14),
      ],
    );
  }
}
