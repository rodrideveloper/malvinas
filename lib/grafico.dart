import 'package:Malvinas/SimpleBarChart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

class Grafico extends StatelessWidget {
  Grafico({Key key}) : super(key: key);
  List<charts.Series> seriesList;
  List<charts.Series> listaColores;

  leerTelas() {
    FirebaseFirestore.instance
        .collection('telas')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc['nombre']);
      });
    });
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales(
        'Rojo',
        5,
        charts.ColorUtil.fromDartColor(Colors.red),
      ),
      new OrdinalSales(
        'Negro',
        25,
        charts.ColorUtil.fromDartColor(Colors.black),
      ),
      new OrdinalSales(
        'Azul Marino',
        100,
        charts.ColorUtil.fromDartColor(Colors.blue),
      ),
      new OrdinalSales(
        'Blanco',
        75,
        charts.ColorUtil.fromDartColor(Colors.amber),
      ),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        // colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        colorFn: (OrdinalSales sales, _) => sales.color,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Grafico de Telas"),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Container(height: 150, child: SimpleBarChart(_createSampleData())),
            Container(height: 150, child: SimpleBarChart(_createSampleData())),
            Container(height: 150, child: SimpleBarChart(_createSampleData())),
            Container(
                height: 50,
                child: TextButton(
                    onPressed: () => leerTelas(), child: Text("Ver TELAS"))),
          ],
        )));
  }
}

class OrdinalSales {
  final String year;
  final int sales;
  final charts.Color color;
  OrdinalSales(this.year, this.sales, this.color);
}
