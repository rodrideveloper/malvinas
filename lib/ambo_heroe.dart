import 'package:Malvinas/seleccionarColor.dart';
import 'package:flutter/material.dart';
import 'package:Malvinas/models/ambo.dart';

//Seleccionar tipo de tela dentro de las disponibles en cada ambo
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
      body: Container(
        height: 500,
        width: 400,
        child: Column(
          children: [
            Container(
                child: Hero(
              tag: 'imageHero',
              child: widget.ambo.image,
            )),
            Text(widget.ambo.nombre),
            Container(
              height: 100,
              child: ListView.builder(
                  itemCount: widget.ambo.telas_disponibles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TextButton(
                      child:
                          Text(widget.ambo.telas_disponibles[index].toString()),
                      onPressed: () {
                        Navigator.pushNamed(context, '/SeleccionarColor',
                            arguments: [
                              widget.ambo.telas_disponibles[index].toString()
                            ]);
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
