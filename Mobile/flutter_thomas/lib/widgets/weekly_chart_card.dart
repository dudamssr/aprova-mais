import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/dashboard_models.dart';
import '../theme/app_theme.dart';
import 'dashboard_card.dart';
 
class WeeklyChartCard extends StatelessWidget {
  final List<WeeklyPoint> data;
 
  const WeeklyChartCard({super.key, required this.data});
 
  @override
  Widget build(BuildContext context) {
    final maxY = _niceMaxY(data);
 
    return DashboardCard(
      icon: Icons.show_chart,
      title: 'Evolução semanal',
      subtitle: 'Questões resolvidas',
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            minY: 0,
            maxY: maxY,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: maxY / 4,
              getDrawingHorizontalLine: (value) => FlLine(
                color: AppColors.progressTrack,
                strokeWidth: 1,
                dashArray: [4, 4],
              ),
            ),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              rightTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  interval: maxY / 4,
                  getTitlesWidget: (value, meta) => Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: AppColors.textLight,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 28,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= data.length) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        data[index].label,
                        style: const TextStyle(
                          color: AppColors.textLight,
                          fontSize: 11,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (spots) => spots
                    .map((s) => LineTooltipItem(
                          s.y.toStringAsFixed(0),
                          const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
                    .toList(),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  for (int i = 0; i < data.length; i++)
                    FlSpot(i.toDouble(), data[i].value),
                ],
                isCurved: true,
                curveSmoothness: 0.35,
                color: AppColors.primaryBlue,
                barWidth: 3,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primaryBlue.withOpacity(0.25),
                      AppColors.primaryBlue.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 
  /// Arredonda o teto do eixo Y para o próximo múltiplo "bonito" de 15.
  double _niceMaxY(List<WeeklyPoint> points) {
    final maxValue = points.map((p) => p.value).reduce((a, b) => a > b ? a : b);
    final step = 15.0;
    return ((maxValue / step).ceil() + 1) * step;
  }
}