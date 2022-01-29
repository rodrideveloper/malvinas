import 'package:Malvinas/models/Tela.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'BO/dao.dart';

class TelaStock extends StatefulWidget {
  String tela;
  TelaStock({Key key, this.tela}) : super(key: key);

  @override
  _TelaStockState createState() => _TelaStockState();
}

class _TelaStockState extends State<TelaStock> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as List<Telas>;
    List llaves = args[0].metros_colores.keys.toList();
    final List valores = args[0].metros_colores.values.toList();
    List<TextEditingController> Listacontroladores =
        controladores(llaves.length, valores);
    Map<String, dynamic> mapaActualizar = args[0].metros_colores;

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
                      height: 400,
                      width: 400,
                      child: ListView.builder(
                          itemCount: args[0].metros_colores.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SingleChildScrollView(
                                child: Card(
                              elevation: 50,
                              child: TextField(
                                  controller: Listacontroladores[index],
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  maxLength: 6,
                                  decoration: InputDecoration(
                                    labelText: llaves[index].toString(),
                                    border: OutlineInputBorder(),
                                  )),
                            ));
                          }),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Volver')),
                TextButton(
                    onPressed: () {
                      int i = 0;
                      mapaActualizar.forEach((key, value) {
                        mapaActualizar[key] = Listacontroladores[i].text;
                        i++;
                      });

                      DAO.actualizarStockPorColor(new Telas.conId(
                          args[0].id, args[0].tipo_tela, mapaActualizar));
                    },
                    child: Text('Actualizar'))
              ],
            ),
          ),
        ));
  }

  List<TextEditingController> controladores(int cantidad, List listadeValores) {
    List<TextEditingController> lista = [];
    for (int i = 0; i < cantidad; i++) {
      TextEditingController tx =
          new TextEditingController(text: listadeValores[i].toString());
      lista.add(tx);
    }
    return lista;
  }
}
