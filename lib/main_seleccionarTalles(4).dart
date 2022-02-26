import 'package:Malvinas/models/ambo.dart';
import 'package:Malvinas/models/registros.dart';
import 'package:Malvinas/models/talle.dart';
import 'package:Malvinas/models/tipos.dart';
import 'package:Malvinas/utilidades/colores.dart';
import 'package:flutter/material.dart';
import 'BO/dao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/precios.dart';

class Detalle extends StatefulWidget {
  final Ambo ambo;

  Detalle({Key key, this.ambo}) : super(key: key);

  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  String tipoTela = 'Arciel';
  String cortador = 'Seleccionar';
  List<String> chaqueta_pantalon = <String>['4', '5', '6'];

  final talles = <Talle>[
    Talle('XS', 2.0),
    Talle('S', 2.0),
    Talle('M', 2.0),
    Talle('L', 2.0),
    Talle('XL', 2.0),
    Talle('XXL', 2.0),
    Talle('XXXL', 2.0),
    Talle('S/T', 2.0)
  ];

  int tallesChaqueta = 0;
  int tallesPantalon = 0;
  int tallesPantalon2 = 0;
  void refresh(dynamic childValue) {
    setState(() {
      tallesChaqueta = childValue;
    });
  }

  void refreshP(dynamic childValue) {
    setState(() {
      tallesPantalon = childValue;
    });
  }

  void refreshP2(dynamic childValue) {
    setState(() {
      tallesPantalon2 = childValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final argumentos = ModalRoute.of(context).settings.arguments as Map;
    String ambo_id = argumentos['ambo'].id;
    String modelo = argumentos['ambo'].modelo;
    String tela = argumentos['telaSeleccionada'];
    String color1 = argumentos['valorColorPrimario'];
    String color2 = argumentos['valorColorSecundario'];
    String tipo = argumentos['ambo'].tipo;
    int precio = 0;

    // Usa el objeto Todo para crear nuestra UI
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(modelo),
          backgroundColor: ColoresApp.color_negro,
          elevation: 0,
          /* shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0))))*/
        ),
        /*  actualizar: () {
                          setState(() {});
                        }*/
        body: Container(
          height: double.infinity,
          color: ColoresApp.color_negro,
          child: Stack(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (tipo == '0') //Solo Chaqueta
                  SeleccionTalles(
                      encabezado: 'Chaqueta',
                      talleValor: tallesChaqueta,
                      actualizar: refresh)
                else if (tipo == '9') //Solo Pantalon
                  SeleccionTalles(
                      encabezado: 'Pantalon',
                      talleValor: tallesPantalon,
                      actualizar: refreshP)
                else if (tipo == '7') //3 piezas
                  Row(
                    children: [
                      SeleccionTalles(
                          encabezado: 'Chaqueta',
                          talleValor: tallesChaqueta,
                          actualizar: refresh),
                      SeleccionTalles(
                          encabezado: 'Pantalon',
                          talleValor: tallesPantalon,
                          actualizar: refreshP),
                      SeleccionTalles(
                          encabezado: 'Pantalon2',
                          talleValor: tallesPantalon2,
                          actualizar: refreshP2)
                    ],
                  )
                else if (chaqueta_pantalon.contains(tipo)) //Chaqueta + Pantalon
                  Row(
                    children: [
                      SeleccionTalles(
                          encabezado: 'Chaqueta',
                          talleValor: tallesChaqueta,
                          actualizar: refresh),
                      SeleccionTalles(
                          encabezado: 'Pantalon',
                          talleValor: tallesPantalon,
                          actualizar: refreshP),
                    ],
                  )
              ]),
              Positioned(
                  left: 70,
                  top: 420,
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColoresApp.color_negro,
                        border: Border.all(
                            style: BorderStyle.solid,
                            width: 5,
                            color: Colors.white)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('  Cortador:   ',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 20,
                                color: Colors.white)),
                        DropdownButton(
                            underline: SizedBox(),
                            value: cortador,
                            items:
                                ['Carolina', 'Gaston', 'Seleccionar'].map((e) {
                              return DropdownMenuItem(
                                  alignment: Alignment.center,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 20,
                                        color: Colors.amber),
                                  ),
                                  value: e);
                            }).toList(),
                            onChanged: (nuevoValor) {
                              setState(() {
                                cortador = nuevoValor;
                              });
                            }),
                      ],
                    ),
                  )),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                          child: TextButton(
                              onPressed: () {
                                //llamar al bo y cargar ambo luego dar mensaje

                                if (cortador != 'Seleccionar') {
                                  final pprecio = calcularPrecios(tipo);

                                  Registro r = new Registro.ob(ambo_id, pprecio,
                                      color1, color2, tela, 2.5, cortador);
                                  Future<bool> error = DAO.agregarRegistro(r);
                                  if (error != true) {
                                    DAO.actualizarStockTela(
                                        r.tela,
                                        r.colorPrimario,
                                        r.colorSecundario,
                                        2,
                                        0.5);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text('Tela Actualizada :)')));
                                    Navigator.pushNamed(context, '/inicio');
                                  } else {
                                    print('Error al actualizar stock TELA');
                                  }
                                } else
                                  (ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Seleccionar Cortador '))));
                              },
                              child: Text("Enviar",
                                  style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.combine([
                                        TextDecoration.lineThrough,
                                      ]))),
                              style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Raleway',
                                      letterSpacing: 10),
                                  fixedSize: Size(50, 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  backgroundColor: ColoresApp.color_negro,
                                  elevation: 30,
                                  shadowColor: Colors.black)))
                    ],
                  )),
            ],
          ),
        ));
  }

