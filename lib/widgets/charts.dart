import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FeedEfficiencyChart extends StatelessWidget {
  const FeedEfficiencyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),

        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 3.5),
              FlSpot(2, 4),
              FlSpot(3, 3.8),
              FlSpot(4, 4.5),
              FlSpot(5, 5),
            ],
            isCurved: true,
            barWidth: 3,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
