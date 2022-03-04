import 'package:Malvinas/BO/dao.dart';
import 'package:Malvinas/models/registro_ventas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetalleCortador extends StatelessWidget {
  const DetalleCortador({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalle Cortador',
          textAlign: TextAlign.center,
        ),
      ),
      body: Pantalla(),
    );
  }
}

class Pantalla extends StatefulWidget {
  const Pantalla({Key key}) : super(key: key);

  @override
  State<Pantalla> createState() => _PantallaState();
}

Future<QuerySnapshot<RegistroVentas>> listaRegistros() async {
  final listaRegistros = await DAO.listaDeRegistos();

  return listaRegistros;
}

class _PantallaState extends State<Pantalla> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 400,
          child: FutureBuilder<QuerySnapshot<RegistroVentas>>(
              future: listaRegistros(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<RegistroVentas>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.asset(
                              snapshot.data.docs[0].data().image_url,
                              width: 20),
                          trailing: Text(
                              snapshot.data.docs[0].data().precio.toString()),
                          title: Text(snapshot.data.docs[0].data().ambo.modelo),
                        );
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
