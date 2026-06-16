import 'package:flutter/material.dart';
import 'api_service.dart';

class FarmsPage extends StatefulWidget {
  @override
  State<FarmsPage> createState() => _FarmsPageState();
}

class _FarmsPageState extends State<FarmsPage> {
  List farms = [];
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadFarms();
  }

  void loadFarms() async {
    final data = await ApiService.getFarms();
    setState(() {
      farms = data;
    });
  }

  void addFarm() async {
    await ApiService.createFarm(nameController.text, "chicken");
    nameController.clear();
    loadFarms();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [

          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Farm Name",
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 10),

          ElevatedButton(
            onPressed: addFarm,
            child: Text("Create Farm"),
          ),

          SizedBox(height: 20),

          Expanded(
            child: ListView.builder(
              itemCount: farms.length,
              itemBuilder: (context, index) {
                final farm = farms[index];

                return Card(
                  child: ListTile(
                    trailing: IconButton(
  icon: Icon(Icons.auto_awesome),
  onPressed: () async {
    final result = await ApiService.analyzeFarm(
      farm["name"],
      farm["type"],
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("AI Result"),
        content: Text(result["optimized_ration"].toString()),
      ),
    );
  },
),
                    leading: Icon(Icons.agriculture),
                    title: Text(farm["name"]),
                    subtitle: Text(farm["type"]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
