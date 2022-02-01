import 'package:Malvinas/main_seleccionarColor(3).dart';
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
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
                        child: Text(
                            widget.ambo.telas_disponibles[index].toString()),
                        onPressed: () {
                          Navigator.pushNamed(context, '/SeleccionarColor',
                              arguments: [
                                widget.ambo.telas_disponibles[index].toString(),
                                widget.ambo.nombre
                              ]);
                        },
                      );
                    }),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                size: 70,
                              )),
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
