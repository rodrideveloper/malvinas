import 'package:Malvinas/grafico.dart';
import 'package:flutter/material.dart';
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
        '/grafico': (BuildContext context) => new Grafico(),
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
  List<Ambo> nombres = [];
  List<Ambo> filtroNombres = [];
  Icon _iconoBusqueda = const Icon(Icons.search);
  Widget _appBarTitulo = const Text('Buscar...');
  int _seleccionado = 1;

  _cuerpoState() {
    _filtro.addListener(() {
      if (_filtro.text.isEmpty) {
        setState(() {
          _textoDeBusqueda = "";
          filtroNombres = nombres;
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
    _getNames();
    super.initState();
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

  void _getNames() async {
    /*  final response = await dio.get('https://swapi.co/api/people');
    List tempList = [];
    print(response.data);
    print(response.data.length);
    for (int i = 0; i < response.data['results'].length; i++) {
      tempList.add(response.data['results'][i]);
    }*/

    List<Ambo> tempList = Ambo.getAmbos();
    setState(() {
      nombres = tempList;
      nombres.shuffle();
      filtroNombres = nombres;
    });
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: _appBarTitulo,
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25.0),
              bottomRight: Radius.circular(25.0))),
      leading: IconButton(
        icon: _iconoBusqueda,
        onPressed: _searchPressed,
      ),
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
        filtroNombres = nombres;
        _filtro.clear();
      }
    });
  }

  Widget _buildList(context) {
    final size = MediaQuery.of(context).size;
    if (!(_textoDeBusqueda.isEmpty)) {
      List<Ambo> tempList = [];
      for (int i = 0; i < filtroNombres.length; i++) {
        if (filtroNombres[i]
            .nombre
            .toLowerCase()
            .contains(_textoDeBusqueda.toLowerCase())) {
          tempList.add(filtroNombres[i]);
        }
      }
      filtroNombres = tempList;
    }
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: filtroNombres.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detalle(ambo: filtroNombres[i])));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(17)),
            child: Column(
              children: [
                Flexible(child: filtroNombres[i].image),
                Text(
                  '${filtroNombres[i].nombre}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('\$${filtroNombres[i].precio}'),
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