import 'package:Malvinas/actualizar_stock(1).dart';
import 'package:Malvinas/cargar_ambos.dart';
import 'package:Malvinas/detalleCortador.dart';
import 'package:Malvinas/main_seleccionarTela(2).dart';
import 'package:Malvinas/grafico.dart';
import 'package:Malvinas/main_seleccionarColor(3).dart';
import 'package:Malvinas/actualizar_stock(2).dart';
import 'package:Malvinas/models/registros.dart';
import 'package:Malvinas/pantalla_precios.dart';

import 'package:Malvinas/seguimientoCortadores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'BO/dao.dart';
import 'login_page.dart';
import 'main_seleccionarTalles(4).dart';
import 'models/ambo.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utilidades/colores.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Malvinas());
}

class Malvinas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
 //  initialRoute: '/CargarAmbos',
  initialRoute: '/Login',
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/inicio': (BuildContext context) => new cuerpo(),
        '/grafico': (BuildContext context) => new GraficoEstado(),
        '/TelaStock': (BuildContext context) => new TelaStock(),
        '/ActualizarStock': (BuildContext context) => new ActualizarStock(),
        '/SeleccionarColor': (BuildContext context) => new SeleccionarColor(),
        '/Detalle': (BuildContext context) => new Detalle(),
        '/Cortadores': (BuildContext context) => new SeguimientoCortadores(),
        '/CargarAmbos': (BuildContext context) => new CargarAmbos(),
        '/DetalleCortador': (BuildContext context) => new DetalleCortador(),
        '/PantallaPrecios':(BuildContext context) => new PantallaPrecios(),
        
          '/Login': (BuildContext context) => new LoginPage(),
      },
      theme: ThemeData(fontFamily: 'Raleway', colorScheme: ThemeData().colorScheme.copyWith(primary: ColoresApp.color_rosa)),
      
      /*  theme: ThemeData(
        // Define el Brightness y Colores por defecto
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define la Familia de fuente por defecto
        fontFamily: 'Montserrat',

        // Define el TextTheme por defecto. Usa esto para espicificar el estilo de texto por defecto
        // para cabeceras, títulos, cuerpos de texto, y más.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          subtitle1: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),*/
      home: LoginPage(),
    );
  }
}

class cuerpo extends StatefulWidget {
 

   cuerpo({Key key}) : super(key: key);

  @override
  _cuerpoState createState() => _cuerpoState();
}

class _cuerpoState extends State<cuerpo> {
  final TextEditingController _filtro = TextEditingController();
  String _textoDeBusqueda = "";
  List<Ambo> ambos_nombres = [];
  List<Ambo> lista_ambos = [];
  Icon _iconoBusqueda = const Icon(Icons.search);
  Widget _appBarTitulo = const Text('Buscar...');

  _cuerpoState() {
    _filtro.addListener(() {
      if (_filtro.text.isEmpty) {
        setState(() {
          _textoDeBusqueda = "";
          lista_ambos = ambos_nombres;
        });
      } else {
        setState(() {
          _textoDeBusqueda = _filtro.text;
        });
      }
    });
  }
  /* tempList.add(new Ambo(e.nombre, e.precio, e.talleChaqueta,
          e.tallePantalon, Image.network('assets/img/juanita3p.jpg')));`*/
  @override
  void initState() {
    _getAmbos();
    super.initState();
  }

  void _getAmbos() async {
    List<Ambo> tempList = [];
    QuerySnapshot<Ambo> lista = await DAO.leerAmbosDAO();

    lista.docs.forEach((e) {
      tempList.add(new Ambo.for2(
          e.id,
          e.data().tipo,
          e.data().modelo,
          e.data().tela_principal,
          e.data().color_primario,
          e.data().color_secundario,
          e.data().telas_disponibles,
          e.data().url));
    });

    setState(() {
      ambos_nombres = tempList;
      ambos_nombres.shuffle();
      lista_ambos = ambos_nombres;
    });
  }

