import 'package:Malvinas/models/tipos.dart';
import 'package:flutter/material.dart';
import 'BO/dao.dart';

class CargarAmbos extends StatefulWidget {
  @override
  _CargarAmbosState createState() => _CargarAmbosState();
}

class _CargarAmbosState extends State<CargarAmbos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Cuerpo(),
    );
  }
}

class Cuerpo extends StatelessWidget {
  final Modelo = TextEditingController();
  final Tipo_C = TextEditingController();

  final Color1 = TextEditingController();
  final Color2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: Modelo,
              decoration: InputDecoration(hintText: 'Modelo'),
            ),
            TextField(
              controller: Color1,
              decoration: InputDecoration(hintText: 'Color 1'),
            ),
            TextField(
              controller: Color2,
              decoration: InputDecoration(hintText: 'Color2'),
            ),
            TextField(
              controller: Tipo_C,
              decoration: InputDecoration(hintText: 'Tipo'),
            ),
            TextButton(
              onPressed: () {
                EnviarDatos();
              },
              child: Text('Enviar'),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.teal,
                onSurface: Colors.grey,
              ),
            )
          ],
        ));
  }

  EnviarDatos() {
    String Amodelox = Modelo.text;
    String tipo = Tipo_C.text;
    String Acolor1 = Color1.text;
    String AColor2 = Color2.text;
    List<String> telas_disponibles = ['Batista', 'Arciel', 'Spandex'];
    String url_image = 'assets/img/${Amodelox}.jpg';

    AmboCarga a = new AmboCarga(
        Amodelox, telas_disponibles, Acolor1, AColor2, url_image, tipo);

    DAO.agregarAmbo(a);
  }
}

class AmboCarga {
  String modelo;

  List<String> telas_disponibles;
  String color1;
  String color2;
  String url_imagen;
  String tipo;

  AmboCarga(this.modelo, this.telas_disponibles, this.color1, this.color2,
      this.url_imagen, this.tipo);
}
