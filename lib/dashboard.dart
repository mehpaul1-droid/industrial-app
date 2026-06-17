import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/kpi_card.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String result = "";
  bool loading = false;

  final animalController = TextEditingController();
  final ageController = TextEditingController();
  final goalController = TextEditingController();

  int selectedMenu = 0;

  Future<void> optimize() async {
    setState(() => loading = true);

    try {
      final res = await ApiService.optimizeRation(
        animal: animalController.text,
        age: int.parse(ageController.text),
        goal: goalController.text,
      );

      setState(() {
        result = res.toString();
      });
    } catch (e) {
      setState(() {
        result = e.toString();
      });
    }

    setState(() => loading = false);
  }

  Widget sidebar() {
    return Container(
      width: 220,
      color: const Color(0xFF111827),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Icon(Icons.factory, color: Colors.white, size: 40),
          const SizedBox(height: 20),
          menuItem(Icons.dashboard, "Dashboard", 0),
          menuItem(Icons.analytics, "Reports", 1),
          menuItem(Icons.settings, "Settings", 2),
        ],
      ),
    );
  }

  Widget menuItem(IconData icon, String title, int index) {
    return ListTile(
      selected: selectedMenu == index,
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: () => setState(() => selectedMenu = index),
    );
  }

  Widget kpiRow() {
    return Row(
      children: const [
        Expanded(child: KPICard(title: "Animals", value: "120", icon: Icons.pets)),
        SizedBox(width: 10),
        Expanded(child: KPICard(title: "Feed Stock", value: "540kg", icon: Icons.grass)),
        SizedBox(width: 10),
        Expanded(child: KPICard(title: "AI Runs", value: "32", icon: Icons.smart_toy)),
      ],
    );
  }

  Widget aiPanel() {
    return Card(
      color: const Color(0xFF1F2937),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text("AI Feed Optimizer",
                style: TextStyle(color: Colors.white, fontSize: 18)),

            TextField(
              controller: animalController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Animal"),
            ),
            TextField(
              controller: ageController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Age"),
            ),
            TextField(
              controller: goalController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Goal"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: optimize,
              child: loading
                  ? const CircularProgressIndicator()
                  : const Text("Run AI Optimization"),
            ),
          ],
        ),
      ),
    );
  }

  Widget reportPanel() {
    return Card(
      color: const Color(0xFF111827),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            result.isEmpty ? "No data yet" : result,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),

      body: Row(
        children: [
          sidebar(),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  kpiRow(),
                  const SizedBox(height: 20),

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: aiPanel()),
                        const SizedBox(width: 10),
                        Expanded(flex: 3, child: reportPanel()),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
