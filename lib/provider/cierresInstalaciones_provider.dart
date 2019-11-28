import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';

class CierresInstalacionesProvider {
  final String _url = 'http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest2/api/cierres';
  final _prefs = new PreferenciasUsuario();
  final headerJson = {'content-type': 'application/json'};

  Future<int> sendCierreInstalacion(){
    
  }

}
