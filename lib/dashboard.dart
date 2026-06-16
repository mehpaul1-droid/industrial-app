import 'package:flutter/material.dart';
import 'api_service.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    try {
      final res = await ApiService.getDashboard();
      setState(() {
        data = res;
      });
    } catch (e) {
      setState(() {
        data = {
          "today_consumption": {
            "corn": 0,
            "soybean": 0,
            "bran": 0,
            "insect_protein": 0
          },
          "prediction": "خطا در دریافت داده",
          "ai_ration_tip": "اتصال به سرور برقرار نشد",
          "profit_trend": "-"
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Scaffold(
        appBar: AppBar(title: Text("داشبورد صنعتی")),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final consumption = data!["today_consumption"];

    return Scaffold(
      appBar: AppBar(
        title: Text("داشبورد مدیریت دام"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "📊 مصرف خوراک امروز",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: (consumption["corn"] ?? 0).toDouble(),
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: (consumption["soybean"] ?? 0).toDouble(),
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 3,
                      barRods: [
                        BarChartRodData(
                          toY: (consumption["bran"] ?? 0).toDouble(),
                        )
                      ],
                    ),
                    BarChartGroupData(
                      x: 4,
                      barRods: [
                        BarChartRodData(
                          toY: (consumption["insect_protein"] ?? 0).toDouble(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: Icon(Icons.trending_up),
                title: Text("🔮 پیش‌بینی مصرف"),
                subtitle: Text(data!["prediction"].toString()),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.agriculture),
                title: Text("🍽 پیشنهاد هوش مصنوعی"),
                subtitle: Text(data!["ai_ration_tip"].toString()),
              ),
            ),

            Card(
              child: ListTile(
                leading: Icon(Icons.show_chart),
                title: Text("📈 روند سود"),
                subtitle: Text(data!["profit_trend"].toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
