import 'package:Malvinas/BO/dao.dart';
import 'package:Malvinas/models/registro_ventas.dart';
import 'package:Malvinas/utilidades/colores.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class DetalleCortador extends StatelessWidget {
  
    User  user;

   DetalleCortador({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final args = ModalRoute.of(context).settings.arguments as Map;
     user=args['user'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Detalle Cortador',
        ),
        backgroundColor: ColoresApp.color_negro,
      ),
      body: Pantalla(user: user),
      floatingActionButtonLocation:FloatingActionButtonLocation.miniStartFloat ,
        floatingActionButton: FloatingActionButton(
        
        elevation: 20,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
           },
        child: Icon(Icons.keyboard_arrow_left, size: 55, color: Colors.white)
      )
     
            
           
    );
  }


}

class Pantalla extends StatefulWidget {
     List<DetalleListAmbos> detalleListaAmbos= [];
     final User user;
   Pantalla({Key key, this.user}) : super(key: key);

  @override
  State<Pantalla> createState() => _PantallaState();
}



Future<List<RegistroVentas>> listaRegistros(String nombre) async {
  
  final listaRegistros = await DAO.listaDeRegistos(nombre);
  final listaAmbos = await DAO.leerAmbosDAO();
  List<RegistroVentas> listaRegistroVentas=[];

  listaRegistros.docs.forEach((lr) {
    if (lr.data().pagado == false ){
    
      
    RegistroVentas RV = new RegistroVentas();
    RV = lr.data();
    RV.id_registro = lr.id;  
    listaAmbos.docs.forEach((la) {
      if (la.id == lr.data().id) {
        RV.image_url = la.data().url;
        RV.ambo = la.data();
      }
    });
    listaRegistroVentas.add(RV);
 } }
 

 );

  listaRegistroVentas.sort((a,b) => a.fecha.toDate().day.compareTo(b.fecha.toDate().day));
  return listaRegistroVentas;
}


class _PantallaState extends State<Pantalla> {
  int total;
   String  _nombreCortador;
GlobalKey<_totalPagarState> textGlobalKey = new GlobalKey<_totalPagarState>();

  @override
  Widget build(BuildContext context) {
    
        _nombreCortador=widget.user.displayName;
    
   
int total=0;

 var fecha;
    
    return Container(
   
      color: ColoresApp.color_fondo,
      child:      
        
      Column(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         mainAxisSize: MainAxisSize.max,
             children: [
 if (widget.user.displayName=='Carlos') ...[
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonHideUnderline (
                      child: DropdownButton(
                        value: _nombreCortador,
                        items:cargarCortadores,           
                              onChanged: (nuevoValor){
                        setState(() {
                          _nombreCortador=nuevoValor;
                          print(_nombreCortador);
                        });
                      
                              }
                      
                      
                      ),
                    )
                  ],
                )
        
          
        ] ,
             Container(
               height: 350,
               child: FutureBuilder<List<RegistroVentas>>(
                            future: listaRegistros(_nombreCortador),
                            builder: (context, AsyncSnapshot<List<RegistroVentas>> snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                if (snapshot.data.length!=0) {
                                  
                                      return 
                                        ListView.builder(
                                          physics: AlwaysScrollableScrollPhysics(),
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (BuildContext context, int index) {
                                         
                                          bool cambio=false;
                                       
                                              if (snapshot.data[index].fecha.toDate().day!=fecha){
                                                  cambio=true;
                                                    fecha=snapshot.data[index].fecha.toDate().day;
                                                 }
                                            DetalleListAmbos detalleLista=DetalleListAmbos(
                                                registro: snapshot.data[index],total:total, textGlobalKey:textGlobalKey,cambio:cambio);
                                              
                                            widget.detalleListaAmbos.add(detalleLista);
                                          
                                            return detalleLista;
                                           
                                          },
                                        );
                                      
                                } return Container(
                                  padding: EdgeInsets.only(top: 50),
                                  child: Center( 
                                    
                                    child: Text('No hay ambos cortados')),
                                );
                              
                              
                              
                              
                              } 
                              return Container(
                                padding: EdgeInsets.only(top: 50),
                                child: Center(
                                child: CircularProgressIndicator()
                                ),
                              );
                              }  ),
             ),
          
                  
         Spacer(),
      
                totalPagar(key: textGlobalKey),
        
    
   

       Container(
         width: double.infinity,
         color: ColoresApp.color_negro,
         child: TextButton(
           style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 25,
                                      fontFamily: 'Raleway',
                                      letterSpacing: 10),
                                  fixedSize: Size(50, 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(25.0))),
                                  backgroundColor: ColoresApp.color_negro,
                                  elevation: 30,
                                  shadowColor: Colors.black),
                  onPressed: (){
                    if (widget.user.displayName=='Carlos'){
  _pagar();
                    }else{
                        Navigator.pushNamed(context, '/inicio', arguments: {
            'user': widget.user,
            
          });
                
                    }
                
                },
            
