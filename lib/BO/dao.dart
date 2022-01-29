import 'package:Malvinas/models/Tela.dart';
import 'package:Malvinas/models/ambo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DAO {
  bool enviarDatos(Ambo ambo) {}

//DEVUELVE UNA LISTA DE FUTURE TELAS
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

  static Future<QuerySnapshot> leerSoloUnaDAO(String nombre_tela) async {
    QuerySnapshot _querySnapshot = await FirebaseFirestore.instance
        .collection("telas")
        .where('nombre', isEqualTo: nombre_tela)
        .get();

    return _querySnapshot;
  }

  static actualizarStockPorColor(Telas tela) async {
    print('jjjjjjj');
    await FirebaseFirestore.instance
        .collection("telas")
        .doc('EOsC1cyjlAYwMuvbtzr9')
        .update({'Colores': tela.metros_colores})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
}
