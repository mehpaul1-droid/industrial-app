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
        title: const Text("سامانه هوشمند مدیریت دام و طیور"),
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
              "سامانه ایران پروتئین",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          _item(Icons.dashboard, "داشبورد", 0),
          _item(Icons.pets, "مدیریت دام", 1),
          _item(Icons.smart_toy, "هوش مصنوعی", 2),
          _item(Icons.analytics, "گزارش‌ها", 3),
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
        Expanded(child: _KpiCard(title: "بهره‌وری خوراک", value: "87%")),
        SizedBox(width: 10),
        Expanded(child: _KpiCard(title: "مزارع فعال", value: "12")),
        SizedBox(width: 10),
        Expanded(child: _KpiCard(title: "دقت هوش مصنوعی", value: "94%")),
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
          "روند بهره‌وری خوراک",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        SizedBox(height: 20),
        SizedBox(
          height: 200,
          child: FeedEfficiencyChart(),
        ),
        SizedBox(height: 20),
        Text(
          "وضعیت سامانه: فعال",
          style: TextStyle(color: Colors.greenAccent),
        ),
      ],
    );
  }

  // ---------------- LIVESTOCK ----------------
  Widget _livestockView() {
    return const Center(
      child: Text(
        "پنل مدیریت دام و طیور",
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
              : const Text("اجرای تحلیل هوش مصنوعی"),
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
              "هنوز گزارشی ثبت نشده است",
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
                  Text("حیوان: ${item['animal']}",
                      style: const TextStyle(color: Colors.white)),
                  Text("امتیاز: ${item['score']}",
                      style: const TextStyle(color: Colors.greenAccent)),
                  Text("هدف: ${item['goal']}",
                      style: const TextStyle(color: Colors.white70)),
                  Text("زمان: ${item['timestamp']}",
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
