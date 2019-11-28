import 'package:elavonappmovil/pages/menu/detalles/cierres.dart';
import 'package:elavonappmovil/pages/menu/detalles/cierresInstalacion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:load/load.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';
import 'package:elavonappmovil/pages/carga_page.dart';
import 'package:elavonappmovil/pages/home_page.dart';
import 'package:elavonappmovil/pages/login.dart';
import 'package:elavonappmovil/pages/menu/detalles/detalleOdt.dart';
import 'package:elavonappmovil/pages/menu/editImage.dart';
import 'package:elavonappmovil/pages/menu/scanner.dart';
import 'package:elavonappmovil/pages/menu/serviciosabierto.menu.dart';
import 'package:elavonappmovil/pages/menu/servicioscerrados_menu.dart';
import 'package:elavonappmovil/pages/menu/serviciosnuevos_menu.dart';
import 'package:elavonappmovil/pages/menu/unidadesinventario.dart';
import 'package:elavonappmovil/pages/menu/detalles/agregarcomentarios.dart';
import 'package:elavonappmovil/pages/menu/detalles/pruebadetalle.dart';

void main() async {
  
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting().then((_) => runApp(MyApp()));

}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    final _prefs = new PreferenciasUsuario();
    print(_prefs.idUsuario);
    return Provider(
      child: LoadingProvider(
        child: MaterialApp(
          title: 'Microformas',
          debugShowCheckedModeBanner: false,
          initialRoute: _prefs.idUsuario != 0 ? 'cargaCatalogos' : 'login',
          routes: {
            'login' : (context) => LoginPage(),
            'home' : (context) => HomePage(),
            'nuevas' : (context) => ServiciosNuevosPage(),
            'abiertas' : (context) => ServiciosAbiertosPage(),
            'cerradas' : (context) => ServiciosCerradosPage(),
            'detalleOdt' : (context) => DetalleOdtPage(),
            'scanner' : (context) => ScannerPage(),
            'cargaCatalogos' : (context) => CargaPage(),
            'unidadesInvenario' : (context) => UnidadesInventarioPage(),
            'editImage' : (context) => EditImage(),
            'agregarComentario' : (context) => AgregarComentario(),
            'pruebaDetalle' : (context) => PruebaDetalle(),
            'cierres' : (context) => Cierres(),
            'cierreInstalacion' : (context) => CierresInstalacion()
          },
          theme: ThemeData(primaryColor: Colors.blueAccent),
        ),
      ),
    );
  }
}