/*
  void _confirmacion() {
    SimpleDialog(
      title: Text('Confirmar'),
      children: [
        SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'Main');
            },
            child: Text('Confirmar')),
        SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context, 'Main');
            },
            child: Text('Cancelar'))
      ],
    );
  }*/
  //Confirmacion si fue cargado con exito
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = ElevatedButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, '/inicio');
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirmación"),
      content: Text("Ambo Cargado"),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future calcularPrecios(String tipo) async {
    QuerySnapshot<Precios> lista_precios = await DAO.listaDePrecios();

    int precio = Tipos.getPrecio(tipo, lista_precios.docs[0].data()) ?? 0;
    final lista_especial = ['5', '6'];
    if (tallesChaqueta != 0) {
      if (lista_especial.contains(tallesChaqueta)) {
        precio += precio + Tipos.getPrecio('9', lista_precios.docs[0].data());
      }
    }

    if (tallesPantalon != 0) {
      if (lista_especial.contains(tallesPantalon)) {
        precio += precio + Tipos.getPrecio('9', lista_precios.docs[0].data());
      }
    }

//Pregunto si es 3 piezas
    if (tipo == '7') {
      precio += precio + Tipos.getPrecio('9', lista_precios.docs[0].data());
    }

    return precio;
  }
}

class SeleccionTalles extends StatefulWidget {
  final String encabezado;
  final int talleValor;
  final Function actualizar;

  const SeleccionTalles(
      {Key key, this.encabezado, this.talleValor, this.actualizar})
      : super(key: key);

  @override
  _SeleccionTallesState createState() => _SeleccionTallesState();
}

class _SeleccionTallesState extends State<SeleccionTalles> {
  final talles = <Talle>[
    Talle('XS', 2.0),
    Talle('S', 2.0),
    Talle('M', 2.0),
    Talle('L', 2.0),
    Talle('XL', 2.0),
    Talle('XXL', 2.0),
    Talle('XXXL', 2.0),
    Talle('S/T', 2.0)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('${widget.encabezado}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 25,
                fontFamily: 'Raleway')),
        SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  style: BorderStyle.solid, width: 5, color: Colors.white)),
          child: Column(
            children: [
              for (var i = 0; i < talles.length; i++)
                _talles(talles[i], i, widget.talleValor)
            ],
          ),
        )
      ],
    );
  }

  Widget _talles(Talle t, pos, int talleValor) {
    return Container(
        color: ColoresApp.color_gris,
        width: 110,
        child: RadioListTile(
            visualDensity: VisualDensity.compact,
            activeColor: Colors.amber,
            dense: true,
            selectedTileColor: Colors.white,
            title: Text(
              t.nombre,
              style: TextStyle(color: Colors.white),
            ),
            value: pos,
            groupValue: talleValor,
            tileColor: Colors.grey,
            onChanged: (value) {
              setState(() {
                talleValor = value;
                widget.actualizar(value);
              });
            }));
  }
}
