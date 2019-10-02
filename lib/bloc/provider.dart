import 'package:flutter/material.dart';

import 'login_bloc.dart';
export 'login_bloc.dart';

import 'totalodts_bloc.dart';
export 'totalodts_bloc.dart';

import 'odts_bloc.dart';
export 'odts_bloc.dart';

class Provider extends InheritedWidget{
  
  final _loginBloc = new LoginBloc();

  final _totalodtsBloc = new TotalOdtsBloc();

  final _odtsBloc = new OdtsBloc();

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
}