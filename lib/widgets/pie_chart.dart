import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = new Map();
    dataMap.putIfAbsent("Completed", () => 5);
    dataMap.putIfAbsent("In Progress", () => 3);
    
    // return PieChart(
    //     dataMap: dataMap,
    //     animationDuration: Duration(milliseconds: 800),
    //     chartLegendSpacing: 32.0,
    //     chartRadius: MediaQuery.of(context).size.width / 2.7,
    //     showChartValuesInPercentage: true,
    //     showChartValues: true,
    //     showChartValuesOutside: false,
    //     chartValueBackgroundColor: Colors.grey[200],
    //     colorList: colorList,
    //     showLegends: true,
    //     legendPosition: LegendPosition.right,
    //     decimalPlaces: 1,
    //     showChartValueLabel: true,
    //     initialAngle: 0,
    //     chartValueStyle: defaultChartValueStyle.copyWith(
    //       color: Colors.blueGrey[900].withOpacity(0.9),
    //     ),
    //     chartType: ChartType.disc,
    // );
  }
}