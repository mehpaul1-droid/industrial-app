import 'package:flutter/material.dart';
import 'api_service.dart';

class ReportsPage extends StatefulWidget {
  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  List reports = [];

  @override
  void initState() {
    super.initState();
    loadReports();
  }

  void loadReports() async {
    final data = await ApiService.getReports();
    setState(() {
      reports = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "📊 Farm Reports",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10),

          Expanded(
            child: reports.isEmpty
                ? Center(child: Text("No reports yet"))
                : ListView.builder(
                    itemCount: reports.length,
                    itemBuilder: (context, index) {
                      final r = reports[index];

                      return Card(
                        child: ListTile(
                          leading: Icon(Icons.description),
                          title: Text("Farm: ${r["farm"]}"),
                          subtitle: Text(
                            "Date: ${r["date"]}\nAI: ${r["ai_note"]}",
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
