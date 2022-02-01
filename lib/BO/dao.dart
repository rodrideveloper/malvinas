import 'package:Malvinas/models/Tela.dart';
import 'package:Malvinas/models/ambo.dart';
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
}
