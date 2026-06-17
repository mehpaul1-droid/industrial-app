import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool loading = true;
  String? error;

  int birdCount = 0;
  double avgWeight = 0;
  double feedPerDay = 0;
  double insectProtein = 0;

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final res = await ApiService.getDashboardStats();

      setState(() {
        birdCount = res["bird_count"] ?? 0;
        avgWeight = (res["avg_weight"] ?? 0).toDouble();
        feedPerDay = (res["feed_per_day"] ?? 0).toDouble();
        insectProtein = (res["insect_protein"] ?? 0).toDouble();
      });
    } catch (e) {
      setState(() {
        error = "خطا در دریافت اطلاعات: $e";
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error!),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: loadDashboard,
              child: const Text("تلاش مجدد"),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: loadDashboard,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Industrial Farm Control Panel",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // KPI ROW 1
            Row(
              children: [
                _kpiCard(
                  title: "تعداد طیور",
                  value: birdCount.toString(),
                  icon: Icons.pets,
                ),
                const SizedBox(width: 12),
                _kpiCard(
                  title: "وزن متوسط",
                  value: "${avgWeight.toStringAsFixed(2)} kg",
                  icon: Icons.monitor_weight,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // KPI ROW 2
            Row(
              children: [
                _kpiCard(
                  title: "خوراک روزانه",
                  value: "${feedPerDay.toStringAsFixed(0)} kg",
                  icon: Icons.grass,
                ),
                const SizedBox(width: 12),
                _kpiCard(
                  title: "پروتئین حشرات",
                  value: "${insectProtein.toStringAsFixed(1)} %",
                  icon: Icons.bug_report,
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Performance Analytics",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: loadDashboard,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 220,
              child: FeedEfficiencyChart(),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "سیستم آماده اتصال به AI Engine است. "
                "در مرحله بعد، جیره‌نویسی و پیش‌بینی رشد به صورت زنده اضافه می‌شود.",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _kpiCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 26),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