                 child:  BotonPagaryVolver(widget.user)
                                        
                                        ),
       )
                 ]
      ),
       );
 
  }

  List<DropdownMenuItem<String>> get cargarCortadores {



    List<DropdownMenuItem<String>> lista= 
     [
                DropdownMenuItem(
                  child: Text("Carolina"),
                  value: 'Carolina',
                ),
                DropdownMenuItem(
                  child: Text("Gaston "),
                  value: 'Gaston',
                ),
                  DropdownMenuItem(
                  child: Text("Rodrigo "),
                  value: 'Rodrigo',
                ),
                 DropdownMenuItem(
                  child: Text("Carlos "),
                  value: 'Carlos',
                ),
                
              ];
              return lista;
  }

  Text BotonPagaryVolver(User user) {
   String name_button;

    if (user.displayName=='Carlos'){
      name_button='Pagar';

    }else{
 name_button='Volver';
    }
    return Text("${name_button}",
                                  style: TextStyle(fontSize:20 ,
                                      color: Colors.white,
                                      decoration: TextDecoration.combine([
                                        TextDecoration.lineThrough,
                                      ])));
  }

  void _pagar() async{
    
  int acumulador=0;
 /* widget.detalleListaAmbos.forEach((element) {  
      if (element._isSelected==true){
       acumulador+=element.registro.precio;
      print('Modelo Pagado ${element.registro.ambo.modelo}');
       print('${element.registro.pagado}');
    }else if (element._isSelected==false){
       print('Modelo NOO Pagado ${element.registro.ambo.modelo}');
         print('${element.registro.pagado}');
    } });*/
widget.detalleListaAmbos.forEach((element) {
  print(element.registro.pagado);
 // print( 'Modelo: ${element.registro.ambo.modelo} Registro ${element.registro.pagado}');
});
setState(() {
    
});
 ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            content: Text(
                                      'Ambos Pagados :)',
                                      textAlign: TextAlign.center,
                                    )));
final update= await DAO().updateRegistros( widget.detalleListaAmbos);
 


  }


}

class totalPagar extends StatefulWidget {
     int total=0;
   totalPagar({ Key key }) : super(key: key);
  

  @override
  State<totalPagar> createState() => _totalPagarState();
}

class _totalPagarState extends State<totalPagar> {


void update(RegistroVentas registro){

    
  
setState(() {
      if (registro.pagado==false){
                  registro.pagado=true;
                widget.total=   widget.total+registro.precio;
               

                }else if (   registro.pagado=true){
                registro.pagado=false;
                  widget.total=   widget.total - registro.precio;
                 

                }
    });

}




  @override
  Widget build(BuildContext context) {
    return Row(
      
      mainAxisAlignment: MainAxisAlignment.center,
      
      children: [
        Text('\$', style: TextStyle(
          fontWeight: FontWeight.bold,  fontFamily: 'Raleway', color: Colors.amber,

fontSize: 40

        ),),
          Text('${widget.total}', style: TextStyle(
          fontWeight: FontWeight.bold,  fontFamily: 'Raleway',   letterSpacing: 10,color: Colors.amber,
                                         

fontSize: 60

        ),)
      ],
    );
  }
  }






class DetalleListAmbos extends StatefulWidget {
  final RegistroVentas registro;
  GlobalKey<_totalPagarState> textGlobalKey ; 
  bool _isSelected = false; 
  int total;
  bool cambio;
   


  DetalleListAmbos({
    Key key,
    @required this.registro, 
    @required this.total    ,
    @required this.textGlobalKey,
    @required this.cambio
   
  }) : super(key: key);

  @override
  State<DetalleListAmbos> createState() => _DetalleListAmbosState();
}

class _DetalleListAmbosState extends State<DetalleListAmbos> {
  


  @override
  Widget build(BuildContext context) {
    Widget FilaConData;
   
  
       DateTime fecha= DateTime.parse(widget.registro.fecha.toDate().toString());
     int _nombreCortador=1;
   
   
    FilaConData=Container(
          height: 45,
color: ColoresApp.color_negro,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: CheckboxListTile(
              selectedTileColor: Colors.red,
              tileColor: ColoresApp.color_rosa,
              onChanged: (bool value) {
                setState(() {
         
                  print(widget.total);
                  widget._isSelected = value;
               
                 widget.textGlobalKey.currentState.update(widget.registro);

                });
              
              },
              value: widget._isSelected,
              secondary: ClipOval(
                child: Image.asset(
                  widget.registro.image_url,
                  width: 35,
                  height: 35,
                  fit: BoxFit.cover,
                ),
              ),
              visualDensity: VisualDensity.compact,
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text(
                    widget.registro.ambo.modelo,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              activeColor: Colors.amber,
              checkColor: Colors.black,
            )
    );

if (widget.cambio){
  
}
   Column c=Column(
     children: [
      
          if (widget.cambio) ...[
          
          Container(
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
         
              Text(  'Cortados el :  ${ fecha.day} / ${ fecha.month}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),)
            ],),
          )
          
        ] ,
        FilaConData,
      
             

               
     ],
   );

   


        return  c;
  }
}
