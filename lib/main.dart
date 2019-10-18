
import 'package:elavonappmovil/pages/carga_page.dart';
import 'package:elavonappmovil/pages/home_page.dart';
import 'package:elavonappmovil/pages/login.dart';
import 'package:elavonappmovil/pages/menu/detalles/detalleOdt.dart';
import 'package:elavonappmovil/pages/menu/scanner.dart';
import 'package:elavonappmovil/pages/menu/serviciosabierto.menu.dart';
import 'package:elavonappmovil/pages/menu/servicioscerrados_menu.dart';
import 'package:elavonappmovil/pages/menu/serviciosnuevos_menu.dart';
import 'package:flutter/material.dart';

import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';

void main() async {
  
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Provider(
      child: MaterialApp(
        title: 'Microformas',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'nuevas' : (BuildContext context) => ServiciosNuevosPage(),
          'abiertas' : (BuildContext context) => ServiciosAbiertosPage(),
          'cerradas' : (BuildContext context) => ServiciosCerradosPage(),
          'detalleOdt' : (BuildContext context) => DetalleOdtPage(),
          'scanner' : (BuildContext context) => ScannerPage(),
          'cargaCatalogos' : (BuildContext context) => CargaPage()
        },
        theme: ThemeData(primaryColor: Colors.blueAccent),
      ),
    );
  }
}

