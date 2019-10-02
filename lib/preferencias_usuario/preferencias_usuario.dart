import 'package:shared_preferences/shared_preferences.dart';


class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario(){
    return _instancia;
  } 

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get usuarioNombre {
    return _prefs.getString("nombre") ?? '';
  }

  set usuarioNombre(String value){
    _prefs.setString("nombre", value);
  }

  get idUsuario {
    return _prefs.getInt("idUsuario") ?? 0;
  }

  set idUsuario(int value){
    _prefs.setInt("idUsuario", value);
  }

}