import 'package:elavonappmovil/bloc/provider.dart';
import 'package:flutter/material.dart';

import '../preferencias_usuario/preferencias_usuario.dart';

class CargaPage extends StatefulWidget {
  @override
  _CargaPageState createState() => _CargaPageState();
}

class _CargaPageState extends State<CargaPage> {

  final prefs = new PreferenciasUsuario();
  int totalCatalogos = 0;
  int numeroCatalogos = 6;

  @override
  Widget build(BuildContext context) {

    cargarCatalogos(context);

    return Container(
      child: totalCatalogos != numeroCatalogos 
            ? Text('Numero de catalogos cargados $totalCatalogos')
            : Container(child: Text('Numero de catalogos cargados $totalCatalogos'),),
    );
  }

  void cargarCatalogos(BuildContext context) async{
    // final serviciosBloc = Provider.serviciosBloc(context);
    // final serviciosList = await serviciosBloc.getServiciosHttp();
    // for(var servicio in serviciosList){
    //   serviciosBloc.insertServicios(servicio);
    // }
    setState(() {
      totalCatalogos++;
    });

    // final modeloBloc = Provider.modelosBloc(context);
    // final modeloList = await modeloBloc.getModelosHttp();
    // for(var modelo in modeloList){
    //   modeloBloc.insertModel(modelo);
    // }
    setState(() {
      totalCatalogos++;
    });

    // final marcaBloc = Provider.marcasBloc(context);
    // final marcasList = await marcaBloc.getMarcasHttp();
    // for(var marca in marcasList){
    //   marcaBloc.insertMarcas(marca);
    // }
    setState(() {
      totalCatalogos++;
    });

    // final conectividadBloc = Provider.conectividadBloc(context);
    // final conectividadList = await conectividadBloc.getConectividadHttp();
    // for(var conectividad in conectividadList){
    //   conectividadBloc.insertConectividad(conectividad);
    // }
    setState(() {
      totalCatalogos++;
    });

    // final softwareBloc = Provider.softwareBloc(context);
    // final softwareList = await softwareBloc.getSoftwareHttp();
    // for(var software in softwareList){
    //   softwareBloc.insertSoftware(software);
    // }
    setState(() {
      totalCatalogos++;
    });
  
    // final unidadBloc = Provider.unidadesBloc(context);
    // final unidadList = await unidadBloc.getUnidadesHttp();
    // for(var unidad in unidadList){
    //   unidadBloc.insertUnidad(unidad);
    // }
    setState(() {
      totalCatalogos++;
    });
  }
}