import 'package:Malvinas/BO/dao.dart';
import 'package:Malvinas/models/registro_ventas.dart';
import 'package:Malvinas/utilidades/colores.dart';

import 'package:flutter/material.dart';

class DetalleCortador extends StatelessWidget {
  const DetalleCortador({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Detalle Cortador',
        ),
        backgroundColor: ColoresApp.color_negro,
      ),
      body: Container(
          height: 500, child: SingleChildScrollView(child: Pantalla())),
    );
  }
}

class Pantalla extends StatefulWidget {
  const Pantalla({Key key}) : super(key: key);

  @override
  State<Pantalla> createState() => _PantallaState();
}

Future<List<RegistroVentas>> listaRegistros() async {
  final listaRegistros = await DAO.listaDeRegistos();
  final listaAmbos = await DAO.leerAmbosDAO();
  List<RegistroVentas> listaRegistroVentas = [];

  listaRegistros.docs.forEach((lr) {
    RegistroVentas RV = new RegistroVentas();
    RV = lr.data();
    listaAmbos.docs.forEach((la) {
      if (la.id == lr.data().id) {
        RV.image_url = la.data().url;
        RV.ambo = la.data();
      }
    });

    listaRegistroVentas.add(RV);
  });
  return listaRegistroVentas;
}

class _PantallaState extends State<Pantalla> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 400,
          child: FutureBuilder<List<RegistroVentas>>(
              future: listaRegistros(),
              builder: (context, AsyncSnapshot<List<RegistroVentas>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return DetalleListAmbos(
                            snapshot: snapshot, index: index);
                      },
                    );
                  }
                }
                return Center(child: CircularProgressIndicator());
              }),
        )
      ],
    );
  }
}

class DetalleListAmbos extends StatefulWidget {
  final snapshot;
  final index;

  DetalleListAmbos({
    Key key,
    @required this.snapshot,
    @required this.index,
  }) : super(key: key);

  @override
  State<DetalleListAmbos> createState() => _DetalleListAmbosState();
}

class _DetalleListAmbosState extends State<DetalleListAmbos> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: CheckboxListTile(
          selectedTileColor: Colors.white,
          tileColor: ColoresApp.color_negro,
          onChanged: (bool value) {
            setState(() {
              _isSelected = value;
            });
          },
          value: _isSelected,
          secondary: ClipOval(
            child: Image.asset(
              widget.snapshot.data[widget.index].image_url,
              width: 35,
              height: 35,
              fit: BoxFit.cover,
            ),
          ),
          visualDensity: VisualDensity.compact,
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text(
            widget.index.toString() +
                '   -   ' +
                widget.snapshot.data[widget.index].ambo.modelo,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          activeColor: Colors.amber,
          checkColor: Colors.black,
        ));
  }
}
