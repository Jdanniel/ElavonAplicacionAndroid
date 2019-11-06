import 'package:dio/dio.dart';
import 'package:elavonappmovil/models/negocios_model.dart';
import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';

class NegociosProvider{
  final String _url = 'http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest2/api/negocios';
  final _prefs = new PreferenciasUsuario();

  Future<int> updateCoordenadas(NegociosModel model) async{

    try{
      String url = "$_url/coordenadas";
      var dio = Dio();

      final resp = await dio.put(url, data: {
        "ID_NEGOCIO": model.idNegocio,
        "LATITUD": model.latitud,
        "LONGITUD": model.longitud
      });
      return resp.data;
    } on DioError catch(error){
      print("Actualizacion de coordenadas: $error");
      return 0;
    }

  }

}