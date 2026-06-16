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
