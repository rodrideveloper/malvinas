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
  String telaSeleccionada = '';
  @override
  Widget build(BuildContext context) {
    telaSeleccionada == widget.ambo.telas_disponibles[0];
    List<String> telas = [];
    widget.ambo.telas_disponibles.forEach((e) {
      telas.add(e.toString());
    });
    telaSeleccionada = telas[0];

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
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 4, color: Color(0xFF04589A))),
                  ),
                  child: Hero(
                    tag: 'imageHero',
                    child: widget.ambo.image,
                  )),
              SizedBox(height: 10),
              Text('Modelo: ${widget.ambo.nombre}'),
              SizedBox(height: 20),
              Text('Seleccionar Tela',
                  style: TextStyle(
                    fontSize: 20,
                  )),
              SizedBox(height: 20),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * .5,
                child: SeleccionarTelaDropButton(telas),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.keyboard_arrow_left,
                                size: 70,
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/SeleccionarColor', arguments: [
                                  telaSeleccionada,
                                  widget.ambo.nombre
                                ]);
                              },
                              child: Icon(
                                Icons.keyboard_arrow_right,
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

  DropdownButton<String> SeleccionarTelaDropButton(List<String> telas) {
    return DropdownButton<String>(
      elevation: 6,
      isExpanded: true,
      dropdownColor: Colors.white,
      icon: Icon(Icons.arrow_drop_down),
      underline: SizedBox(),
      iconSize: 30,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Raleway',
      ),
      items: telas.map<DropdownMenuItem<String>>((element) {
        return DropdownMenuItem<String>(
            value: element,
            child:
                Container(alignment: Alignment.center, child: Text(element)));
      }).toList(),
      onChanged: (nuevoValor) {
        this.telaSeleccionada = nuevoValor;
      },
      value: telaSeleccionada,
    );
  }
}
