import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Malvinas/models/Tela.dart';
import 'BO/dao.dart';

class ActualizarStock extends StatefulWidget {
  Telas tela;
  ActualizarStock({Key key}) : super(key: key);

  @override
  _ActualizarStockState createState() => _ActualizarStockState();
}

//Muestra 3 botones en pantalla, uno por cada tela
class _ActualizarStockState extends State<ActualizarStock> {
  Future<QuerySnapshot> leerTelas() async {
    return await DAO.leerTelasDAO();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      FutureBuilder<QuerySnapshot>(
          future: leerTelas(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                List<Telas> lista_telas = [];
                final List<DocumentSnapshot> documentos = snapshot.data.docs;

                documentos.forEach((element) {
                  print('DATOOOOOOOOOOO');
                  print(element.id);
                  print(element.id);
                  if (element != null) {
                    //  Telas tela =
                    //    new Telas(element['nombre'], element['Colores']);
                    Telas tela = new Telas.conId(
                        element.id, element['nombre'], element['Colores']);
                    lista_telas.add(tela);
                  }
                });
                return Container(
                    height: 400,
                    width: 400,
                    child: ListView.builder(
                        itemCount: lista_telas.length,
                        itemBuilder: (BuildContext context, int i) {
                          return TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/TelaStock',
                                    arguments: [lista_telas[i]]);
                              },
                              child: Center(
                                  child: Text(lista_telas[i].tipo_tela)));
                        }));
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          })
    ]));
  }
}
