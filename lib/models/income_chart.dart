import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class SubscriberSeries {
  final String day;
  final int income;
  final charts.Color barColor;

  SubscriberSeries({
      @required this.day,
      @required this.income,
      @required this.barColor
  });
}