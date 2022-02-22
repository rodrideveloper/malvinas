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
  String telaSeleccionada = 'Batista';
  String ambo_id;
  @override
  Widget build(BuildContext context) {
    telaSeleccionada == widget.ambo.telas_disponibles[0];
    ambo_id = widget.ambo.id;

    List<String> telas = [];
    widget.ambo.telas_disponibles.forEach((e) {
      telas.add(e.toString());
    });

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: ColoresApp.color_gris,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, '/SeleccionarColor', arguments: [
            telaSeleccionada,
            widget.ambo.id,
            widget.ambo.modelo
          ]);
        },
        child: Icon(Icons.keyboard_arrow_right, size: 55, color: Colors.white),
      ),
      appBar: AppBar(
        centerTitle: true,
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
                        'Modelo: ${widget.ambo.modelo}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text('Seleccionar Tela',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.combine([
                                TextDecoration.lineThrough,
                              ]))),
                      SizedBox(height: 40),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width * .5,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    width: 5,
                                    color: Colors.white)),
                            child: SeleccionarTelaDropButton(telas)),
                      ),
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
          letterSpacing: 8),
      items: telas.map<DropdownMenuItem<String>>((element) {
        return DropdownMenuItem<String>(
            value: element,
            child:
                Container(alignment: Alignment.center, child: Text(element)));
      }).toList(),
      onChanged: (nuevoValor) {
        setState(() {
          this.telaSeleccionada = nuevoValor;
        });
      },
      value: telaSeleccionada,
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
          border: Border(bottom: BorderSide(width: 2, color: Colors.amber)),
        ),
        child: Hero(
          tag: 'imageHero',
          child: Image.asset(widget.ambo.url),
        ));
  }
}

class flechasSiguiente extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: ColoresApp.color_gris,
        child: Icon(Icons.keyboard_arrow_right, size: 70, color: Colors.white),
      ),
    );
  }
}

class flechaAnterior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: ColoresApp.color_gris,
        child: Icon(Icons.keyboard_arrow_left, size: 70, color: Colors.white),
      ),
    );
  }
}
