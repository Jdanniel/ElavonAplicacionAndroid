import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:elavonappmovil/models/totalodts_model.dart';
import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';

class OdtProvider{

  final String _url = 'http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest2/api/odts';
  final String _url3 = 'http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest3/api/odts';
  final String _urlphotos = 'http://sgse.microformas.com.mx/ELAVON_TEST/WebApiFotosTest/api/files/odt';
  final _prefs  = new PreferenciasUsuario();
  final headerJson = {
    'content-type' : 'application/json'
  };

  final _contentTypeJson = 'application/json';

  Future<List<Odtmodel>> getNuevasOdts(String fechaU) async {
    final url = '$_url/getnuevasodts';
    var dio = Dio();

    try{
      final request = {
        "ID_USUARIO" : _prefs.idUsuario,
        "FEC_UPDATE" : fechaU
      };

      final resp =
          await dio.post(url, data: request, options: Options(contentType: _contentTypeJson));
      final decodeData = resp.data as List;
      final odtsList = decodeData.map((map) => Odtmodel.fromJson(map)).toList();
      if(decodeData == null) return []; 
      return odtsList;
    }on DioError catch(error){
      return [];
    }
  }

  Future<int> updateAgregarRechazarOdt(int idar, int idstatusar) async{
    final url = '$_url/AceptarRechazarOdt';
    var dio = Dio();
    try{
      final request = {
        "ID_AR": idar,
        "ID_STATUS_AR": idstatusar,
        "ID_USUARIO": _prefs.idUsuario
      };

      final resp = await dio.put(url,
      data: request,
      options: Options(contentType: _contentTypeJson));

      if(resp.statusCode == 200){
        return 1;
      }
      return 0;

    }on DioError catch(error){
      if(error.response.statusCode >= 400){
        return 2;
      }
      return 0;
    }
  }

  Future<int> sendPhoto(File imagen, String noar) async {

    int resultado = 0;
    var dio = Dio();
    FormData formData = new FormData.fromMap({
      "archivos" : await MultipartFile.fromFile(imagen.path, filename: path.basename(imagen.path)),
      "noar": noar
    });
    final resp = await dio.post(_urlphotos, data: formData, onSendProgress: (int sent, int total){
      print("$sent $total");
    });
    if(resp.data == 'Carga completada'){
      resultado = 1;
    }
    return resultado;
  }

  Future<TotalodtsModel> getTotales() async {

    final url = '$_url/gettotalodts/${_prefs.idUsuario}';
    final resp = await http.get(url,
      headers: headerJson
    );
    
    final TotalodtsModel odts = new TotalodtsModel();

    if(resp.statusCode == 200 || resp.statusCode == 201){
      var decodeData = json.decode(resp.body);
      odts.nuevas = decodeData["nuevas"];
      return odts;
    }else{
      return odts;
    }
  }

  Future<List<Odtmodel>> getOdts() async {
    final url = '$_url3/getodtstecnico/${_prefs.idUsuario}';
    final resp = await http.get(url,
      headers: headerJson
    );

    final decodeData = json.decode(resp.body) as List;
    final odtList = decodeData.map((map) => Odtmodel.fromJson(map)).toList();
    
    if(decodeData == null) return [];

    return odtList;
  }

  Future<int> updateStatusAr(int idusuario, int idstatusara, int idstatusarp, int idar) async{
    final url = '$_url/UpdateStatusAr';
    var dio = Dio();
    final resp = await dio.put(url, data: {"ID_STATUS_AR_A": idstatusara,"ID_STATUS_AR_P": idstatusarp,"ID_USUARIO": idusuario,"ID_AR": idar});
    return resp.data;
  }

  Future<int> agregarComentario(String comentario, int idAar) async {

    try{
      final url = '$_url/AgregarComentario';
      var dio = Dio();
      final resp = await dio.post(url, data: {
        "ID_AR": idAar,
        "COMENTARIO": comentario,
        "ID_USUARIO": _prefs.idUsuario
      }, options: Options(contentType: 'application/json'));

      return resp.data;
    } on DioError catch(error){
      print("$error");
      return 0;
    }


  }

}