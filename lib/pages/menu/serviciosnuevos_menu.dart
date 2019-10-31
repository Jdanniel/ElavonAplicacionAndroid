import 'package:flutter/material.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';

class ServiciosNuevosPage extends StatefulWidget {

  @override
  _ServiciosNuevosPageState createState() => _ServiciosNuevosPageState();
}

class _ServiciosNuevosPageState extends State<ServiciosNuevosPage> {

  int years;
  int mesActual;

  @override
  Widget build(BuildContext context) {
    final odtbloc = Provider.odtsBloc(context);
    odtbloc.selectAllOdts(13);

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
      stream: bloc.allodtsStream,
      builder: (BuildContext context, AsyncSnapshot<List<Odtmodel>> snapshot) {
        if (snapshot.hasData) {
          years = 0;
          mesActual = 0;
          final odts = snapshot.data;
          return ListView.builder(
            itemCount: odts.length,
            itemBuilder: (context, index) {
              return ((odts[index].years != years) ? _crearYear(odts[index].years, odts[index].months, context, bloc, odts[index], _width, _height) 
              : (odts[index].months != mesActual) ? _crearMes(odts[index].months, context, bloc, odts[index], _width, _height) 
              :_crearItem(context, bloc, odts[index], _width, _height));
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearYear(int year, int month, BuildContext context, OdtsBloc odtBloc, Odtmodel odts, double _width, double _height){
    years = year;
    mesActual = month;
    return Column(
      children: <Widget>[
        Card(
          color: Colors.blueAccent,
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),              
              width: double.infinity,
              child: Text(year.toString(), style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
        ),
        Card(
          color: Colors.pinkAccent,
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),            
            width: double.infinity,
            child: Text(getNameMonth(month), style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
          ),
        ),
        _crearItem(context, odtBloc, odts, _width, _height)  
        //_crearMes(month, context, odtBloc, odts, _width, _height)
      ],
    );  
  }

  Widget _crearMes(int mes, BuildContext context, OdtsBloc odtBloc, Odtmodel odts, double _width, double _height){
    mesActual = mes;
    return Column(
      children: <Widget>[
        Card(
          color: Colors.pink,
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              width: double.infinity,
              child: Text(getNameMonth(mes),style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold)),
            ),
        ),
        _crearItem(context, odtBloc, odts, _width, _height)  
      ],
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
              child: Column(
                children: <Widget>[
                  _makeListTile(odts)
                ],
              ),
            )
          ),
        )
    );
  }

  _makeListTile(Odtmodel model){

    IconData icono;

    switch(model.idTipoServicio){
      case 1: 
        icono = Icons.arrow_upward;
        break;
      case 2:
        icono = Icons.casino;
        break;
      case 3:
        icono = Icons.camera_roll;
        break;
    }

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
        child: Icon(icono, color: Colors.black,),
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

  String getNameMonth(int id){
    String mes = '';
    switch(id){
      case 1: mes = 'ENERO';
        break;
      case 2: mes = 'FEBRERO';
        break;  
      case 3: mes = 'MARZO';
        break; 
      case 4: mes = 'ABRIL';
        break; 
      case 5: mes = 'MAYO';
        break; 
      case 6: mes = 'JUNIO';
        break; 
      case 7: mes = 'JULIO';
        break; 
      case 8: mes = 'AGOSTO';
        break;                          
      case 9: mes = 'SEPTIEMBRE';
        break;     
      case 10: mes = 'OCTUBRE';
        break;     
      case 11: mes = 'NOVIEMBRE';
        break;
      case 12: mes = 'DICIEMBRE';
        break;              
    }
    return mes;
  }
}
