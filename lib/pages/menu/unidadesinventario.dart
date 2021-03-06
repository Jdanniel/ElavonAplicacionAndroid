import 'package:flutter/material.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/unidades_model.dart';

class UnidadesInventarioPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final unidadBloc = Provider.unidadesBloc(context);
    unidadBloc.selectAllUnidades();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 25.0,),
              Container(
                padding: EdgeInsets.only(left: 10.0),
                alignment: Alignment.topLeft,
                child: Row(
                  children: <Widget>[
                    RaisedButton(
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
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text("Unidades", style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),),
                      ),
                    )
                  ],
                )
              ),
              _crearListado(context, unidadBloc),
            ],
          ),
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
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
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

    MarcasBloc marca = new MarcasBloc();
    ModelosBloc modelo = new ModelosBloc();

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
          FutureBuilder(
            future: marca.selectMarca(unidad.idMarca),
            builder: (BuildContext _context, AsyncSnapshot<String> snapshot){
              if(snapshot.hasData){
                String marca = snapshot.data;
                return Text("Marca: $marca");
              }else{
                return Text("");
              }
            },
          ),
          FutureBuilder(
            future: modelo.selectModelo(unidad.idModelo),
            builder: (BuildContext _context, AsyncSnapshot<String> snapshot){
              if(snapshot.hasData){
                String modelo = snapshot.data;
                return Text("Modelo: $modelo");
              }else{
                return Text("");
              }
            },
          ),
        ],
      ),
    );
  }

  Future<String> getMarca(int id)async{
    MarcasBloc bloc = new MarcasBloc();
    String marca = await bloc.selectMarca(id);
    return marca;
  }

  void _regresar(BuildContext context){
    Navigator.pop(context);
  }
}