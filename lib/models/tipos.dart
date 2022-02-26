import 'package:Malvinas/models/precios.dart';

class Tipos {
  static Map<String, dynamic> tipo_ambo = {
    '0': 'Chaqueta',
    '1': 'Chaqueta abierta',
    '2': 'Chaqueta Murphy',
    '3': 'Chaqueta Leontina  ',
    '4': 'Chaqueta Murphy + Pantalon',
    '5': 'Chaqueta + Pantalon',
    '6': 'Chaqueta Leontina + Pantalon',
    '7': '3 piezas',
    '8': 'Pantalon',
    '9': 'Talle Especial'
  };

  static int getPrecio(String tipo, Precios lista_precios) {
    int precio = 50;
    if (lista_precios != null) {
      switch (int.parse(tipo)) {
        case 0:
          precio = lista_precios.chaqueta;
          break;
        case 1:
          precio = lista_precios.chaqueta_abierta;
          break;
        case 2:
          precio = lista_precios.chaquetaMurphy;
          break;
        case 3:
          precio = lista_precios.chaquetaLeontina;
          break;
        case 4:
          precio = lista_precios.chaquetaMurphy + lista_precios.pantalon;
          break;
        case 5:
          precio = lista_precios.chaqueta + lista_precios.pantalon;
          break;
        case 6:
          precio = lista_precios.chaquetaLeontina + lista_precios.pantalon;
          break;
        case 7:
          precio = lista_precios.chaqueta + (lista_precios.pantalon * 2);
          break;
        case 8:
          precio = lista_precios.pantalon;
          break;
        case 9:
          precio = lista_precios.talleEspecial;
          break;
      }
    }
    return precio;
  }
}
