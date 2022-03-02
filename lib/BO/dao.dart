import 'package:Malvinas/cargar_ambos.dart';
import 'package:Malvinas/models/Tela.dart';
import 'package:Malvinas/models/ambo.dart';
import 'package:Malvinas/models/precios.dart';
import 'package:Malvinas/models/registros.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DAO {
  bool enviarDatos(Ambo ambo) {}

//DEVUELVE UNA LISTA DENTRO DEL QUERYSNAP PARA USAR DENTRO DE UN FUTUREBUILDER
  static Future<QuerySnapshot> leerTelasDAO() async {
    return await FirebaseFirestore.instance.collection('telas').get();
  }

//Devuelve lista de ambos
  /*static Future<List<dynamic>> leerAmbosDAO() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('ambos').get();
    final List<dynamic> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    print(querySnapshot.docs[0].id);

    return allData;
  }*/
  static Future<QuerySnapshot<Ambo>> leerAmbosDAO() async {
    final collection =
        FirebaseFirestore.instance.collection('ambos').withConverter(
              fromFirestore: (snapshot, _) => Ambo.fromJson(snapshot.data()),
              toFirestore: (Ambo, _) => Ambo.toJson(),
            );

    final leerAmbos = (await collection.get());

    return leerAmbos;
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
  static Future<bool> agregarRegistro(Registro r) async {
    /*  QuerySnapshot<Precios> lista_precios = await listaDePrecios();
    ;
    int precio = 0;
    //Si es chaqueta sola
    switch (int.parse(tipo)) {
      case 0:
        precio = lista_precios.docs[0].data().chaqueta;
        break;
      //Si es pantalón solo
      case 9:
        precio = lista_precios.docs[0].data().pantalon;
        break;
      //Si es 3 piezas
      case 7:
        precio = lista_precios.docs[0].data().pantalon * 2;
        precio += lista_precios.docs[0].data().chaqueta;
        break;
      //Si es Chaqueta Murphy
      case 2:
        precio = lista_precios.docs[0].data().chaquetaMurphy;
        break;
      //Si es Chaqueta Leontina
      case 3:
        precio = lista_precios.docs[0].data().chaquetaLeontina;
        break;
      //Si es Chaqueta Abierta
      case 3:
        precio = lista_precios.docs[0].data().cha;
        break;
    }
*/
    bool error = false;
    CollectionReference regRef =
        FirebaseFirestore.instance.collection('registros');
    regRef
        .add({
          'ambo_id': r.ambo_id,
          'precio': r.precio,
          'tela': r.tela,
          'color1': r.colorPrimario,
          'color2': r.colorSecundario,
          'metros': r.metros,
          'cortador': r.cortador
        })
        .then((value) => print('Registro Agregado con Exito'))
        .catchError((error) => error = true);

    return error;
  }

  static actualizarStockTela(String tela, String color1, String color2,
      double metros1, double metros2) async {
    bool error = false;
    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection('telas')
        .where('nombre', isEqualTo: tela)
        .get();
    QueryDocumentSnapshot doc = querySnap.docs[0];
    String myID = doc.id;
    Map mapa = doc.data();

    mapa['Colores'][color1] =
        (double.parse(mapa['Colores'][color1]) - metros1).toString();
    mapa['Colores'][color2] =
        (double.parse(mapa['Colores'][color2]) - metros2).toString();

    await FirebaseFirestore.instance
        .collection('telas')
        .doc(myID)
        .update({'Colores': mapa['Colores']})
        .then((value) => print("Tela Actualizada"))
        .catchError((error) {
          print("Error al actualizar tela: $error");
          error = true;
        });
  }

  static Future<QuerySnapshot> leerRegistros() async {
    return await FirebaseFirestore.instance.collection('registros').get();
  }

  static bool agregarAmbo(AmboCarga a) {
    bool error = false;
    CollectionReference regRef = FirebaseFirestore.instance.collection('ambos');
    regRef
        .add({
          'modelo': a.modelo,
          'tipo': a.tipo,
          'telas_disponibles': a.telas_disponibles,
          'color_primario': a.color1,
          'color_secundario': a.color2,
          'url': a.url_imagen,
          'tela_principal': a.tela_principal
        })
        .then((value) => print('Registro Agregado con Exito'))
        .catchError((error) => error = true);
    print(error);

    return error;
  }

  static Future<QuerySnapshot<Precios>> listaDePrecios() async {
    final collection =
        FirebaseFirestore.instance.collection('precios').withConverter(
              fromFirestore: (snapshot, _) => Precios.fromJson(snapshot.data()),
              toFirestore: (Precios, _) => Precios.toJson(),
            );
    final listaPrecios = (await collection.get());

    return listaPrecios;
  }
}
