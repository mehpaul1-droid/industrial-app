import 'package:flutter/material.dart';
import '../services/api_service.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Industrial AI Panel"),
        backgroundColor: const Color(0xFF161B22),
      ),
      drawer: _buildSidebar(),
      body: _buildBody(),
    );
  }

  // ---------------- SIDEBAR ----------------
  Widget _buildSidebar() {
    return Drawer(
      backgroundColor: const Color(0xFF161B22),
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text(
              "Farm AI System",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          _item(Icons.dashboard, "Dashboard", 0),
          _item(Icons.pets, "Livestock", 1),
          _item(Icons.smart_toy, "AI Optimize", 2),
          _item(Icons.analytics, "Reports", 3),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      selected: selectedIndex == index,
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        Navigator.pop(context);
      },
    );
  }

  // ---------------- BODY ----------------
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _kpiRow(),
          const SizedBox(height: 20),
          Expanded(child: _contentArea()),
        ],
      ),
    );
  }

  // ---------------- KPI CARDS ----------------
  Widget _kpiRow() {
    return Row(
      children: const [
        Expanded(child: _KpiCard(title: "Feed Efficiency", value: "87%")),
        SizedBox(width: 10),
        Expanded(child: _KpiCard(title: "Active Farms", value: "12")),
        SizedBox(width: 10),
        Expanded(child: _KpiCard(title: "AI Accuracy", value: "94%")),
      ],
    );
  }

  // ---------------- CONTENT ----------------
  Widget _contentArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IndexedStack(
        index: selectedIndex,
        children: [
          _dashboardView(),
          _simpleView("Livestock Management"),
          _simpleView("AI Optimization Panel"),
          _simpleView("Reports & Analytics"),
        ],
      ),
    );
  }

  Widget _dashboardView() {
    return const Center(
      child: Text(
        "Welcome to Industrial AI Dashboard",
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _simpleView(String title) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(color: Colors.white70, fontSize: 16),
      ),
    );
  }
}

// ---------------- KPI CARD ----------------
class _KpiCard extends StatelessWidget {
  final String title;
  final String value;

  const _KpiCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 8),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
