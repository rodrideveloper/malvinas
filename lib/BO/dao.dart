import 'package:Malvinas/models/ambo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DAO {
  bool enviarDatos(Ambo ambo) {}

//DEVUELVE UNA LISTA DE FUTURE TELAS
  static Future<QuerySnapshot> leerTelasDAO() async {
    return await FirebaseFirestore.instance.collection('telas').get();
  }

  static Future<List> leerAmbosDAO() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ambos').get();
    final List allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print(allData);
    return allData;
  }
}
