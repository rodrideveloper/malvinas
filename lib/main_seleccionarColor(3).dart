import 'package:Malvinas/utilidades/colores.dart';
import 'package:flutter/material.dart';
import 'BO/dao.dart';
import 'colores.dart';
import 'models/Tela.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeleccionarColor extends StatefulWidget {
  final String tela;

  SeleccionarColor({Key key, this.tela}) : super(key: key);

  @override
  _SeleccionarColorState createState() => _SeleccionarColorState();
}

class _SeleccionarColorState extends State<SeleccionarColor> {
  String valorColorPrimario = 'rojo';
  String valorColorSecundario = 'negro';

  List<Telas> listaTelas = [];
  Map<String, dynamic> mapa = {};

  @override
  void initState() {
    super.initState();
  }

  Future<QuerySnapshot> llenarListaTelas() async {
    final args = ModalRoute.of(context).settings.arguments as List<String>;

    return await DAO.leerSoloUnaDAO(args[0]);
  }

  @override
  Widget build(BuildContext context) {
    //Recibio  seleccionado, la tela seleccionada y junto a los colores seleccionados en esta pantalla los envío
    //a la pantalla Detalle
    final argumentos = ModalRoute.of(context).settings.arguments as List;
    String telaSeleccionada = argumentos[0];
    String ambo_id = argumentos[1];
    String modelo = argumentos[2];
    String tipo = argumentos[3];

    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            elevation: 20,
            backgroundColor: ColoresApp.color_gris,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/Detalle', arguments: [
                telaSeleccionada,
                valorColorPrimario,
                valorColorSecundario,
                ambo_id,
                modelo,
                tipo
              ]);
            },
            child:
                Icon(Icons.keyboard_arrow_right, size: 55, color: Colors.white),
          ),
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Seleccionar Colores',
            ),
            backgroundColor: ColoresApp.color_negro,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<QuerySnapshot>(
                future: llenarListaTelas(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<DocumentSnapshot> listaDoc = snapshot.data.docs;
                      listaDoc.forEach((element) {
                        listaTelas.add(
                            new Telas(element['nombre'], element['Colores']));
                      });
                      return Container(
                        color: ColoresApp.color_fondo,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            Material(
                              elevation: 10,
                              child: Container(
                                padding: EdgeInsets.all(30),
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: ColoresApp.color_negro),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          color: Colors.amberAccent,
                                          child: Center(
                                            child: Text('1',
                                                style: TextStyle(
                                                    color:
                                                        ColoresApp.color_negro,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat')),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                style: BorderStyle.solid,
                                                width: 5,
                                                color: Colors.white)),
                                        height: 50,
                                        child:
                                            botonColores_primario(listaTelas),
                                      ),
                                      SizedBox(height: 10),
                                      ClipOval(
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          color: Colors.amberAccent,
                                          child: Center(
                                            child: Text('2',
                                                style: TextStyle(
                                                    color:
                                                        ColoresApp.color_negro,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat')),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                style: BorderStyle.solid,
                                                width: 5,
                                                color: Colors.white)),
                                        height: 50,
                                        child:
                                            botonColores_secundario(listaTelas),
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                width: 180,
                                height: 180,
                                child: Center(
                                    child: Image.asset(
                                        'assets/img/malvinas.png'))),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )),
    );
  }

  Widget botonColores_primario(List<Telas> telas) {
    List llaves = telas[0].metros_colores.keys.toList();
    return DropdownButton(
        elevation: 6,
        isExpanded: true,
        dropdownColor: Colors.white,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        underline: SizedBox(),
        iconSize: 30,
        style: TextStyle(
            color: Colors.black, fontFamily: 'Raleway', letterSpacing: 15),
        items: llaves.map((dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(minHeight: 90.0),
              color: Colores.colores[dropDownStringItem],
              child: Text(dropDownStringItem,
                  style: TextStyle(
                    color: ThemeData.estimateBrightnessForColor(
                                Colores.colores[dropDownStringItem]) ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  )),
            ),
          ); //[negro, amarillo, rojo, blanco, fucsia]
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this.valorColorPrimario = newValueSelected;
          });
        },
        value: valorColorPrimario);
  }

  Widget botonColores_secundario(List<Telas> telas) {
    List llaves = telas[0].metros_colores.keys.toList();
    return DropdownButton(
        elevation: 6,
        isExpanded: true,
        dropdownColor: Colors.white,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        underline: SizedBox(),
        iconSize: 30,
        style: TextStyle(
            color: Colors.black, fontFamily: 'Raleway', letterSpacing: 15),
        items: llaves.map((dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(minHeight: 90.0),
              color: Colores.colores[dropDownStringItem],
              child: Text(dropDownStringItem,
                  style: TextStyle(
                    color: ThemeData.estimateBrightnessForColor(
                                Colores.colores[dropDownStringItem]) ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  )),
            ),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this.valorColorSecundario = newValueSelected;
          });
        },
        value: valorColorSecundario);
  }
}

class flechasSiguiente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: ColoresApp.color_gris,
        child: Icon(Icons.keyboard_arrow_right, size: 70, color: Colors.white),
      ),
    );
  }
}
