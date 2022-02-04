import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'BO/dao.dart';
import 'models/registros.dart';

class SeguimientoCortadores extends StatefulWidget {
  const SeguimientoCortadores({Key key}) : super(key: key);

  @override
  _SeguimientoCortadoresState createState() => _SeguimientoCortadoresState();
}

class _SeguimientoCortadoresState extends State<SeguimientoCortadores> {
  int carolina = 0;
  int gaston = 0;

  Future<QuerySnapshot> leerRegistros() async {
    return await DAO.leerRegistros();
  }

  @override
  Widget build(BuildContext context) {
    //List<Registro> registros =

    //print(registros);
    return Scaffold(
      appBar: AppBar(title: Text('Tabla de Cortado ')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: 200,
                width: 200,
                child: FutureBuilder<QuerySnapshot>(
                  future: leerRegistros(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documentos =
                            snapshot.data.docs;
                        documentos.forEach((e) {
                          Map mapa = e.data();
                          if (mapa['cortador'] != null) {
                            if (mapa['cortador'] == 'Carolina') {
                              carolina++;
                            } else if (mapa['cortador'] == 'Gaston') {
                              gaston++;
                            }
                            ;
                          }
                        });
                        return Container(
                          alignment: Alignment.center,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Cortados por Carolina :  ${carolina}',
                                  style: TextStyle(fontSize: 30),
                                ),
                                SizedBox(height: 50),
                                Text('Cortados por Gaston :  ${gaston}',
                                    style: TextStyle(fontSize: 30))
                              ],
                            ),
                          ),
                        );
                      }
                      return Container();
                    } else {
                      return Center(
                          child: Container(
                              padding: const EdgeInsets.all(0.0),
                              child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.blueGrey),
                              )));
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
