import 'package:flutter/material.dart';
import 'api_service.dart';

class Dashboard extends StatefulWidget {
  @override
  State createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final api = ApiService();

  bool loading = false;
  String result = "";

  List<double> data = [3, 4, 3.5, 5, 4.2, 6, 5.5];

  Future<void> runAnalysis() async {
    setState(() {
      loading = true;
      result = "";
    });

    final res = await api.analyze(data);

    setState(() {
      loading = false;
      result = res.toString();
    });
  }

  Future<void> runPrediction() async {
    setState(() {
      loading = true;
      result = "";
    });

    final res = await api.predict(data);

    setState(() {
      loading = false;
      result = res.toString();
    });
  }

  Widget glassCard({required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: child,
    );
  }

  Widget kpi(String title, String value, IconData icon, Color color) {
    return glassCard(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
              SizedBox(height: 4),
              Text(value,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEF2F7),
      appBar: AppBar(
        title: Text("Industrial Control Center"),
        backgroundColor: Color(0xFF1E2A38),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [

            /// 🔵 STATUS HEADER
            glassCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("System Status",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("ONLINE",
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),

            /// 📊 KPI SECTION
            kpi("Production Load", "72%", Icons.factory, Colors.blue),
            kpi("AI Engine", "Active", Icons.memory, Colors.orange),
            kpi("Efficiency", "High", Icons.trending_up, Colors.green),

            /// 🎛 ACTION BUTTONS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : runAnalysis,
                    child: Text("Run Analysis"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.all(14),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: loading ? null : runPrediction,
                    child: Text("Predict"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: EdgeInsets.all(14),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),

            /// ⏳ LOADING
            if (loading)
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 8),
                    Text("AI Processing Data..."),
                  ],
                ),
              ),

            SizedBox(height: 10),

            /// 📦 OUTPUT PANEL
            Expanded(
              child: glassCard(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Output Panel",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),

                      Text(
                        result.isEmpty
                            ? "No data yet. Run analysis or prediction."
                            : result,
                        style: TextStyle(fontSize: 14),
                      ),

                      SizedBox(height: 20),

                      /// 🧪 SAMPLE DATA
                      Text("Sample Data",
                          style: TextStyle(
                              fontWeight: FontWeight.bold)),

                      SizedBox(height: 6),

                      Wrap(
                        spacing: 8,
                        children: data
                            .map((e) => Chip(
                                  label: Text(e.toString()),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
