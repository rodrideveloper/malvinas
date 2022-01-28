import 'package:flutter/material.dart';

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
    final TelaStock args = ModalRoute.of(context).settings.arguments;
    return Container(Text(args.tela));
  }
}
