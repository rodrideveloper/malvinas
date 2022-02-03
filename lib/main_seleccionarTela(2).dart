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
      appBar: AppBar(
        title: Text('Seleccionar Tela'),
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                  width: 300,
                  height: 300,
                  child: Hero(
                    tag: 'imageHero',
                    child: widget.ambo.image,
                  )),
              Text('Modelo: ${widget.ambo.nombre}'),
              SizedBox(height: 20),
              Text('Seleccionar Tela',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.ambo.telas_disponibles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          child: Text(
                            widget.ambo.telas_disponibles[index].toString(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, '/SeleccionarColor', arguments: [
                              widget.ambo.telas_disponibles[index].toString(),
                              widget.ambo.nombre
                            ]);
                          },
                        ),
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
