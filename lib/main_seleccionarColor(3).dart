import 'package:flutter/material.dart';
import 'BO/dao.dart';
import 'colores.dart';
import 'models/Tela.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'colores.dart' as Col;

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
    //Recibio nombre del ambo seleccionado, la tela seleccionada y junto a los colores seleccionados en esta pantalla los envío
    //a la pantalla Detalle
    final argumentos =
        ModalRoute.of(context).settings.arguments as List<String>;
    String telaSeleccionada = argumentos[0];
    String ambo = argumentos[1];

    return Scaffold(
        appBar: AppBar(
          title: Text('Seleccionar Colores'),
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
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  style: BorderStyle.solid, width: 0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Primario'),
                                  botonColores_primario(listaTelas),
                                  SizedBox(height: 10),
                                  Text(
                                    'Secundario',
                                    textAlign: TextAlign.left,
                                  ),
                                  botonColores_secundario(listaTelas),
                                ]),
                          ),
                          /* Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Color Secundario'),
                              SizedBox(width: 20),
                              Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [)
                            ],
                          ),*/
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Icon(
                                            Icons.keyboard_arrow_left,
                                            size: 70,
                                          )),
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/Detalle',
                                                arguments: [
                                                  telaSeleccionada,
                                                  valorColorPrimario,
                                                  valorColorSecundario,
                                                  ambo
                                                ]);
                                          },
                                          child: Icon(
                                            Icons.keyboard_arrow_right,
                                            size: 70,
                                          )),
                                    ]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                }
                return Container();
              }),
        ));
  }

  /*Widget botonColores_primario(List<Telas> telas) {
    List llaves = telas[0].metros_colores.keys.toList();

    return DropdownButton(
        isExpanded: true,
        elevation: 6,
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down),
        underline: SizedBox(),
        iconSize: 30,
        style: TextStyle(color: Colors.black),
        items: llaves.map((dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(minHeight: 48.0),
              color: Colores.colores[dropDownStringItem],
              child: Text(
                dropDownStringItem,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this.valorColorPrimario = newValueSelected;
          });
        },
        value: valorColorPrimario);
  }*/

  Widget botonColores_primario(List<Telas> telas) {
    List llaves = telas[0].metros_colores.keys.toList();
    print(llaves);
    return DropdownButton(
        elevation: 6,
        isExpanded: true,
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down),
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
        icon: Icon(Icons.arrow_drop_down),
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

/*items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String nuevoValor) {
                setState(() {
                  valor = nuevoValor;
                });
              });*/
