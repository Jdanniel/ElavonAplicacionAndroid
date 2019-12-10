import 'package:elavonappmovil/bloc/detalleinit_bloc.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/negocios_model.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:elavonappmovil/provider/negocios_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:load/load.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalleInit extends StatefulWidget {
  @override
  _DetalleInitState createState() => _DetalleInitState();
}

class _DetalleInitState extends State<DetalleInit> {
  //StreamSubscription<Position> positionStream;
  Position position;

  OdtsBloc odtBloc;
  DetalleInitBloc detalleBloc = new DetalleInitBloc();

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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              _botonRegresar(context),
              SizedBox(
                height: 10.0,
              ),
              _crearCards(_height)
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: UniqueKey(),
            backgroundColor: Colors.lightBlueAccent,
            label: Icon(Icons.location_on),
            onPressed: () => _coordenadas(),
          ),
          SizedBox(width: 5.0),
          FloatingActionButton.extended(
            heroTag: UniqueKey(),
            backgroundColor: Colors.lightBlueAccent,
            label: Icon(Icons.update),
            onPressed: () => _updateStatusAr(odt),
          ),
          SizedBox(
            width: 5.0,
          ),
          FloatingActionButton.extended(
            heroTag: UniqueKey(),
            backgroundColor: Colors.lightBlueAccent,
            label: Icon(Icons.map),
            onPressed: () => _openGoogleMaps(odt),
          ),
          SizedBox(width: 5.0),
          FloatingActionButton.extended(
            //heroTag: UniqueKey(),
            backgroundColor: Colors.lightBlueAccent,
            label: Icon(Icons.check),
            onPressed: () => _openCierres(odt),
          )
        ],
      ),
    );
  }

  Widget _botonRegresar(BuildContext _context) {
    return Container(
        padding: EdgeInsets.only(left: 10.0, top: 25.0),
        alignment: Alignment.topLeft,
        child: Row(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _regresar(_context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Icon(
                Icons.arrow_back,
                size: 30.0,
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ));
  }

  Widget _crearCards(double _height) {
    return Card(
      margin: EdgeInsets.only(left: 10.0, right: 10.0),
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
            _crearTabla(context, odt),
            /*
            _crearItems(context, 'ODT', odt.odt.trimRight()),
            _crearItems(context, 'Afiliación', odt.noAfiliacion.trimRight()),
            _crearItems(context, 'Negocio', odt.negocio.trimRight()),
            _crearItems(
                context,
                'Dirección',
                odt.direccion.trimRight() +
                    ',' +
                    odt.colonia.trimRight() +
                    ',' +
                    odt.poblacion.trimRight() +
                    ',' +
                    odt.estado.trimRight()),
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
                context, 'Fecha Garantía', odt.fecGarantia.trimRight()),*/
          ],
        ),
      ),
    );
  }

  Widget _crearTabla(BuildContext context, Odtmodel odt) {
    return Table(
        columnWidths: {1: FlexColumnWidth(2.5)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          _crearTableRow('ODT:', odt.odt.trimRight()),
          _crearTableRow('Afiliación: ', odt.noAfiliacion.trimRight()),
          _crearTableRow('Negocio:', odt.negocio.trimRight()),
          _crearTableRow(
              'Dirección:',
              odt.direccion.trimRight() +
                  ',' +
                  odt.colonia.trimRight() +
                  ',' +
                  odt.poblacion.trimRight() +
                  ',' +
                  odt.estado.trimRight()),
          _crearTableRow('Latitud:', odt.latitud == null ? lat.toString() : odt.latitud.toString()),
          _crearTableRow('Longitud:', odt.longitud == null ? lon.toString() : odt.longitud.toString()),
          _crearTableRow('Fecha Garantía:', odt.fecGarantia.trimRight())
        ]);
  }

  TableRow _crearTableRow(String titulo, String contenido) {
    return TableRow(children: [
      Text(
        titulo,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
        textAlign: TextAlign.right,
      ),
      Container(child: Text(contenido), padding: EdgeInsets.only(left: 5.0),)
    ]);
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
          Expanded(
              child: Text(
            contenido,
            textAlign: TextAlign.right,
          )),
        ],
      ),
    );
  }

  void _openGoogleMaps(Odtmodel odt) {
    launch(
        "https://www.google.com.mx/maps/search/?api=1&query=${odt.direccion},${odt.estado}");
  }

  void _openCierres(Odtmodel odt) async {
    final model =
        await detalleBloc.getMovInventariosf(odt.idServicio, odt.idFalla);
    switch (model.idMovInventario) {
      case 1:
        Navigator.pushNamed(context, 'cierreInstalacion', arguments: odt);
        break;
      case 2:
        Navigator.pushNamed(context, 'cierreRetiro', arguments: odt);
        break;
      case 3:
        Navigator.pushNamed(context, 'cierreSustitucion', arguments: odt);
    }
  }

  void _regresar(BuildContext _context) {
    Navigator.pop(_context);
  }

  void _updateStatusAr(Odtmodel model) async {
    int idstatusarp = 0;
    String msg = "";
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
    showCustomLoadingWidget(Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 1.0,
        ),
        Text("Actualizando...")
      ],
    )));
    int isupdate = await odtBloc.updateStatusAr(
        model.idAr, model.idStatusAr, idstatusarp, model.idAr);
    // isupdate == 1
    //     ? mostrarAlertDatosActualizado(
    //         context, 'El estatus de la Odt se ha actualizado')
    //     : mostrarAlertDatosActualizado(
    //         context, 'No se logro actualizar la Odt');
    hideLoadingDialog();

    if (isupdate == 1) {
      msg = 'Odt Actulizada';
    } else {
      msg = 'La Odt no se ha actualizado';
    }
    final snackbar = SnackBar(
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void _coordenadas() async {
    showCustomLoadingWidget(Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        SizedBox(
          height: 1.0,
        ),
        Text("Actualizando...")
      ],
    )));

    final Geolocator geolocator = Geolocator()
      ..forceAndroidLocationManager = true;
    //var locationOptions = LocationOptions(accuracy: LocationAccuracy.best);
    /*positionStream = geolocator
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
    });*/
    position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    //print(position.latitude.toString()+" "+position.longitude.toString());
    setState(() {
      lat = position.latitude;
      lon = position.longitude;
    });
    NegociosProvider negocio = new NegociosProvider();
    NegociosModel model = new NegociosModel();
    model.idNegocio = odt.idNegocio;
    model.latitud = position.latitude;
    model.longitud = position.longitude;
    int r = await negocio.updateCoordenadas(model);
    String msg = "";
    r == 1
        ? msg = 'Coordenadas Actualizadas'
        : msg = 'Favor de intentarlo despues';
    final snackbar = SnackBar(
      content: Text(msg),
    );
    Scaffold.of(context).showSnackBar(snackbar);
    hideLoadingDialog();
    //positionStream.cancel();
  }

  @override
  void dispose() {
    //position?.cancel();
    super.dispose();
  }
}
