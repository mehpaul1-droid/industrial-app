import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("داشبورد مدیریت دام"),
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

            Container(
              height: 250,
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(toY: 40)
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(toY: 30)
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(toY: 20)
                    ]),
                    BarChartGroupData(x: 4, barRods: [
                      BarChartRodData(toY: 10)
                    ]),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            Card(
              child: ListTile(
                title: Text("🔮 پیش‌بینی مصرف فردا"),
                subtitle: Text("افزایش 8٪ مصرف خوراک به دلیل رشد سریع"),
              ),
            ),

            Card(
              child: ListTile(
                title: Text("🍽 جیره پیشنهادی AI"),
                subtitle: Text("جایگزینی 20٪ سویا با پروتئین حشرات برای کاهش هزینه"),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
