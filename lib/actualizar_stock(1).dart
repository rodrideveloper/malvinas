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
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FutureBuilder<QuerySnapshot>(
              future: leerTelas(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<Telas> lista_telas = [];
                    final List<DocumentSnapshot> documentos =
                        snapshot.data.docs;

                    documentos.forEach((element) {
                      if (element != null) {
                        //  Telas tela =
                        //    new Telas(element['nombre'], element['Colores']);
                        Telas tela = new Telas.conId(
                            element.id, element['nombre'], element['Colores']);
                        lista_telas.add(tela);
                      }
                    });
                    return Stack(children: [
                      Column(
                        children: [
                          SizedBox(height: 100),
                          Expanded(
                            child: Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.bottomRight,
                              child: ListView.builder(
                                itemCount: lista_telas.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, '/TelaStock',
                                            arguments: [lista_telas[i]]);
                                      },
                                      child: Text(lista_telas[i].tipo_tela));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]);
                  } else {
                    return Container();
                  }
                } else {
                  return Container();
                }
              })
        ]),
      ),
    );
  }
}
 /*Align(
                        alignment: Alignment.bottomCenter,
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
                      ),*/