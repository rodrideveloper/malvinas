import 'package:Malvinas/BO/dao.dart';
import 'package:Malvinas/models/precios.dart';
import 'package:Malvinas/utilidades/colores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class PantallaPrecios extends StatefulWidget {
  const PantallaPrecios({ Key key }) : super(key: key);

  @override
  State<PantallaPrecios> createState() => _PantallaPreciosState();
}

class _PantallaPreciosState extends State<PantallaPrecios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           backgroundColor: ColoresApp.color_negro,
        title: Text('Precios pagados a Cortador', textAlign: TextAlign.center),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
       floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: ColoresApp.color_negro,
        foregroundColor: ColoresApp.color_negro,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.keyboard_arrow_left, size: 55, color: Colors.white),
      ),

      body: Container(
        color: ColoresApp.color_gris,
        child:  FutureBuilder<QuerySnapshot>(
                            future: DAO.listaDePrecios(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    
                               if (snapshot.connectionState == ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
    
                                     itemBuilder: (BuildContext context, int index) {
                                       Precios p=snapshot.data.docs[0].data();
                                        
                                        return Column(
                                          children: [
                                            Precio(name: 'Precio Chaqueta ',p: p.chaqueta.toString()),
                                              Precio(name: 'Precio Chaqueta Leontina ', p: p.chaquetaLeontina.toString()),     
                                                Precio(name: 'Precio Chaqueta Murphy ',p: p.chaquetaMurphy.toString()),   
                                                  Precio(name: 'Precio Chaqueta Abierta ',p: p.chaqueta_abierta.toString()),   
                                                    Precio(name: 'Precio Chaqueta Pantalón ',p: p.pantalon.toString()),  

                                                     Precio(name: 'Precio Talle Especiales ',p: p.talleEspecial.toString()),   
                                                    
                                           
                                             
    
                                          ],
                                        );
                                        }
                                                   
                                      );
    
                                  }
    
                                  
                                   }
                                   return Container();
                                    }
                                      
     ),
        
      ),
    );
  }
}

class Precio extends StatelessWidget {
  const Precio({
    Key key,
    @required this.p,
    @required this.name
  }) : super(key: key);

  final String p;
  final String name;

  @override
  Widget build(BuildContext context) {

    return Container(
    
     decoration: BoxDecoration(
    border: Border.all(
        style: BorderStyle.solid,
        width: 4,
        color: Colors.white
        )),
    
     
      width: 500,
      height: 70,
    
      child: Card(
        color: ColoresApp.color_negro,
        child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
               Text('  ${name}  ',  style: TextStyle(
        
          color: Colors.white, fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.bold
              ),),
              Text('\$${p}',style:TextStyle( color: Colors.amber, fontSize: 20, fontFamily: 'Raleway', fontWeight: FontWeight.bold) )
          ],
     
        )),
         
         
              
           
            ),
    );
  }
}