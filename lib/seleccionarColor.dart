import 'package:flutter/material.dart';
import 'BO/dao.dart';
import 'models/Tela.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeleccionarColor extends StatefulWidget {
  final String tela;

  SeleccionarColor({Key key, this.tela}) : super(key: key);

  @override
  _SeleccionarColorState createState() => _SeleccionarColorState();
}

class _SeleccionarColorState extends State<SeleccionarColor> {
  String valor = 'rojo';

  List<Telas> listaTelas = [];
  Map<String, dynamic> mapa = {};

  @override
  void initState() {
    super.initState();
  }

  Future<QuerySnapshot> llenarListaTelas() async {
    final args = ModalRoute.of(context).settings.arguments as List<String>;

    return await DAO.leerSoloUnaDAO(args[0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 400,
      child: FutureBuilder<QuerySnapshot>(
          future: llenarListaTelas(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<DocumentSnapshot> listaDoc = snapshot.data.docs;
                listaDoc.forEach((element) {
                  listaTelas
                      .add(new Telas(element['nombre'], element['Colores']));
                });
                return Container(
                    height: 400,
                    width: 400,
                    child: Row(
                      children: [
                        botonColores2(listaTelas),
                        botonColores2(listaTelas),
                      ],
                    ));
              }
              return Container();
            }
            return Container();
          }),
    ));
  }

  Widget botonColores2(List<Telas> telas) {
    List llaves = telas[0].metros_colores.keys.toList();
    print(llaves);
    return DropdownButton(
        elevation: 6,
        dropdownColor: Colors.white,
        icon: Icon(Icons.arrow_drop_down),
        underline: SizedBox(),
        iconSize: 30,
        style: TextStyle(color: Colors.black),
        items: llaves.map((dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Text(
              dropDownStringItem,
              style: TextStyle(fontSize: 16.0),
            ),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this.valor = newValueSelected;
          });
        },
        value: valor);
  }
}

/*items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String nuevoValor) {
                setState(() {
                  valor = nuevoValor;
                });
              });*/
