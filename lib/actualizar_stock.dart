import 'package:cloud_firestore/cloud_firestore.dart';
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
                  print(element);
                  if (element != null) {
                    Telas tela =
                        new Telas(element['nombre'], element['Colores']);
                    lista_telas.add(tela);
                  }
                });
                return Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/TelaStock',
                            arguments: [lista_telas[0]]);
                      },
                      child: Center(child: Text(lista_telas[0].tipo_tela)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/TelaStock',
                            arguments: [lista_telas[1]]);
                      },
                      child: Center(child: Text(lista_telas[1].tipo_tela)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/TelaStock',
                            arguments: [lista_telas[2]]);
                      },
                      child: Center(child: Text(lista_telas[2].tipo_tela)),
                    )
                  ],
                );
              }
              return Text('Sin Coneccion');
            } else {
              return Container();
            }
          })
    ]));
  }
}
