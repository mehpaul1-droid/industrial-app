import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  Map<String, dynamic>? aiResult;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        title: const Text("Industrial AI Dashboard"),
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
              "Iran Protein AI",
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
        setState(() => selectedIndex = index);
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

  // ---------------- KPI ----------------
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
          _livestockView(),
          _aiOptimizeView(),
          _reportsView(),
        ],
      ),
    );
  }

  // ---------------- DASHBOARD (CHART) ----------------
  Widget _dashboardView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          "Feed Efficiency Trend",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: FeedEfficiencyChart(),
        ),
        SizedBox(height: 20),
        Text(
          "System Status: ACTIVE",
          style: TextStyle(color: Colors.greenAccent),
        ),
      ],
    );
  }

  // ---------------- LIVESTOCK ----------------
  Widget _livestockView() {
    return const Center(
      child: Text(
        "Livestock Management Panel",
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  // ---------------- AI OPTIMIZE ----------------
  Widget _aiOptimizeView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () async {
            setState(() => loading = true);

            try {
              final result = await ApiService.optimizeRation(
                animal: "chicken",
                age: 25,
                goal: "growth",
                available: ["soybean_meal"],
              );

              setState(() => aiResult = result);
            } catch (e) {
              setState(() => aiResult = {"error": e.toString()});
            }

            setState(() => loading = false);
          },
          child: loading
              ? const SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text("Run AI Optimization"),
        ),

        const SizedBox(height: 20),

        if (aiResult != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              aiResult.toString(),
              style: const TextStyle(color: Colors.greenAccent),
            ),
          ),
      ],
    );
  }

  // ---------------- REPORTS (HISTORY) ----------------
  Widget _reportsView() {
    return FutureBuilder(
      future: ApiService.getHistory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data as List;

        if (data.isEmpty) {
          return const Center(
            child: Text(
              "No AI history yet",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF0D1117),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Animal: ${item['animal']}",
                      style: const TextStyle(color: Colors.white)),
                  Text("Score: ${item['score']}",
                      style: const TextStyle(color: Colors.greenAccent)),
                  Text("Goal: ${item['goal']}",
                      style: const TextStyle(color: Colors.white70)),
                  Text("Time: ${item['timestamp']}",
                      style: const TextStyle(
                          color: Colors.white38, fontSize: 10)),
                ],
              ),
            );
          },
        );
      },
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
        color: const Color(0xFF0D1117),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(color: Colors.white60, fontSize: 12)),
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
