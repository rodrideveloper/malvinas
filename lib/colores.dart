import 'package:flutter/material.dart';

class Colores {
  static Map<String, dynamic> colores = {
    'rojo': Colors.red,
    'azul': Color.fromARGB(255, 7, 27, 141),
    'negro': Colors.black,
    'amarillo': Colors.yellow,
    'fucsia': Colors.pink,
    'verde': Colors.green,
    'blanco': Colors.grey,
    'turquesa': Colors.lightBlue,
    'estampado': Color.lerp(Colors.white, Colors.black, 0.5),
    'bordo': Color.fromARGB(255, 95, 9, 9),
    'coral': Colors.pink[100],
    'naranja':Colors.orange,
    'azul francia':Color.fromARGB(255, 16, 85, 245),
    'lila':Color.fromARGB(255, 178, 142, 226),
    'violeta':Color.fromARGB(255, 73, 5, 112),
    'gris':Colors.grey,
    'estampado V&R':Colors.grey,
    'estampado V&V':Colors.grey,
    'estampado V&N':Colors.grey,
    'beige':Color.fromARGB(123, 245, 190, 102),
    'rosa':Color.fromARGB(255, 224, 153, 177)
  };
}
