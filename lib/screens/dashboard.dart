import 'package:flutter/material.dart';
import '../core/farm_state.dart';
import '../widgets/charts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    final birdCount = FarmState.count;
    final avgWeight = FarmState.weight;
    final age = FarmState.age;
    final animal = FarmState.animal;

    return Scaffold(
      appBar: AppBar(
        title: const Text("FarmWise Dashboard"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "نوع پرنده: $animal",
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  _card("تعداد طیور", birdCount.toString(), Icons.pets),
                  const SizedBox(width: 12),
                  _card("سن (روز)", age.toString(), Icons.timer),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _card("وزن متوسط", "$avgWeight kg", Icons.monitor_weight),
                  const SizedBox(width: 12),
                  _card("وضعیت AI", _aiStatus(), Icons.smart_toy),
                ],
              ),

              const SizedBox(height: 24),

              const Text(
                "Growth Chart",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 12),

              const SizedBox(
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
                  "FarmWise AI System آماده دریافت داده جدید است.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _aiStatus() {
    return FarmState.lastAIResult == null ? "Idle" : "Active";
  }

  Widget _card(String title, String value, IconData icon) {
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
            Icon(icon),
            const SizedBox(height: 10),
            Text(value,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}
