import 'package:Malvinas/utilidades/colores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'BO/dao.dart';
import 'models/registros.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SeguimientoCortadores extends StatefulWidget {
   User user;
   SeguimientoCortadores({Key key}) : super(key: key);

  @override
  _SeguimientoCortadoresState createState() => _SeguimientoCortadoresState();
}

class _SeguimientoCortadoresState extends State<SeguimientoCortadores> {
  int carolina = 0;
  int gaston = 0;
  var total=0;

  leerRegistros(User u) async {
final listaRegistros = await DAO.listaDeRegistos(u.displayName);
var suma=0;
listaRegistros.docs.forEach((element) {
  if (!element.data().pagado){
   
    suma+=element.data().precio; 
    
  
  
    }
  setState(() {
  total=suma;
});

});



    
  }
@override
  void initState() {
  
    super.initState();
   //  leerRegistros();
  }
  @override
  Widget build(BuildContext context) {
     final args = ModalRoute.of(context).settings.arguments as Map;
     widget.user=args['user'];
       leerRegistros( widget.user);
    //List<Registro> registros =

    //print(registros);
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

 child:SizedBox(
  width: double.infinity,
  child: TextLiquidFill( 
    text: '\$ ${total}',
    waveColor: Colors.amber,
    boxBackgroundColor: ColoresApp.color_fondo,
    textStyle: TextStyle(
      fontFamily:'RobotoMono' ,
      fontSize: 120.0,
      fontWeight: FontWeight.bold,
    ),
    boxHeight: 300.0,
  ),
),










                              
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
                                child: Text('  Ver Detalle ' , 
                                
                                style: TextStyle(   decoration: TextDecoration.combine([
                                        TextDecoration.lineThrough,
                                      ]),
                                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, 
                                ),),
                          onPressed: () {
              
                                 Navigator.pushNamed(context, '/DetalleCortador', arguments: {
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