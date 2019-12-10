import 'package:elavonappmovil/provider/catalogo_provider.dart';
import 'package:elavonappmovil/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/updates_model.dart';

class CargaPage extends StatelessWidget {
  const CargaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    valActualizarOdts(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Text('Actualizando...') 
              ],
            ),
          ),
        ),
      ),
    );
  }

  void valActualizarOdts(context)async{
    final updateBloc = Provider.updatesBloc(context);
    final update = await updateBloc.selectUpdate();
   
    if(update == null){
      cargarCatalogos(context);
    }else{
      final odtBloc = Provider.odtsBloc(context);
      await odtBloc.getNuevasOdts(update.fecha);
      Navigator.pushReplacementNamed(context, 'home');
    }
  }

  void cargarCatalogos(BuildContext context) async{
        
    CatalogoProvider catalogo = new CatalogoProvider();
    final dn = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
    final updatesBloc = Provider.updatesBloc(context);

    final serviciosBloc = Provider.serviciosBloc(context);
    final serviciosList = await serviciosBloc.getServiciosHttp();   
    for(var servicio in serviciosList){
      await serviciosBloc.insertServicios(servicio);
    }

    final modeloBloc = Provider.modelosBloc(context);
    final modeloList = await modeloBloc.getModelosHttp();
    for(var modelo in modeloList){
      await modeloBloc.insertModel(modelo);
    }

    final marcaBloc = Provider.marcasBloc(context);
    final marcasList = await marcaBloc.getMarcasHttp();
    for(var marca in marcasList){
      await marcaBloc.insertMarcas(marca);
    }     

    final conectividadBloc = Provider.conectividadBloc(context);
    final conectividadList = await conectividadBloc.getConectividadHttp();
    for(var conectividad in conectividadList){
      await conectividadBloc.insertConectividad(conectividad);
    }      

    final softwareBloc = Provider.softwareBloc(context);
    final softwareList = await softwareBloc.getSoftwareHttp();
    for(var software in softwareList){
      await softwareBloc.insertSoftware(software);
    }

    final unidadBloc = Provider.unidadesBloc(context);
    final unidadList = await unidadBloc.getUnidadesHttp();
    for(var unidad in unidadList){
      await unidadBloc.insertUnidad(unidad);
    }    

    final odtBloc = Provider.odtsBloc(context);
    final odtList = await odtBloc.getAllOdtsHttp();
    for(var odt in odtList){
      await odtBloc.insertarOdts(odt);
    }

    final causasBloc = Provider.causasBloc(context);
    final causasList = await causasBloc.getAllCausasHttp();
    for(var causa in causasList){
      await causasBloc.ingresarCausa(causa);
    }

    final movsList = await catalogo.getMovInventarioSF();
    for(var mov in movsList){
      await DBProvider.db.nuevoMovInv(mov);
    }

    final up = new UpdatesModel();
    up.fecha = dn;
    await updatesBloc.insertUpdates(up);

    Navigator.pushReplacementNamed(context, 'home');
  }
}
