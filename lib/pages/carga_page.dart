import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/updates_model.dart';

class CargaPage extends StatelessWidget {
  const CargaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  cargarCatalogos(context);

    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text('Actualizado...')
          ],
        ),
      ),
    );
  }

  void cargarCatalogos(BuildContext context) async{
    final dn = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);

    final serviciosBloc = Provider.serviciosBloc(context);
    final serviciosList = await serviciosBloc.getServiciosHttp();   
    for(var servicio in serviciosList){
      serviciosBloc.insertServicios(servicio);
    }
    final modeloBloc = Provider.modelosBloc(context);
    final modeloList = await modeloBloc.getModelosHttp();
    for(var modelo in modeloList){
      modeloBloc.insertModel(modelo);
    }
    final marcaBloc = Provider.marcasBloc(context);
    final marcasList = await marcaBloc.getMarcasHttp();
    for(var marca in marcasList){
      marcaBloc.insertMarcas(marca);
    }      
    final conectividadBloc = Provider.conectividadBloc(context);
    final conectividadList = await conectividadBloc.getConectividadHttp();
    for(var conectividad in conectividadList){
      conectividadBloc.insertConectividad(conectividad);
    }      
    final softwareBloc = Provider.softwareBloc(context);
    final softwareList = await softwareBloc.getSoftwareHttp();
    for(var software in softwareList){
      softwareBloc.insertSoftware(software);
    }
    final unidadBloc = Provider.unidadesBloc(context);
    final unidadList = await unidadBloc.getUnidadesHttp();
    for(var unidad in unidadList){
      unidadBloc.insertUnidad(unidad);
    }      
    final updatesBloc = Provider.updatesBloc(context);
    final up = new UpdatesModel();
    up.fecha = dn;
    updatesBloc.insertUpdates(up);
    updatesBloc.selectUpdate();
    Navigator.pushReplacementNamed(context, 'home');
  }
}
