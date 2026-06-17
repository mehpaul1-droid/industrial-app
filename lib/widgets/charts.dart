import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class FeedEfficiencyChart extends StatelessWidget {
  const FeedEfficiencyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 42,
        minY: 0,
        maxY: 3.5,

        gridData: FlGridData(
          show: true,
        ),

        borderData: FlBorderData(
          show: true,
        ),

        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
            ),
          ),

          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 7,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                  ),
                );
              },
            ),
          ),

          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
        ),

        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            barWidth: 4,

            spots: const [
              FlSpot(0, 0.04),
              FlSpot(7, 0.18),
              FlSpot(14, 0.45),
              FlSpot(21, 0.90),
              FlSpot(28, 1.50),
              FlSpot(35, 2.20),
              FlSpot(42, 3.00),
            ],

            dotData: FlDotData(
              show: true,
            ),
          ),
        ],
      ),
    );
  }
}
