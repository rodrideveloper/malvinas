import 'package:flutter/material.dart';
import 'package:Malvinas/models/ambo.dart';

class AmboHeroe extends StatefulWidget {
  final Ambo ambo;

  const AmboHeroe({Key key, this.ambo}) : super(key: key);

  @override
  _AmboHeroeState createState() => _AmboHeroeState();
}

class _AmboHeroeState extends State<AmboHeroe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              child: Hero(
            tag: 'imageHero',
            child: widget.ambo.image,
          )),
          Text(widget.ambo.nombre),
          Text(widget.ambo.telas_disponibles[0].toString()),
        ],
      ),
    );
  }
}
