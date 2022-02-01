import 'package:Malvinas/models/Tela.dart';
import 'package:Malvinas/models/ambo.dart';
import 'package:Malvinas/models/registros.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DAO {
  bool enviarDatos(Ambo ambo) {}

//DEVUELVE UNA LISTA DENTRO DEL QUERYSNAP PARA USAR DENTRO DE UN FUTUREBUILDER
  static Future<QuerySnapshot> leerTelasDAO() async {
    return await FirebaseFirestore.instance.collection('telas').get();
  }

//Devuelve lista de ambos
  static Future<List<dynamic>> leerAmbosDAO() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ambos').get();
    final List<dynamic> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

//Devuelvo un futuro con lista de telas
  static Future<List<dynamic>> leerListaTelasDAO() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('telas').get();
    final List<dynamic> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  static Future<QuerySnapshot> leerSoloUnaDAO(String nombre_tela) async {
    QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
        .collection('telas')
        .where('nombre', isEqualTo: nombre_tela)
        .get();

    // final List<dynamic> allData =
    //   _querySnapshot.docs.map((doc) => doc.data()).toList();

    return _querySnapshot;
  }

  static actualizarStockPorColor(Telas tela) async {
    await FirebaseFirestore.instance
        .collection('telas')
        .doc(tela.id)
        .update({'Colores': tela.metros_colores})
        .then((value) => print("Tela Actualizada"))
        .catchError((error) => print("Error al actualizar tela: $error"));
  }

  //Agregar registro de ambo cortado
  static bool agregarRegistro(Registro r) {
    bool error = false;
    CollectionReference regRef =
        FirebaseFirestore.instance.collection('registros');
    regRef
        .add({
          'nombre': r.nombre,
          'tela': r.tela,
          'color1': r.colorPrimario,
          'color2': r.ColorSecundario,
          'talle_chaqueta': r.talleChaqueta,
          'talle_pantalon': r.tallePantalon,
          'metros': r.metros
        })
        .then((value) => print('agregado'))
        .catchError((error) => error = true);

    return error;
  }

  static actualizarStockTela(String tela, String color1, String color2,
      double metros1, double metros2) async {
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection('telas')
        .where('nombre', isEqualTo: tela)
        .get();
    QueryDocumentSnapshot doc = querySnap.docs[0];
    String myID = doc.id;
    Map mapa = doc.data();
    print(mapa);
    mapa['Colores'][color1] = mapa['Colores'][color1] - metros1;
    mapa['Colores'][color2] = mapa['Colores'][color2] - metros2;

    await FirebaseFirestore.instance
        .collection('telas')
        .doc(myID)
        .update({'Colores': mapa['Colores']})
        .then((value) => print("Tela Actualizada"))
        .catchError((error) => print("Error al actualizar tela: $error"));
  }
}
