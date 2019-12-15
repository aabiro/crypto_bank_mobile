import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/models/income_chart.dart';
import 'package:flutter/material.dart';

class IncomeChart extends StatelessWidget {
  final List<SubscriberSeries> data;

  IncomeChart({@required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<SubscriberSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (SubscriberSeries series, _) => series.day,
          measureFn: (SubscriberSeries series, _) => series.income,
          colorFn: (SubscriberSeries series, _) => series.barColor)
    ];

    return Container(
      height: 400,
      padding: EdgeInsets.all(20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Text(
                "Monthly Income from Lending",
                // style: Theme.of(context).textTheme.body2,
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }
}