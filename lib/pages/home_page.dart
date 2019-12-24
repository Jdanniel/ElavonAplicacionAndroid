import 'package:date_format/date_format.dart';
import 'package:elavonappmovil/bloc/home_bloc.dart';
import 'package:elavonappmovil/models/updates_model.dart';
import 'package:elavonappmovil/provider/push_notifications_provider.dart';
import 'package:flutter/material.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/totalodts_model.dart';
import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';
import 'package:progress_dialog/progress_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final prefs = new PreferenciasUsuario();

  int nuevas = 0;

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationProvider();

    pushProvider.initNotifiations(prefs.idUsuario);

    pushProvider.mensajes.listen((argumento) {});
  }

  @override
  Widget build(BuildContext context) {
    final totalodtsBloc = Provider.totalOdtsBloc(context);

    totales(totalodtsBloc);

    return Container(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            _fondoApp(),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _titulo(context),
                  //_botonesIniciales(context)
                  //_cardsIniciales(context)
                  _contenedorCards(context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void totales(TotalOdtsBloc bloc) async {
    TotalodtsModel total = await bloc.cargarOdts();
    setState(() {
      nuevas = total.nuevas;
    });
  }

  Widget _contenedorCards(BuildContext _context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _cardRedondeado('Servicios', 'Nuevos', Icons.new_releases, 1),
            _cardRedondeado('Servicios', 'Abiertos', Icons.lock_open, 2),
            _cardRedondeado('Servicios', 'Cerrados', Icons.lock, 3),
            _cardRedondeado('Unidades', 'Inventario', Icons.lock, 4),
            /*_cardRedondeado('Escanear', 'Series', Icons.scanner, 5),
            _cardRedondeado('Editar', 'Imagen', Icons.image, 6),
            _cardRedondeado('Agregar', 'Comentario', Icons.image, 7),*/
          ],
        ),
      ),
    );
  }

  Widget _cardRedondeado(
      String titulo, String subtitulo, IconData icono, int tipo) {
    return GestureDetector(
      onTap: () => _openNuevaVentana(tipo),
      child: Container(
        width: 400.0,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 10.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                contentPadding: EdgeInsets.all(15.0),
                leading: Icon(
                  icono,
                  size: 65.0,
                ),
                title: Text(
                  titulo,
                  style: TextStyle(fontSize: 25.0),
                ),
                subtitle: Text(
                  subtitulo,
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _titulo(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Hola",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Ink(
                  decoration: const ShapeDecoration(
                      color: Colors.greenAccent, shape: CircleBorder()),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      cargarCatalogos(context);
                    },
                  ),
                )
              ],
            ),
            Text(
              prefs.usuarioNombre,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Tienes ',
                  style: TextStyle(color: Colors.white),
                ),
                CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 15.0,
                  child: Text(
                    nuevas.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(' servicios asignados',
                    style: TextStyle(color: Colors.white))
              ],
            )
          ],
        ),
      ),
    );
  }

/*
  Widget _botonesIniciales(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Container(
      height: _height * 0.72,
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(55.0)),
          color: Colors.white),
      child: Table(
        children: [
          TableRow(children: [
            _crearBotonRodeado(
                Colors.black, Icons.new_releases, 'Servicios Nuevos', 1),
          ]),
          TableRow(children: [
            _crearBotonRodeado(
                Colors.black, Icons.lock_open, 'Servicios Abiertos', 2),
          ]),
          TableRow(children: [
            _crearBotonRodeado(
                Colors.black, Icons.lock, 'Servicios Cerrados', 3),
          ]),
        ],
      ),
    );
  }

  Widget _crearBotonRodeado(
      Color color, IconData icon, String texto, int tipo) {
    return GestureDetector(
      onTap: () => _openNuevaVentana(tipo),
      child: Container(
        height: 100.0,
        margin: EdgeInsets.fromLTRB(0, 15.0, 20.0, 15.0),
        decoration: BoxDecoration(
          color: Color.fromRGBO(37, 176, 232, 0.91),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(texto,
                style: TextStyle(
                    color: color, fontSize: 20.0, fontWeight: FontWeight.bold)),
            CircleAvatar(
              backgroundColor: color,
              radius: 35.0,
              child: Icon(
                icon,
                color: Colors.white,
                size: 30.0,
              ),
            )
          ],
        ),
      ),
    );
  }
*/
  _openNuevaVentana(int tipo) {
    switch (tipo) {
      case 1:
        Navigator.pushNamed(context, 'nuevas');
        break;
      case 2:
        Navigator.pushNamed(context, 'abiertas');
        break;
      case 3:
        Navigator.pushNamed(context, 'cerradas');
        break;
      case 4:
        Navigator.pushNamed(context, 'unidadesInvenario');
        break;
      case 5:
        Navigator.pushNamed(context, 'scanner');
        break;
      case 6:
        Navigator.pushNamed(context, 'editImage');
        break;
      case 7:
        Navigator.pushNamed(context, 'agregarComentario');
        break;
      default:
    }
  }

  Widget _fondoApp() {
    final gradiente = Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(54, 146, 255, 1.0),
            Color.fromRGBO(54, 146, 255, 1.0)
          ])),
    );

    return Stack(
      children: <Widget>[gradiente],
    );
  }

  void cargarCatalogos(BuildContext context) async {    
    Navigator.popAndPushNamed(context, 'cargaCatalogos', arguments: 1);
  }

}
