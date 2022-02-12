import 'package:Malvinas/SimpleBarChart.dart';
import 'package:Malvinas/colores.dart';
import 'package:Malvinas/models/Tela.dart';
import 'package:Malvinas/utilidades/colores.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'BO/dao.dart';

class MetrosPorColores {
  final String Color;
  final double metros;
  final charts.Color color;
  MetrosPorColores(this.Color, this.metros, this.color);
}

class GraficoEstado extends StatefulWidget {
  const GraficoEstado({Key key}) : super(key: key);

  @override
  _GraficoEstadoState createState() => _GraficoEstadoState();
}

class _GraficoEstadoState extends State<GraficoEstado> {
  List<charts.Series> seriesList;
  List<charts.Series> listaColores;

  Future<QuerySnapshot> leerTelas() async {
    return await DAO.leerTelasDAO();
  }

  static List<charts.Series<MetrosPorColores, String>> _crearDatosGraficos(
      String tipo_tela, Map<String, dynamic> metros_colores) {
    List keys = metros_colores.keys.toList();
    List<MetrosPorColores> data = [];
    for (int i = 0; i < metros_colores.length; i++) {
      data.add(new MetrosPorColores(
        keys[i],
        double.parse("${metros_colores[keys[i]]}"),
        charts.ColorUtil.fromDartColor(Colores.colores[keys[i]] ?? Colors.red),
      ));
    }

    return [
      new charts.Series<MetrosPorColores, String>(
          id: 'Sales',
          // colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          colorFn: (MetrosPorColores sales, _) => sales.color,
          domainFn: (MetrosPorColores sales, _) => sales.Color,
          measureFn: (MetrosPorColores sales, _) => sales.metros,
          data: data,
          labelAccessorFn: (MetrosPorColores sales, _) =>
              '${sales.metros.toString() + ' mts'}')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          elevation: 20,
          backgroundColor: ColoresApp.color_gris,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_left, size: 55, color: Colors.white),
        ),
        appBar: AppBar(
          elevation: 20,
          centerTitle: true,
          title: Text("Grafico de Telas"),
          backgroundColor: Colors.black,
          /* shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0))),*/
        ),
        body: SafeArea(
            child: Container(
          margin: EdgeInsets.all(20),
          color: ColoresApp.color_fondo,
          child: Column(
            children: [
              FutureBuilder<QuerySnapshot>(
                future: leerTelas(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<Telas> lista_telas = [];
                      final List<DocumentSnapshot> documentos =
                          snapshot.data.docs;

                      documentos.forEach((element) {
                        if (element != null) {
                          Telas tela =
                              new Telas(element['nombre'], element['Colores']);
                          lista_telas.add(tela);
                        }
                      });
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Card(
                              child: Container(
                                  height: 140,
                                  child: SimpleBarChart(_crearDatosGraficos(
                                      lista_telas[0].tipo_tela,
                                      lista_telas[0].metros_colores))),
                            ),
                            Container(
                                height: 20,
                                child: Text(lista_telas[0].tipo_tela,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold))),
                            Card(
                              child: Container(
                                  height: 140,
                                  child: SimpleBarChart(_crearDatosGraficos(
                                      lista_telas[1].tipo_tela,
                                      lista_telas[1].metros_colores))),
                            ),
                            Container(
                                height: 20,
                                child: Text(
                                  lista_telas[1].tipo_tela,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                            Card(
                              child: Container(
                                  height: 140,
                                  child: SimpleBarChart(_crearDatosGraficos(
                                      lista_telas[2].tipo_tela,
                                      lista_telas[2].metros_colores))),
                            ),
                            Container(
                                height: 20,
                                child: Text(
                                  lista_telas[2].tipo_tela,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )),
                          ]);
                    } else {
                      print("No hay información");
                    }
                  }
                  return Center(
                      child: Container(
                          padding: const EdgeInsets.all(0.0),
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.blueGrey),
                          )));
                },
              ),
            ],
          ),
        )));
  }
}
