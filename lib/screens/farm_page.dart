import 'package:flutter/material.dart';

class FarmPage extends StatefulWidget {
  const FarmPage({super.key});

  @override
  State<FarmPage> createState() => _FarmPageState();
}

class _FarmPageState extends State<FarmPage> {
  final countController = TextEditingController();
  final ageController = TextEditingController();
  final weightController = TextEditingController();

  String animal = "مرغ گوشتی";
  String goal = "رشد";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

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
            controller: countController,
            decoration: const InputDecoration(
              labelText: "تعداد",
            ),
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 12),

          TextField(
            controller: ageController,
            decoration: const InputDecoration(
              labelText: "سن (روز)",
            ),
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 12),

          TextField(
            controller: weightController,
            decoration: const InputDecoration(
              labelText: "وزن فعلی",
            ),
            keyboardType: TextInputType.number,
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("اطلاعات فارم ذخیره شد"),
                ),
              );
            },
            child: const Text("ثبت اطلاعات"),
          ),
        ],
      ),
    );
  }
}
