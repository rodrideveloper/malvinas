import 'package:Malvinas/main.dart';
import 'package:Malvinas/utilidades/colores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CustomError extends StatelessWidget {
  final FlutterErrorDetails errorDetails;
User user;

   CustomError({ Key key, this.errorDetails, this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
              
              elevation: 0,
              backgroundColor: ColoresApp.color_fondo,
              foregroundColor: Colors.amber,
              onPressed: () {
            
    
    
          // change this seconds with `hours:1`
         
                Navigator.pushNamed(context, '/inicio', arguments: {
           
                
                  'user':user,
                  
                });
              },
              child:
                  Icon(Icons.keyboard_arrow_right, size: 55, color: ColoresApp.color_negro),
            ),
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: ColoresApp.color_negro,
            title: Text('Error')),
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

                                          child: Container(
                                            width: 300,
                                            height: 300,
                                            child:
                                            Image.asset('assets/img/error.jpg')
                                          )
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
                                child: Text('  Volver ' , 
                                
                                style: TextStyle(   decoration: TextDecoration.combine([
                                        TextDecoration.lineThrough,
                                      ]),
                                  fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, 
                                ),),
                          onPressed: () {
              
                               Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  cuerpo()),
  );
                          
                    } ),
                ),
              )
            ],
          )
        )
    );
}} 