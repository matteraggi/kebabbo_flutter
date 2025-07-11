import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:kebabbo_flutter/main.dart';
import 'package:kebabbo_flutter/generated/l10n.dart';

class SingleChart extends StatefulWidget {
  final double vegetables;
  final double yogurt;
  final double spicy;
  final double onion;
  final bool isFront;

  const SingleChart({
    super.key,
    required this.vegetables,
    required this.yogurt,
    required this.spicy,
    required this.onion,
    required this.isFront,
  });

  @override
  State<SingleChart> createState() => _SingleChartState();
}

class _SingleChartState extends State<SingleChart> {
  List<Color> gradientColors = [
    red,
    yellow,
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.vegetables == 0 ||
        widget.yogurt == 0 ||
        widget.spicy == 0 ||
        widget.onion == 0) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(
          mainData(),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 2, // Cambia l'intervallo delle linee orizzontali
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.grey,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 2, // Cambia l'intervallo dei titoli dell'asse sinistro
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 3,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, widget.vegetables),
            FlSpot(1, widget.yogurt),
            FlSpot(2, widget.spicy),
            FlSpot(3, widget.onion),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: widget.isFront ? Colors.black : Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(S.of(context).verdura, style: style);
        break;
      case 1:
        text = Text(S.of(context).yogurt, style: style);
        break;
      case 2:
        text = Text(S.of(context).spicy, style: style);
        break;
      case 3:
        text = Text(S.of(context).cipolla, style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    var style = TextStyle(
      color: widget.isFront ? Colors.black : Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    return Text(
      value.toInt().toString(),
      style: style,
      textAlign: TextAlign.left,
    );
  }
}
