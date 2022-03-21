import 'package:Malvinas/SimpleBarChart.dart';
import 'package:Malvinas/colores.dart';
import 'package:Malvinas/models/Tela.dart';
import 'package:Malvinas/utilidades/colores.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
 
    super.initState();
  }

@override
dispose(){
  SystemChrome.setPreferredOrientations([
    
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  super.dispose();
}

  static List<charts.Series<MetrosPorColores, String>> _crearDatosGraficos(List<Telas> lista_telas, String tela
      ) {
        String tipo_tela; 
        Map<String, dynamic> metros_colores;
     lista_telas.forEach((element) {
       if (element.tipo_tela==tela){
         tipo_tela=element.tipo_tela;
         metros_colores=element.metros_colores;

       }
     });   
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight



     
  ]);
     final argumentos = ModalRoute.of(context).settings.arguments as Map;
     String tela=argumentos['tela'];
        List<Telas> telas_arciel_1=[];
          List<Telas> telas_arciel_2=[];
    return Scaffold(
       floatingActionButtonLocation:FloatingActionButtonLocation.miniStartFloat ,
        floatingActionButton: FloatingActionButton(
      elevation: 0,
      
          backgroundColor: ColoresApp.color_fondo,
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_left, size: 55, color: Colors.black),
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
                              new Telas(tipo_tela: element['nombre'], metros_colores: element['Colores']);
                          lista_telas.add(tela);

                       /*   if (tela=='Arciel') {

                            if (tela.tipo_tela=='Arciel'){
                              telas_arciel_1=lista_telas;
                              telas_arciel_2=lista_telas;
                               telas_arciel_1[0].metros_colores.

                              
                             Map<String, dynamic> metros_colores=tela.metros_colores;
                             int largo= metros_colores.length;
                                
                                 for (int i=1; i< largo ;i++){


                                 }
                          

                            }
                 


                    }*/



                        }
                      });


           
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           
                                    if (tela=='Arciel') ...[
                                  

 SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Card(
                                child: Container(
                                    height: 200,
                                    width: 1500,
                             
                                    child: 
                                   SimpleBarChart(_crearDatosGraficos(
                                          lista_telas, tela))
                                    ),
                              ),
          ),
                            Container(
                                height: 20,
                                child: Text(tela,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))


          
          
          
    ] else ...[
         SingleChildScrollView(
            scrollDirection: Axis.horizontal,
           child: Card(
                                  child: Container(
                                      height: 200,
                                      width: 1000,
                               
                                      child: 
                                     SimpleBarChart(_crearDatosGraficos(
                                            lista_telas, tela))
                                      ),
                                ),
         ),
         
                            Container(
                                height: 20,
                          
                                child: Text(tela,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold)))]
        //]

                            ,
                          /*  Card(
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
                                )),*/
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
