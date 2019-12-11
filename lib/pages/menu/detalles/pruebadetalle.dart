import 'package:elavonappmovil/bloc/odts_bloc.dart';
import 'package:elavonappmovil/bloc/provider.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:flutter/material.dart';

class PruebaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OdtsBloc bloc = Provider.odtsBloc(context);
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: StreamBuilder(
        stream: bloc.odtnuevoStream,
        builder: (BuildContext context, AsyncSnapshot<Odtmodel> snapshot) {
          if (snapshot.hasData) {
            final model = snapshot.data;
            return SafeArea(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text("ODT: ${model.odt}"),
                    RaisedButton.icon(
                      icon: Icon(Icons.add_circle_outline),
                      label: Text("Cambiar Odt"),
                      onPressed: () {
                        //bloc.updateOdt(model.idAr, 'NuevaPrueba');
                      },
                    )
                  ],
                ),
              ),
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }
}
