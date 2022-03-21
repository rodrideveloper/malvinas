import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class SimpleBarChart extends StatelessWidget {
  List<charts.Series> seriesList;
  bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(seriesList,
       animationDuration: Duration(seconds: 3),
        animate: true,
  
       
        barRendererDecorator: new charts.BarLabelDecorator<String>());
           
  }
}