  @override
  Widget build(BuildContext context) {
     final argumentos = ModalRoute.of(context).settings.arguments as Map;
      User user;
       
 
         user=argumentos['user'];
   

  
    return Scaffold(
      
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: _buildBar(context),
      ),
      body: Container(
        child: _buildList(context, user),
      ),
      drawer:Drawer(
            elevation: 1.5,
            child: Column(children: <Widget>[
              
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Container(
                color: ColoresApp.color_fondo,
                width: 250,
                height: 250,
                child: Image.asset('assets/img/malvinas.png'),
              ),
            ),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                   ListTile(
              title: const Text('Mis Cortes'),
              leading: Icon(Icons.content_cut, color: ColoresApp.color_rosa),
              onTap: () {
                
                 Navigator.pushNamed(context, '/Cortadores', arguments: {
            'user': user,
            
          });
              },
            ),
           /* ListTile(
              title: const Text('Stock Telas'),
              leading: Icon(Icons.leaderboard, color: ColoresApp.color_rosa,),
              onTap: () {
                Navigator.pushNamed(context, '/grafico');
              },
            ),*/

            ListTile(
              title: Text('Actualizar Stock',
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.combine([
                        TextDecoration.lineThrough,
                      ]))),
              leading: Icon(Icons.upgrade, color: ColoresApp.color_rosa),
              onTap: () {
                //Navigator.pushNamed(context, '/ActualizarStock');
              },
            ),

  ExpansionTile(
    leading: Icon(Icons.leaderboard, color: ColoresApp.color_rosa),
        title:const Text('Stock Telas'),
        children: <Widget>[
          TextButton(onPressed: (){
              Navigator.pushNamed(context, '/grafico', arguments: {
            'tela': 'Batista',
            
          });
          }, child:   Text("Batista")),
          
          
        TextButton(child:   Text("Spandex"),onPressed: (){
              Navigator.pushNamed(context, '/grafico', arguments: {
            'tela': 'Spandex',
            
          });
          } ), TextButton(child:   Text("Arciel"),onPressed: (){
              Navigator.pushNamed(context, '/grafico', arguments: {
            'tela': 'Arciel',
            
          });
          })
          
          
          ],
      ),

               ListTile(
              title: const Text('Lista Precios'),
              leading: Icon(Icons.list,color: ColoresApp.color_rosa),
              onTap: () {
                Navigator.pushNamed(context, '/PantallaPrecios');
              },
            )
                ],
              )),
              Container(
                color: Colors.black,
                width: double.infinity,
                height: 0.1,
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  height: 100, 
                  child: Column(
                    children: [
                      Text("${user.displayName}",style: TextStyle(fontWeight: FontWeight.bold),),
                      TextButton(onPressed: (){
                    cerrarSession();
                      }, 
                      child: Text('Cerrar Sesion'))
                    ],
                  )),
            ])),
 
      
    );
  }

  Future<void> cerrarSession() async => await FirebaseAuth.instance.signOut().then((value) =>  Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false));

  Widget _buildBar(BuildContext context) {
    return AppBar(
      elevation: 20,
      centerTitle: true,
      title: _appBarTitulo,
      backgroundColor: ColoresApp.color_negro,
      /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0))),*/
      actions: [
        IconButton(
          icon: _iconoBusqueda,
          onPressed: _searchPressed,
        )
      ],
    );
  }

  void _searchPressed() {
    setState(() {
      if (_iconoBusqueda.icon == Icons.search) {
        _iconoBusqueda = Icon(Icons.close);
        _appBarTitulo = TextField(
          controller: _filtro,
          decoration: const InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Buscar...',
          ),
          autofocus: true,
          style: TextStyle(color: Colors.white),
        );
      } else {
        this._iconoBusqueda = Icon(Icons.search);
        this._appBarTitulo = Text('Buscar...');
        lista_ambos = ambos_nombres;
        _filtro.clear();
      }
    });
  }

  Widget _buildList(context, User user) {
    final size = MediaQuery.of(context).size;
    if (!(_textoDeBusqueda.isEmpty)) {
      List<Ambo> tempList = [];
      for (int i = 0; i < lista_ambos.length; i++) {
        if (lista_ambos[i]
            .modelo
            .toLowerCase()
            .contains(_textoDeBusqueda.toLowerCase())) {
          tempList.add(lista_ambos[i]);
        }
      }
      lista_ambos = tempList;
    }
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: lista_ambos.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AmboHeroe(ambo: lista_ambos[i], user:user) ));
          },
          child: Card(
            shadowColor: Colors.blue[100],
           
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    height: 120,
                      child: Hero(
                          tag: 'imageHero${lista_ambos[i].modelo}',
                          child: Image.asset(lista_ambos[i].url))), Spacer(),
                  Text(
                    '${lista_ambos[i].modelo}', textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold ),
                  ),
                ],
              ),
            ),
            color: Colors.white,
            elevation: 10.0,
          ),
        );
      },
    );
  }
}
