import 'package:flutter/material.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';

class ServiciosNuevosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final odtbloc = Provider.odtsBloc(context);
    odtbloc.cargarOdts();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NUEVAS',
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: _crearListado(odtbloc, context),
    );
  }

  Widget _crearListado(OdtsBloc bloc, BuildContext _context) {
    double _width = MediaQuery.of(_context).size.width;
    double _height = MediaQuery.of(_context).size.height;
    return StreamBuilder(
      stream: bloc.odtsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Odtmodel>> snapshot) {
        if (snapshot.hasData) {
          final odts = snapshot.data;
          return ListView.builder(
            itemCount: odts.length,
            itemBuilder: (context, index) =>
                _crearItem(context, bloc, odts[index], _width, _height),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, OdtsBloc odtBloc, Odtmodel odts,
      double _width, double _height) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        child: InkWell(
          onTap: () =>
              Navigator.pushNamed(context, 'detalleOdt', arguments: odts),
          child: Card(
              elevation: 8.0,
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                child: _makeListTile(odts),
              )),
        )
    );
  }

  _makeListTile(Odtmodel model){
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        height: 50.0,
        padding: EdgeInsets.only(right: 12.0),
        decoration: BoxDecoration(
          border: Border(
            right: new BorderSide(width: 1.0, color: Colors.black26)
          )
        ),
        child: Icon(Icons.brightness_auto, color: Colors.black,),
      ),
      title: Text("ODT: ${model.odt}", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Negocio: ${model.negocio}"),
          Text("Afiliacion: ${model.noAfiliacion}"),
          Text("Fecha garantía: ${model.fecGarantia}")
        ],
      )
    );
  }

}
