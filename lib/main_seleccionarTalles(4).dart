import 'package:Malvinas/models/ambo.dart';
import 'package:Malvinas/models/registros.dart';
import 'package:Malvinas/models/talle.dart';
import 'package:Malvinas/utilidades/colores.dart';
import 'package:flutter/material.dart';
import 'BO/dao.dart';

class Detalle extends StatefulWidget {
  final Ambo ambo;

  Detalle({Key key, this.ambo}) : super(key: key);

  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  String tipoTela = 'Arciel';
  String cortador = 'Seleccionar';

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

  int _tallesChaqueta = 0;
  int _tallesPantalon = 0;
  @override
  Widget build(BuildContext context) {
    final argumentos =
        ModalRoute.of(context).settings.arguments as List<String>;
    String nombreAmbo = argumentos[3];
    String tela = argumentos[0];
    ;
    String color1 = argumentos[1];
    ;
    String color2 = argumentos[2];
    ;

    // Usa el objeto Todo para crear nuestra UI
    return Scaffold(
        appBar: AppBar(
            title: Text(nombreAmbo),
            backgroundColor: ColoresApp.color_negro,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.0),
                    bottomRight: Radius.circular(25.0)))),
        body: Padding(
            padding: EdgeInsets.all(2.0),
            child: Stack(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Chaqueta",
                          style: TextStyle(
                              color: ColoresApp.color_negro,
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                      for (var i = 0; i < talles.length; i++)
                        _tallesC(talles[i], i)
                    ],
                  ),
                  SizedBox(width: 40),
                  Column(children: <Widget>[
                    Text("Pantalón",
                        style: TextStyle(
                            color: ColoresApp.color_negro,
                            fontWeight: FontWeight.bold,
                            fontSize: 30)),
                    for (var i = 0; i < talles.length; i++)
                      _tallesP(talles[i], i)
                  ])
                ]),
                Positioned(
                    left: 80,
                    top: 420,
                    child: Row(
                      children: [
                        Text('Cortador:   ',
                            style: TextStyle(
                                fontFamily: 'Montserrat', fontSize: 20)),
                        DropdownButton(
                            value: cortador,
                            items:
                                ['Carolina', 'Gaston', 'Seleccionar'].map((e) {
                              return DropdownMenuItem(
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat', fontSize: 20),
                                  ),
                                  value: e);
                            }).toList(),
                            onChanged: (nuevoValor) {
                              setState(() {
                                cortador = nuevoValor;
                              });
                            }),
                      ],
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
                                    Registro r = new Registro.ob(
                                        nombreAmbo,
                                        _tallesChaqueta,
                                        _tallesPantalon,
                                        color1,
                                        color2,
                                        tela,
                                        2.5,
                                        cortador);
                                    bool error = DAO.agregarRegistro(r);
                                    if (error != true) {
                                      DAO.actualizarStockTela(
                                          r.tela,
                                          r.colorPrimario,
                                          r.colorSecundario,
                                          2,
                                          0.5);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Tela Actualizada :)')));
                                      Navigator.pushNamed(context, '/inicio');
                                    } else {
                                      print('Error al actualizar stock TELA');
                                    }
                                  } else
                                    (ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Seleccionar Cortador '))));
                                },
                                child: Text("Enviar",
                                    style: TextStyle(color: Colors.white)),
                                style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 25),
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
            )));
  }

  Widget _tallesC(Talle t, pos) {
    return Container(
        color: ColoresApp.color_gris,
        width: 120,
        child: RadioListTile(
            activeColor: Colors.white,
            dense: true,
            selectedTileColor: Colors.white,
            title: Text(
              t.nombre,
              style: TextStyle(color: Colors.white),
            ),
            value: pos,
            groupValue: _tallesChaqueta,
            tileColor: Colors.grey,
            onChanged: (value) {
              setState(() {
                _tallesChaqueta = value;
              });
            }));
  }

  Widget _tallesP(Talle t, pos) {
    return Container(
        color: ColoresApp.color_gris,
        width: 120,
        child: RadioListTile(
            activeColor: Colors.white,
            selectedTileColor: Colors.white,
            tileColor: Colors.grey,
            dense: true,
            title: Text(
              t.nombre,
              style: TextStyle(color: Colors.white),
            ),
            value: pos,
            groupValue: _tallesPantalon,
            onChanged: (value) {
              setState(() {
                _tallesPantalon = value;
              });
            }));
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
}
