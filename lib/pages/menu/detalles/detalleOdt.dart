import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:elavonappmovil/bloc/odts_bloc.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';

class DetalleOdtPage extends StatefulWidget {
  @override
  _DetalleOdtPageState createState() => _DetalleOdtPageState();
}

class _DetalleOdtPageState extends State<DetalleOdtPage> {
  OdtsBloc odtBloc;
  Odtmodel odt = new Odtmodel();
  double lat = 0;
  double lon = 0;

  @override
  Widget build(BuildContext context) {
    odtBloc = Provider.odtsBloc(context);
    final Odtmodel odtData = ModalRoute.of(context).settings.arguments;
    final double _height = MediaQuery.of(context).size.height;

    if (odtData != null) {
      odt = odtData;
    }

    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    top: 25.0, left: 10.0, right: 10.0, bottom: 5.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: _height * 0.10),
                      _crearCards(_height),
                      Row(
                        children: <Widget>[
                          Expanded( 
                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)
                              ),
                              onPressed: (){_updateStatusAr(odt);},
                              child: Text("Cambio Estatus", textAlign: TextAlign.center,),
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              onPressed: (){},
                              child: Text("Cambio Estatus"),
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              onPressed: (){},
                              child: Text("Cambio Estatus"),
                            ),
                          ),
                        ],
                      ),
                      _crearBotonMaps(odt),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(25.0),
                child: RaisedButton(
                  onPressed: () {
                    _regresar(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.blueAccent,
          items: <Widget>[
            Icon(
              Icons.list,
              size: 30,
            ),
            Icon(
              Icons.location_searching,
              size: 30,
            ),
            Icon(
              Icons.compare_arrows,
              size: 30,
            ),
            Icon(
              Icons.build,
              size: 30,
            ),
            Icon(
              Icons.photo_size_select_actual,
              size: 30,
            ),
          ],
          onTap: (index) {
            _accionesBottom(index);
          },
        ));
  }

  Widget _crearBotonMaps(Odtmodel odt){
    return Container(
      child: RaisedButton(
        onPressed: () => openGoogleMaps(odt),
        child: Icon(
          Icons.map
        ),
      ),
    );
  }

  Widget _crearCards(double _height) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Servicio',
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: _height * 0.05),
            _crearItems(context, 'ODT', odt.odt.trimRight()),
            _crearItems(context, 'Afiliación', odt.noAfiliacion.trimRight()),
            _crearItems(context, 'Negocio', odt.negocio.trimRight()),
            _crearItems(context, 'Dirección', odt.direccion.trimRight() +','+ odt.colonia.trimRight() + ','+ odt.poblacion.trimRight() + ',' + odt.estado.trimRight()),
            //_crearItems(context, 'Direcci�n', odt.direccion.trimRight()),
            _crearItems(context, 'Latitud',
                odt.latitud == null ? lat.toString() : odt.latitud.toString()),
            _crearItems(
                context,
                'Longitud',
                odt.longitud == null
                    ? lon.toString()
                    : odt.longitud.toString()),
            _crearItems(
                context, 'Fecha Garantía', odt.fecGarantia.trimRight()),
          ],
        ),
      ),
    );
  }

  Widget _crearItems(BuildContext context, String titulo, String contenido) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              '$titulo:',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
                  textAlign: TextAlign.start,
            ),
          ),
            Expanded(child: Text(contenido, textAlign: TextAlign.right,)),
        ],
      ),
    );
  }

  void _regresar(BuildContext _context) {
    Navigator.pop(_context);
  }

  void _updateStatusAr(Odtmodel model){

    int idstatusarp = 0;
    switch (model.idStatusAr) {
      case 3:
        idstatusarp = 13;
        break;
      case 4:
        idstatusarp = 5;
        break;
      case 6:
        idstatusarp = 7;
        break;       
      default: 
    }
    odtBloc.updateStatusAr(model.idAr, model.idStatusAr, idstatusarp, model.idAr);
  }

  void _accionesBottom(int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        _coordenadas();
        break;
    }
  }

  void _coordenadas() {
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.best);
    StreamSubscription<Position> positionStream = geolocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      print(position == null
          ? 'Unknow'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
      setState(() {
        lat = position.latitude;
        lon = position.longitude;
      });
    });
    //positionStream.cancel();
  }

  void openGoogleMaps(Odtmodel odt){
    launch("https://www.google.com.mx/maps/search/?api=1&query=${odt.direccion},${odt.estado}");
  }

}
