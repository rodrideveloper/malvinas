import 'package:flutter/material.dart';
import 'detalle.dart';
import 'models/ambo.dart';

void main() {
  runApp(Malvinas());
}

class Malvinas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: cuerpo(),
    );
  }
}

class cuerpo extends StatelessWidget {
  final items = <Ambo>[
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
    Ambo('Leontina', 20, 'XS', 'XS'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Buscar'),
        ),
        body: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.17,
                ),
                child: SafeArea(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detalle(ambo: items[i])));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)),
                        child: Column(
                          children: [
                            Flexible(
                                child: Image.asset('assets/img/juanita3p.jpg',
                                    height: size.height * .19)),
                            Text(
                              '${items[i].nombre}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('\$${items[i].precio}'),
                          ],
                        ),
                        color: Colors.white,
                        elevation: 10.0,
                      ),
                    );
                  },
                )))
          ],
        ));
  }
}
