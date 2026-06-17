import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final ageController = TextEditingController();
  final goalController = TextEditingController();

  String animal = "مرغ گوشتی";

  bool loading = false;
  Map<String, dynamic>? result;
  String? error;

  List<String> available = [];

  Future<void> runAI() async {
    setState(() {
      loading = true;
      error = null;
      result = null;
    });

    try {
      final res = await ApiService.optimizeRation(
        animal: animal,
        age: int.tryParse(ageController.text) ?? 0,
        goal: goalController.text,
        available: available,
      );

      setState(() {
        result = res;
      });
    } catch (e) {
      setState(() {
        error = "AI Error: $e";
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void toggleIngredient(String item) {
    setState(() {
      if (available.contains(item)) {
        available.remove(item);
      } else {
        available.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Control Center"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Farm Input",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: animal,
              items: const [
                DropdownMenuItem(
                  value: "مرغ گوشتی",
                  child: Text("مرغ گوشتی"),
                ),
                DropdownMenuItem(
                  value: "بوقلمون",
                  child: Text("بوقلمون"),
                ),
                DropdownMenuItem(
                  value: "بلدرچین",
                  child: Text("بلدرچین"),
                ),
              ],
              onChanged: (v) {
                setState(() {
                  animal = v!;
                });
              },
            ),

            const SizedBox(height: 12),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "سن (روز)",
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: goalController,
              decoration: const InputDecoration(
                labelText: "هدف (growth / egg / fattening)",
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Available Feed",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            Wrap(
              spacing: 8,
              children: [
                _chip("corn"),
                _chip("soybean_meal"),
                _chip("wheat"),
                _chip("insect_protein"),
                _chip("vitamins"),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading ? null : runAI,
                child: loading
                    ? const CircularProgressIndicator()
                    : const Text("Run AI Optimization"),
              ),
            ),

            const SizedBox(height: 20),

            if (error != null)
              Text(
                error!,
                style: const TextStyle(color: Colors.red),
              ),

            if (result != null) _buildResult(result!),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) {
    final selected = available.contains(label);

    return FilterChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) => toggleIngredient(label),
    );
  }

  Widget _buildResult(Map<String, dynamic> data) {
    final ration = data["ration"] ?? {};
    final insight = data["insight"] ?? "";

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "AI Ration Result",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ...ration.entries.map((e) {
            return Text("${e.key}: ${e.value}%");
          }),

          const SizedBox(height: 10),

          const Text(
            "Insight",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          Text(insight),
        ],
      ),
    );
  }
}
