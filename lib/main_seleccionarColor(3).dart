import 'dart:async';

import 'package:Malvinas/utilidades/colores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'BO/dao.dart';
import 'colores.dart';
import 'models/Tela.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/ambo.dart';
import 'models/precios.dart';

class SeleccionarColor extends StatefulWidget {
  final String tela;

  SeleccionarColor({Key key, this.tela}) : super(key: key);

  @override
  _SeleccionarColorState createState() => _SeleccionarColorState();
}

class _SeleccionarColorState extends State<SeleccionarColor> {
  String valorColorPrimario=' ';
  String valorColorSecundario=' ';
  Precios precios;
  String user;
bool error=false;
  List<Telas> listaTelas = [];
  Map<String, dynamic> mapa = {};

  @override
  void initState() {
    traerPrecios();
    super.initState();
  }

  void traerPrecios() async {
    QuerySnapshot<Precios> queryPrecios = await DAO.listaDePrecios();
    precios = queryPrecios.docs[0].data();
  }

  Future<QuerySnapshot> llenarListaTelas() async {
    final args = ModalRoute.of(context).settings.arguments as Map;

    return await DAO.leerSoloUnaDAO(args['telaSeleccionada']);
  }

  @override
  Widget build(BuildContext context) {
     bool _buttonVisibility = true;
     
    //Recibio  seleccionado, la tela seleccionada y junto a los colores seleccionados en esta pantalla los envío
    //a la pantalla Detalle
    final argumentos = ModalRoute.of(context).settings.arguments as Map;
    String telaSeleccionada = argumentos['telaSeleccionada'];
    Ambo ambo = argumentos['ambo'];
   
    user=argumentos['user'];
     if ( valorColorPrimario==' '){
     valorColorPrimario = ambo.color_primario;
    valorColorSecundario = ambo.color_secundario;
    }
  

    return SafeArea(
      child: Scaffold(
          floatingActionButton:  FloatingActionButton(
              
              elevation: 0,
              backgroundColor: ColoresApp.color_fondo,
              foregroundColor: Colors.amber,
              onPressed: () {
            
    
    
          // change this seconds with `hours:1`
         
                Navigator.pushNamed(context, '/Detalle', arguments: {
                  'telaSeleccionada': telaSeleccionada,
                  'valorColorPrimario': valorColorPrimario,
                  'valorColorSecundario': valorColorSecundario,
                  'ambo': ambo,
                  'precios': precios,
                  'user':user,
                  'error':error
                });
              },
              child:
                  Icon(Icons.keyboard_arrow_right, size: 55, color: ColoresApp.color_negro),
            ),
       
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            title: Text(
              'Seleccionar Colores',
            ),
            backgroundColor: ColoresApp.color_negro,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder<QuerySnapshot>(
                future: llenarListaTelas(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      bool erroNoColor=false;
                      List<DocumentSnapshot> listaDoc = snapshot.data.docs;
                                listaDoc.forEach((element) {
                                  listaTelas.add(
                                      new Telas(element['nombre'], element['Colores']));
                                }
                                
                    
                      );


  /*if (!listaTelas[0].metros_colores.containsKey(valorColorSecundario)){
     error=true;
  
  return Center(
    child: Container( 
      width: 300,
      height: 300,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Text(' ${ambo.color_secundario} no disponible en ${telaSeleccionada}'),
                               Text(' Disponible en ${ambo.telas_disponibles}'),
                             ],
                           ),
                         ),
  );

  }*/
       
              
         
            
               
                      


                      return Container(
                        color: ColoresApp.color_fondo,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            
                            Material(
                              elevation: 10,
                              child: Container(
                                padding: EdgeInsets.all(30),
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: ColoresApp.color_negro),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          color: Colors.amberAccent,
                                          child: Center(
                                            child: Text('1',
                                                style: TextStyle(
                                                    color:
                                                        ColoresApp.color_negro,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat')),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
  
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                style: BorderStyle.solid,
                                                width: 5,
                                                color: Colors.white)),
                                        height: 50,
                                        
                                        child:
                                      
                                               botonColores_primario(listaTelas),
                                                            
                                      ),
                                      SizedBox(height: 10),
                                      ClipOval(
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          color: Colors.amberAccent,
                                          child: Center(
                                            child: Text('2',
                                                style: TextStyle(
                                                    color:
                                                        ColoresApp.color_negro,
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Montserrat')),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                style: BorderStyle.solid,
                                                width: 5,
                                                color: Colors.white)),
                                        height: 50,
                                        child:
                                            botonColores_secundario(listaTelas),
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(height: 25),
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                width: 180,
                                height: 180,
                                child: Center(
                                    child: Image.asset(
                                        'assets/img/malvinas.png'))),
                          ],
                        ),
                      );
                    }
                    return Container();
                  }
                  return Center(child: CircularProgressIndicator());
                }),
          )),
    );
  }

  Widget botonColores_primario(List<Telas> telas) {
    List llaves = telas[0].metros_colores.keys.toList();

    DropdownButton dp;
    /*if (llaves.contains(valorColorPrimario)){

 Navigator.pushNamed(context, '/SeleccionarColor', arguments: {
            'user': user,
            'color':valorColorPrimario
          });
        
       print('primario err1212or');
         
          return null;
    }else{
           print('primario error');
    }*/


                            

    return DropdownButton(
        elevation: 6,
        isExpanded: true,
        dropdownColor: Colors.white,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        underline: SizedBox(),
        iconSize: 30,
        style: TextStyle(
            color: Colors.black, fontFamily: 'Raleway', letterSpacing: 15),
        items: llaves.map((dropDownStringItem) {
          return coloresMenuDrop(dropDownStringItem); 
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this.valorColorPrimario = newValueSelected;
          });
        },
        value: valorColorPrimario);
  }

  DropdownMenuItem<String> coloresMenuDrop(dropDownStringItem) {
DropdownMenuItem dp;

  
  dp= DropdownMenuItem<String>(

          
          value: dropDownStringItem,
          child: Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(minHeight: 90.0),
            color: Colores.colores[dropDownStringItem],
            child: Text(dropDownStringItem,
                style: TextStyle(
                  color: ThemeData.estimateBrightnessForColor(
                              Colores.colores[dropDownStringItem]) ==
                          Brightness.dark
                      ? Colors.white
                      : Colors.black,
                )),
          ),
        );




    return dp;
  }

  Widget botonColores_secundario(List<Telas> telas) {

    List llaves = telas[0].metros_colores.keys.toList();

  /*    if (llaves.contains(valorColorPrimario)){
        print('aaaaaaaaa');
          Navigator.pushNamed(context, '/errorColor', arguments: {
            'user': user,
            'color':valorColorPrimario
          });
        

           
    }else {
      print('aaabbbbbbbbbbbbbbaaaaaa');
    }*/
    return DropdownButton(
        elevation: 6,
        isExpanded: true,
        dropdownColor: Colors.white,
        icon: Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
        ),
        underline: SizedBox(),
        iconSize: 30,
        style: TextStyle(
            color: Colors.black, fontFamily: 'Raleway', letterSpacing: 15),
        items: llaves.map((dropDownStringItem) {
          return DropdownMenuItem<String>(
            value: dropDownStringItem,
            child: Container(
              alignment: Alignment.center,
              constraints: BoxConstraints(minHeight: 90.0),
              color: Colores.colores[dropDownStringItem],
              child: Text(dropDownStringItem,
                  style: TextStyle(
                    color: ThemeData.estimateBrightnessForColor(
                                Colores.colores[dropDownStringItem]) ==
                            Brightness.dark
                        ? Colors.white
                        : Colors.black,
                  )),
            ),
          );
        }).toList(),
        onChanged: (String newValueSelected) {
          setState(() {
            this.valorColorSecundario = newValueSelected;
          });
        },
        value: valorColorSecundario);
  }
}


class flechaAnterior extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        color: ColoresApp.color_gris,
        child: Icon(Icons.keyboard_arrow_left, size: 70, color: Colors.white),
      ),
    );
  }
}
