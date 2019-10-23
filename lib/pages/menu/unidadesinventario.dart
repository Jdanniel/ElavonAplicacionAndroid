import 'package:flutter/material.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/unidades_model.dart';

class UnidadesInventarioPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final unidadBloc = Provider.unidadesBloc(context);
    unidadBloc.selectAllUnidades();

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Stack(
          children: <Widget>[

            _crearListado(context, unidadBloc),

            Container(
              child: RaisedButton(
                onPressed: (){
                  _regresar(context);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 30.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _crearListado(BuildContext _context, UnidadesBloc bloc){
    return StreamBuilder(
      stream: bloc.allUnidadesStream,
      builder: (BuildContext context, AsyncSnapshot<List<UnidadesModel>> snapshot){
        if(snapshot.hasData){
          final unidades = snapshot.data;
          return ListView.builder(
            itemCount: unidades.length,
            itemBuilder: (context,index){
              return _crearItems(context,unidades[index]);
            },
          );
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearItems(BuildContext context, UnidadesModel unidad){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      child: InkWell(
        onTap: (){},
        child: Card(
          elevation: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            child: Column(
              children: <Widget>[
                _makeListTile(context, unidad)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _makeListTile(BuildContext context, UnidadesModel unidad){
    
    final marcabloc = Provider.marcasBloc(context);
    final textMarca = marcabloc.selectMarca(unidad.idUnidad);

    final modelobloc = Provider.modelosBloc(context);
    final textModelo = modelobloc.selectModelo(unidad.idUnidad);

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
        child: Icon(Icons.arrow_back_ios, color: Colors.black,),
      ),
      title: Text("Serie: ${unidad.noSerie}"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Marca: $textMarca"),
          Text("Modelo: $textModelo")
        ],
      ),
    );
  }

  void _regresar(BuildContext context){
    Navigator.pop(context);
  }
}