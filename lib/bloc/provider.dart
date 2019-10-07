import 'package:elavonappmovil/bloc/updates_bloc.dart';
import 'package:flutter/material.dart';

import 'login_bloc.dart';
export 'login_bloc.dart';

import 'totalodts_bloc.dart';
export 'totalodts_bloc.dart';

import 'odts_bloc.dart';
export 'odts_bloc.dart';

import 'package:elavonappmovil/bloc/conectividad_bloc.dart';
export 'package:elavonappmovil/bloc/conectividad_bloc.dart';

import 'package:elavonappmovil/bloc/marcas_bloc.dart';
export 'package:elavonappmovil/bloc/marcas_bloc.dart';

import 'package:elavonappmovil/bloc/modelos.bloc.dart';
export 'package:elavonappmovil/bloc/modelos.bloc.dart';

import 'package:elavonappmovil/bloc/servicios_bloc.dart';
export 'package:elavonappmovil/bloc/servicios_bloc.dart';

import 'package:elavonappmovil/bloc/software_bloc.dart';
export 'package:elavonappmovil/bloc/software_bloc.dart';

import 'package:elavonappmovil/bloc/unidades_bloc.dart';
export 'package:elavonappmovil/bloc/unidades_bloc.dart';

class Provider extends InheritedWidget{
  
  final _loginBloc = new LoginBloc();

  final _totalodtsBloc = new TotalOdtsBloc();

  final _odtsBloc = new OdtsBloc();

  final _serviciosBloc = new ServiciosBloc();

  final _modelosBloc = new ModelosBloc();

  final _marcasBloc = new MarcasBloc();

  final _conectividadBloc = new ConectividadBloc();

  final _softwareBloc = new SoftwareBloc();

  final _unidadesBloc = new UnidadesBloc();

  final _updatesBloc = new UpdatesBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}){
    if(_instancia == null){
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }

  Provider._internal({Key key, Widget child})
  : super(key:key, child:child);
  
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._loginBloc;
  }

  static TotalOdtsBloc totalOdtsBloc(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._totalodtsBloc;
  }

  static OdtsBloc odtsBloc(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._odtsBloc;
  }

  static ServiciosBloc serviciosBloc(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._serviciosBloc;
  }

  static ModelosBloc modelosBloc(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._modelosBloc;
  }

  static MarcasBloc marcasBloc(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._marcasBloc;
  }

  static ConectividadBloc conectividadBloc(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._conectividadBloc;
  }

  static SoftwareBloc softwareBloc(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._softwareBloc;
  }

  static UnidadesBloc unidadesBloc(BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._unidadesBloc;
  }

  static UpdatesBloc updatesBloc(BuildContext context){
    return(context.inheritFromWidgetOfExactType(Provider) as Provider)._updatesBloc;
  }

}