import 'package:flutter/material.dart';
import '../widgets/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // فعلاً داده mock (در مرحله AI واقعی می‌شود)
  int birdCount = 5000;
  double avgWeight = 1.35;
  double feedPerDay = 620;
  double insectProtein = 8;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Industrial Farm Dashboard",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // KPI Row 1
            Row(
              children: [
                _kpiCard(
                  title: "تعداد طیور",
                  value: "$birdCount",
                  icon: Icons.pets,
                ),
                const SizedBox(width: 12),
                _kpiCard(
                  title: "وزن متوسط",
                  value: "${avgWeight} kg",
                  icon: Icons.monitor_weight,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // KPI Row 2
            Row(
              children: [
                _kpiCard(
                  title: "مصرف خوراک روزانه",
                  value: "${feedPerDay} kg",
                  icon: Icons.grass,
                ),
                const SizedBox(width: 12),
                _kpiCard(
                  title: "پروتئین حشرات",
                  value: "${insectProtein} %",
                  icon: Icons.bug_report,
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              "Weight Growth Chart",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 220,
              child: FeedEfficiencyChart(),
            ),

            const SizedBox(height: 24),

            const Text(
              "Feed Efficiency",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 220,
              child: FeedEfficiencyChart(),
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 28),
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
