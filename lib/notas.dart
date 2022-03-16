import 'package:Malvinas/utilidades/colores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'BO/dao.dart';
import 'models/registros.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Notas extends StatefulWidget {
   User user;
   Notas({Key key}) : super(key: key);

  @override
  _NotasState createState() => _NotasState();
}

class _NotasState extends State<Notas> {
  final texto= TextEditingController();
  int carolina = 0;
  int gaston = 0;
  var total=0;


@override
  void initState() {
  
    super.initState();
   //  leerRegistros();
  }
  @override
  Widget build(BuildContext context) {
     final args = ModalRoute.of(context).settings.arguments as Map;
     widget.user=args['user'];
   
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          backgroundColor: ColoresApp.color_negro,
          foregroundColor: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.keyboard_arrow_left, size: 55, color: Colors.white),
        ),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColoresApp.color_negro,
            title: Text('Tabla de Cortado ')),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: [
           
                        Expanded(
                          child: Container( 
                          
                                      
                           color: ColoresApp.color_fondo,
                            width: double.infinity,
                            height: 310,
                                               padding: EdgeInsets.all(0),
                                        margin:EdgeInsets.all(0), 
                                              
                            
                            child: Center(

 child:Container(
    padding: EdgeInsets.all(0),
                                        margin:EdgeInsets.all(10), 
                                              
   child: TextField(
        keyboardType: TextInputType.multiline,
   
    textInputAction: TextInputAction.newline,

  minLines: null,
  maxLines: null,  // If this is null, there is no limit to the number of lines, and the text container will start with enough vertical space for one line and automatically grow to accommodate additional lines as they are entered.
  expands: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nota',
                          label: Text('Nota'),
      
                        ),
controller: texto,

   )
   ,
 )










                              
                             /* child: Text('\$ ${total}',style: TextStyle(fontFamily: 'RobotoMono',
                                  fontSize: 80, color: ColoresApp.color_negro, fontWeight: FontWeight.bold
                                ),),*/
                            ),
                                      ),
                        )
              
              ,

Divider(color: Colors.amber, height: 1),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(0),
                  margin:EdgeInsets.all(0), 
                  width: double.infinity,
                  height: 200,
                  color: ColoresApp.color_negro,
                  child: TextButton(
                                child: Text('  Enviar Nota ' , 
                                
                                style: TextStyle(   decoration: TextDecoration.combine([
                                        TextDecoration.lineThrough,
                                      ]),
                                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, 
                                ),),
                          onPressed: () {
                              ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      'Nota Enviada ',
                                      textAlign: TextAlign.center,
                                    )));
              
                     DAO.enviarNota(texto.text, widget.user.displayName);
                       Navigator.pushNamed(context, '/inicio', arguments: {
            'user': widget.user,
            
          });
                          
                    } ),
                ),
              )
            ],
          ),
        ));
  }
}
/*Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                child: FutureBuilder<QuerySnapshot>(
              future: leerRegistros(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    final List<DocumentSnapshot> documentos =
                        snapshot.data.docs;
                    documentos.forEach((e) {
                      Map mapa = e.data();
                      if (mapa['cortador'] != null) {
                        if (mapa['cortador'] == 'Carolina') {
                          carolina++;
                        } else if (mapa['cortador'] == 'Gaston') {
                          gaston++;
                        }
                        ;
                      }
                    });
                    return 
                    
                    Column(
                      children: [
                        Material(
                          elevation: 10,
                          child: Container(
                              width: 250,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/img/tabla.jpg"),
                                fit: BoxFit.cover,
                              )),
                              child: Column(
                                children: [
                                  Text(
                                    'Cortados por Carolina ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 15),
                                  Text('${carolina}',
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: Colors.amber,
                                          fontWeight: FontWeight.bold))
                                ],
                              )),
                        ),
                        SizedBox(height: 50),
                        Material(
                          elevation: 10,
                          child: Container(
                              width: 250,
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                image: AssetImage("assets/img/tabla.jpg"),
                                fit: BoxFit.cover,
                              )),
                              child: Column(
                                children: [
                                  Text(
                                    'Cortados por Gastón ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 15),
                                  ClipOval(
                                    child: Container(
                                      child: Center(
                                        child: Text('${gaston}',
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.amber,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ],
                    );
                  }
                  return Container();
                } else {
                  return Center(
                      child: Container(
                          padding: const EdgeInsets.all(0.0),
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.blueGrey),
                          )));
                }
              },
            ))
          ],
        ),
      ),*/