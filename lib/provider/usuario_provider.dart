import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';

import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';
import 'package:path/path.dart';

class UsuarioProvider {
  final _prefs = new PreferenciasUsuario();
  final _url =
      'http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest/api/cusuarios/';

  Future<Map<String, dynamic>> login(String username, String password) async {
    // final authData = {'username': username, 'password': password};

    // final headers = {'content-type': 'application/json'};

    // final resp = await http.post(
    //     'http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest/api/cusuarios/loginrequest',
    //     body: json.encode(authData),
    //     headers: headers);

    // Map<String, dynamic> decodeResp = json.decode(resp.body);

    // if (resp.statusCode == 200 || resp.statusCode == 201) {
    //   _prefs.idUsuario = decodeResp["idusuario"];
    //   _prefs.usuarioNombre = decodeResp["user"];
    //   _prefs.fechaI = formatDate(
    //       DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
    //   return {
    //     'res': true,
    //     'usuario': decodeResp['user'],
    //     'idusuario': decodeResp['idusuario']
    //   };
    // } else {
    //   return {'res': false, 'msg': 'Usuario o contraseña Incorrectas'};
    // }
    try{
      var dio = Dio();
      var url = _url + 'loginrequest';
      print(url);
      final resp = await dio.post(url,
          data: {'username': username, 'password': password});

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        Map<String, dynamic> decodeResp = resp.data;
        _prefs.idUsuario = decodeResp["idusuario"];
        _prefs.usuarioNombre = decodeResp["user"];
        _prefs.fechaI = formatDate(
            DateTime.now(), [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
        return {
          'res': true,
          'usuario': decodeResp['user'],
          'idusuario': decodeResp['idusuario']
        };
      } else {
        return {'res': false, 'msg': 'Usuario o contraseña Incorrectas'};
      }
    } on DioError catch(error){
      print("$error, $url");
      return {'res': false, 'msg': 'Usuario o contraseña Incorrectas'};
    }

  }
}
