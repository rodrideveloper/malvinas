import 'package:Malvinas/utilidades/colores.dart';
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 20,
          backgroundColor: ColoresApp.color_gris,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.close, size: 55, color: Colors.white),
        ),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColoresApp.color_negro,
            title: Text('Tabla de Cortado ')),
        body: Center(
          child: Container(
            child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/DetalleCortador');
                },
                child: Text('Ver Detalle')),
          ),
        ));
  }
}
/*Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
                    return 
                    
                    Column(
                      children: [
                        Material(
                          elevation: 10,
                          child: Container(
                              width: 250,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/img/tabla.jpg"),
                                fit: BoxFit.cover,
                              )),
                              child: Column(
                                children: [
                                  Text(
                                    'Cortados por Carolina ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 15),
                                  Text('${carolina}',
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold))
                                ],
                              )),
                        ),
                        SizedBox(height: 50),
                        Material(
                          elevation: 10,
                          child: Container(
                              width: 250,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/img/tabla.jpg"),
                                fit: BoxFit.cover,
                              )),
                              child: Column(
                                children: [
                                  Text(
                                    'Cortados por Gastón ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 15),
                                  ClipOval(
                                    child: Container(
                                      child: Center(
                                        child: Text('${gaston}',
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.amber,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
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
      ),*/