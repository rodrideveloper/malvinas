import 'package:flutter/cupertino.dart';

class Ambo {
  String nombre;
  int precio;
  String talleChaqueta;
  String tallePantalon;
  Image image;

  Ambo(this.nombre, this.precio, this.talleChaqueta, this.tallePantalon,
      this.image);

  static List<Ambo> getAmbos() {
    final items = <Ambo>[
      Ambo('Leontina', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Blue', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Femme', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Juanita', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Lucrecia', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('3 piezas', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Arciel', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Batista', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Caramelo', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Fuerza', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Leon 2', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
      Ambo('Hombre', 20, 'XS', 'XS', Image.asset('assets/img/juanita3p.jpg')),
    ];
    return items;
  }
}
