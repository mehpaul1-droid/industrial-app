import 'package:flutter/material.dart';
import 'api_service.dart';

// صفحات
import 'farms_page.dart';
import 'reports_page.dart';
import 'ai_panel.dart';
import 'farm_compare_page.dart';
import 'analytics_page.dart';

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

  // 🧪 موقت: بدون نیاز به backend برای تست UI
  void loadData() async {
    setState(() {
      data = {
        "today_consumption": {
          "corn": 12,
          "soybean": 22,
          "bran": 18,
          "protein_iran_city": 7
        },
        "prediction": "Stable growth expected",
        "ai_ration_tip": "Increase protein_iran_city slightly",
        "profit_trend": "Positive trend"
      };
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
            decoration: BoxDecoration(color: Colors.green),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Farm Control Panel",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),

          _menu(Icons.dashboard, "Dashboard", 0),
          _menu(Icons.agriculture, "Farms", 1),
          _menu(Icons.bar_chart, "Reports", 2),
          _menu(Icons.smart_toy, "AI Panel", 3),
          _menu(Icons.analytics, "Analytics", 4),
          _menu(Icons.compare, "Compare Farms", 5),
        ],
      ),
    );
  }

  Widget _menu(IconData icon, String title, int index) {
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

  // 📌 ROUTING (buildBody)
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
        return AnalyticsPage();
      case 5:
        return FarmComparePage();
      default:
        return _dashboardView();
    }
  }

  // 📊 DASHBOARD UI
  Widget _dashboardView() {
    if (data == null) {
      return Center(child: CircularProgressIndicator());
    }

    final c = data!["today_consumption"];

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📊 Dashboard Overview",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 20),

          _card("Corn", c["corn"].toString()),
          _card("Soybean", c["soybean"].toString()),
          _card("Bran", c["bran"].toString()),
          _card("Protein Iran City", c["protein_iran_city"].toString()),

          SizedBox(height: 20),

          _card("AI Prediction", data!["prediction"]),
          _card("AI Tip", data!["ai_ration_tip"]),
          _card("Profit", data!["profit_trend"]),
        ],
      ),
    );
  }

  Widget _card(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
