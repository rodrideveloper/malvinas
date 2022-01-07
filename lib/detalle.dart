import 'package:Malvinas/models/ambo.dart';
import 'package:Malvinas/models/talle.dart';
import 'package:flutter/material.dart';
import 'BO/adatos.dart';

class Detalle extends StatefulWidget {
  final Ambo ambo;

  Detalle({Key key, this.ambo}) : super(key: key);

  @override
  _DetalleState createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  List<String> _telas = ['Arciel', 'Batista', 'Spandex'];
  String tipoTela = 'Arciel';

  final talles = <Talle>[
    Talle('XS', 2.0),
    Talle('S', 2.0),
    Talle('M', 2.0),
    Talle('L', 2.0),
    Talle('XL', 2.0),
    Talle('XXL', 2.0),
    Talle('XXXL', 2.0),
    Talle('Ninguno', 2.0)
  ];
  int _grupValue = 0;
  @override
  Widget build(BuildContext context) {
    // Usa el objeto Todo para crear nuestra UI
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.ambo.nombre),
        ),
        body: Padding(
          padding: EdgeInsets.all(2.0),
          child: Stack(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Column(
                children: <Widget>[
                  Text("Chaqueta",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  for (var i = 0; i < talles.length; i++) _talles(talles[i], i)
                ],
              ),
              Column(
                children: <Widget>[
                  Text("Pantalón",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  for (var i = 0; i < talles.length; i++) _talles(talles[i], i)
                ],
              )
            ]),
            Positioned(
                bottom: 80,
                left: 80,
                child: Row(children: [
                  Container(
                    width: 200,
                    child: DropdownButton<String>(
                      value: tipoTela,
                      isExpanded: true,
                      elevation: 50,
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      items: <String>['Arciel', 'Batista', 'Spandex']
                          .map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                              child:
                                  new Text(value, textAlign: TextAlign.center)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          tipoTela = value;
                          print(tipoTela);
                        });
                      },
                    ),
                  )
                ])),
            Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Expanded(
                        child: TextButton(
                            onPressed: _enviar(),
                            child: Text("OK"),
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.green.shade400,
                                elevation: 30,
                                shadowColor: Colors.black)))
                  ],
                ))
          ]),
        ));
  }

  Widget _talles(Talle t, int pos) {
    return Container(
        width: 150,
        child: RadioListTile(
            dense: true,
            title: Text(t.nombre),
            value: pos,
            groupValue: _grupValue,
            onChanged: (value) {
              setState(() {
                _grupValue = value;
              });
            }));
  }

  _enviar() {
    enviardatos();
  }
}
