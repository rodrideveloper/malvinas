import 'package:Malvinas/actualizar_stock(1).dart';
import 'package:Malvinas/cargar_ambos.dart';
import 'package:Malvinas/main_seleccionarTela(2).dart';
import 'package:Malvinas/grafico.dart';
import 'package:Malvinas/main_seleccionarColor(3).dart';
import 'package:Malvinas/actualizar_stock(2).dart';
import 'package:Malvinas/seguimientoCortadores.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'BO/dao.dart';
import 'main_seleccionarTalles(4).dart';
import 'models/ambo.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utilidades/colores.dart';

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
      // initialRoute: '/CargarAmbos',
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
      },
      theme: ThemeData(fontFamily: 'Raleway'),
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
      home: cuerpo(),
    );
  }
}

class cuerpo extends StatefulWidget {
  const cuerpo({Key key}) : super(key: key);

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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: _buildBar(context),
      ),
      body: Container(
        child: _buildList(context),
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
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
            //  Text('Malvinas Uniformes',

            //    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat')),

            ListTile(
              title: const Text('Mis Cortes'),
              leading: Icon(Icons.content_cut),
              onTap: () {
                Navigator.pushNamed(context, '/Cortadores');
              },
            ),
            ListTile(
              title: const Text('Stock Telas'),
              leading: Icon(Icons.leaderboard),
              onTap: () {
                Navigator.pushNamed(context, '/grafico');
              },
            ),

            ListTile(
              title: Text('Actualizar Stock',
                  style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.combine([
                        TextDecoration.lineThrough,
                      ]))),
              leading: Icon(Icons.upgrade),
              onTap: () {
                //Navigator.pushNamed(context, '/ActualizarStock');
              },
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

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

  Widget _buildList(context) {
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
                    builder: (context) => AmboHeroe(ambo: lista_ambos[i])));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            child: Column(
              children: [
                Flexible(
                    child: Hero(
                        tag: 'imageHero${lista_ambos[i].modelo}',
                        child: Image.asset(lista_ambos[i].url))),
                Text(
                  '${lista_ambos[i].modelo}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            color: Colors.white,
            elevation: 10.0,
          ),
        );
      },
    );
  }
}
