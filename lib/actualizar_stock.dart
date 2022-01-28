import 'package:Malvinas/tela_stock.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Malvinas/models/Tela.dart';

class ActualizarStock extends StatefulWidget {
  Telas tela;
  ActualizarStock({Key key}) : super(key: key);

  @override
  _ActualizarStockState createState() => _ActualizarStockState();
}

//Muestra 3 botones en pantalla, uno por cada tela
class _ActualizarStockState extends State<ActualizarStock> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(children: [
      TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/TelaStock', arguments: {
              'tipo_tela': 'Batista',
            });
          },
          child: Text('Batista')),
      TextButton(onPressed: () {}, child: Text('Arciel')),
      TextButton(onPressed: () {}, child: Text('Spandex'))
    ]));
  }
}
