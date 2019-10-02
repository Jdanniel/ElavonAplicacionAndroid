import 'package:flutter/material.dart';
import 'package:elavonappmovil/bloc/odts_bloc.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';

class DetalleOdtPage extends StatefulWidget {
  @override
  _DetalleOdtPageState createState() => _DetalleOdtPageState();
}

class _DetalleOdtPageState extends State<DetalleOdtPage> {

  final scaffolKey = GlobalKey<ScaffoldState>();

  OdtsBloc odtBloc;
  Odtmodel odt = new Odtmodel();

  @override
  Widget build(BuildContext context) {

    odtBloc = Provider.odtsBloc(context);
    final Odtmodel odtData = ModalRoute.of(context).settings.arguments;
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;

    if(odtData != null){
      odt = odtData;
    }

    return Scaffold(
      key: scaffolKey,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
          return <Widget>[
            SliverAppBar(
              expandedHeight: _height * 0.35,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("Servicio", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                background: Image.asset('assets/images/backDetalle.jpg', fit: BoxFit.cover,),
              ),
            )
          ];
        },
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 25.0),
            child: Column(
              children: <Widget>[
                _crearItems(context, 'ODT', odt.odt.trimRight()),
                _crearItems(context, 'Afiliación', odt.noAfiliacion.trimRight()),
                _crearItems(context, 'Negocio', odt.negocio.trimRight()),
                _crearItems(context, 'Estado', odt.estado.trimRight()),
                _crearItems(context, 'Colonia', odt.colonia.trimRight()),
                _crearItems(context, 'Fecha Garantía', odt.fecGarantia.trimRight())
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _crearItems(BuildContext context, String titulo, String contenido){

    final _height = MediaQuery.of(context).size.height;
    final _width =  MediaQuery.of(context).size.width;

    return Flexible(
      child: Padding(
        padding: EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: <Widget>[
            Container(
              height: _height * 0.10,
              width: _width * 0.35,
              color: Colors.blueAccent,
              child: Center(child:Text('$titulo:' , style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),),)
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              color: Color.fromRGBO(42, 190, 255, 1.0),
              height: _height * 0.10,
              width: _width * 0.65,
              child: Center(child: Text(contenido)),
            )
          ],
        ),
      ),
    );
  }

}