import 'package:Malvinas/models/Tela.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TelaStock extends StatefulWidget {
  String tela;
  TelaStock({Key key, this.tela}) : super(key: key);

  @override
  _TelaStockState createState() => _TelaStockState();
}

class _TelaStockState extends State<TelaStock> {
  @override
  void initState() {
    //Traer tela segun la tela seleccionada : widget.tela
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List<Telas>;
    List llaves = args[0].metros_colores.keys.toList();
    List valores = args[0].metros_colores.values.toList();

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(args[0].tipo_tela),
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(15),
                    elevation: 10,
                    child: Container(
                      height: 500,
                      width: 400,
                      child: ListView.builder(
                          itemCount: args[0].metros_colores.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleChildScrollView(
                                child: Card(
                              elevation: 50,
                              child: TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  maxLength: 6,
                                  decoration: InputDecoration(
                                    labelText: llaves[index].toString(),
                                    border: OutlineInputBorder(),
                                    hintText: valores[index].toString(),
                                  )),
                            ));
                          }),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Volver'))
              ],
            ),
          ),
        ));
  }

  Card cardColores(Map<String, dynamic> map) {
    Card c = Card();

    return c;
  }
}
