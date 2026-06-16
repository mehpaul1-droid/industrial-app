import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:fl_chart/fl_chart.dart';

import 'farms_page.dart';
import 'reports_page.dart';
import 'ai_panel.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic>? data;
  int selectedMenu = 0;

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
    return Scaffold(
      drawer: _buildDrawer(),
      appBar: AppBar(
        title: Text("Farm AI System"),
        backgroundColor: Colors.green[700],
      ),
      body: _buildBody(),
    );
  }

  // 📌 SIDEBAR
  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.green[700]),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Farm Control Panel",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),

          _menuItem(Icons.dashboard, "Dashboard", 0),
          _menuItem(Icons.agriculture, "Farms", 1),
          _menuItem(Icons.bar_chart, "Reports", 2),
          _menuItem(Icons.smart_toy, "AI Panel", 3),
          _menuItem(Icons.settings, "Settings", 4),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selectedMenu == index,
      onTap: () {
        setState(() {
          selectedMenu = index;
        });
        Navigator.pop(context);
      },
    );
  }

  // 📌 THIS IS buildBody (اصلی‌ترین بخش)
  Widget _buildBody() {
    switch (selectedMenu) {

      case 0:
        return _dashboardView();

      case 1:
        return FarmsPage();

      case 2:
        return ReportsPage();

      case 3:
  return AIPanel();

      case 4:
        return _simplePage("Settings");

      default:
        return _dashboardView();
    }
  }

  Widget _simplePage(String title) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  // 📊 DASHBOARD VIEW
  Widget _dashboardView() {
    if (data == null) {
      return Center(child: CircularProgressIndicator());
    }

    final consumption = data!["today_consumption"];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "📊 Dashboard Overview",
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
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
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

          _card("AI Prediction", data!["prediction"]),
          _card("AI Suggestion", data!["ai_ration_tip"]),
          _card("Profit Trend", data!["profit_trend"]),
        ],
      ),
    );
  }

  Widget _card(String title, String value) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(value),
        ],
      ),
    );
  }

  BarChartGroupData _bar(int x, dynamic y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: (y ?? 0).toDouble()),
      ],
    );
  }
}
