import 'package:flutter/material.dart';
import 'api_service.dart';

class FarmComparePage extends StatefulWidget {
  @override
  State<FarmComparePage> createState() => _FarmComparePageState();
}

class _FarmComparePageState extends State<FarmComparePage> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final res = await ApiService.compareFarms();
    setState(() {
      data = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Center(child: CircularProgressIndicator());
    }

    final farms = data!["farms"];
    final best = data!["best_farm"];

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "⚖️ Farm Comparison AI",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 15),

          Text(
            "🏆 Best Farm: ${best["name"]}",
            style: TextStyle(fontSize: 16, color: Colors.green),
          ),

          SizedBox(height: 15),

          Expanded(
            child: ListView.builder(
              itemCount: farms.length,
              itemBuilder: (context, index) {
                final f = farms[index];

                return Card(
                  child: ListTile(
                    leading: Icon(Icons.agriculture),
                    title: Text(f["name"]),
                    subtitle: Text(
                      "Profit: ${f["profit"]} | Cost: ${f["cost"]} | Efficiency: ${f["efficiency"]}",
                    ),
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
