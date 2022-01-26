import 'package:Malvinas/grafico.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'BO/dao.dart';
import 'detalle.dart';
import 'models/ambo.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

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
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/inicio': (BuildContext context) => new cuerpo(),
        '/grafico': (BuildContext context) => new GraficoEstado(),
      },
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
  int _seleccionado = 1;

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

  @override
  void initState() {
    _getAmbos();
    super.initState();
  }

  void _getAmbos() async {
    List lista = await DAO.leerAmbosDAO();

    List<dynamic> tempList = lista;
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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text('Malvinas Uniformes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            ),
            ListTile(
              title: const Text('Cortador '),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Stock Telas'),
              onTap: () {
                Navigator.pushNamed(context, '/grafico');
              },
            ),
            ListTile(
              title: const Text('Actualizar Stock'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            )
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _seleccionado,
        onTap: (value) {
          setState(() {
            _seleccionado = value;
            if (value == 0) {
              Navigator.pushNamed(context, '/grafico');
            }
            if (value == 1) {
              Navigator.pushNamed(context, '/inicio');
            }
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.bar_chart), label: 'Ver Telas'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.medical_services), label: 'Ambos'),
          BottomNavigationBarItem(
              icon: new Icon(Icons.person), label: 'Cortadores')
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitulo,
      backgroundColor: Colors.blueGrey,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0))),
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
              prefixIcon: Icon(Icons.search), hintText: 'Buscar...'),
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
            .nombre
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
                    builder: (context) => Detalle(ambo: lista_ambos[i])));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            child: Column(
              children: [
                Flexible(child: lista_ambos[i].image),
                Text(
                  '${lista_ambos[i].nombre}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('\$${lista_ambos[i].precio}'),
              ],
            ),
            color: Colors.white,
            elevation: 10.0,
          ),
        );
      },
    );

    /*ListView.builder(
      itemCount: names == null ? 0 : filteredNames.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(filteredNames[index].nombre),
          /* onTap: () => print(filteredNames[index]['name']),*/
        );
      },
    );*/
  }
}


















/*
class cuerpo extends StatelessWidget {
  List items = Ambo.getAmbos();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('Buscar'),
        ),
        body: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(
                  top: size.height * 0.17,
                ),
                child: SafeArea(
                    child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int i) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Detalle(ambo: items[i])));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(17)),
                        child: Column(
                          children: [
                            Flexible(
                                child: Image.asset('assets/img/juanita3p.jpg',
                                    height: size.height * .19)),
                            Text(
                              '${items[i].nombre}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text('\$${items[i].precio}'),
                          ],
                        ),
                        color: Colors.white,
                        elevation: 10.0,
                      ),
                    );
                  },
                )))
          ],
        ));
  }
}
*/