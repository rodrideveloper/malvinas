import 'package:Malvinas/main_seleccionarColor(3).dart';
import 'package:Malvinas/utilidades/colores.dart';
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
        backgroundColor: ColoresApp.color_negro,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              HeroWidget(widget: widget),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: ColoresApp.color_negro,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Modelo: ${widget.ambo.nombre}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text('Seleccionar Tela',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 40),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .5,
                        child: Container(
                            color: Colors.white,
                            child: SeleccionarTelaDropButton(telas)),
                      ),
                      arrowNavegacion(
                          telaSeleccionada: telaSeleccionada, widget: widget)
                    ],
                  ),
                ),
              ),
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
          fontSize: 20,
          letterSpacing: 10),
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

class arrowNavegacion extends StatelessWidget {
  const arrowNavegacion({
    Key key,
    @required this.telaSeleccionada,
    @required this.widget,
  }) : super(key: key);

  final String telaSeleccionada;
  final AmboHeroe widget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
                Navigator.pushNamed(context, '/SeleccionarColor',
                    arguments: [telaSeleccionada, widget.ambo.nombre]);
              },
              child: Icon(
                Icons.keyboard_arrow_right,
                size: 70,
              )),
        ]),
      ),
    );
  }
}

class HeroWidget extends StatelessWidget {
  const HeroWidget({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final AmboHeroe widget;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 2, color: Color(0xFF04589A))),
        ),
        child: Hero(
          tag: 'imageHero',
          child: widget.ambo.image,
        ));
  }
}
