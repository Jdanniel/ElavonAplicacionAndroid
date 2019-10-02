import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';

class UsuarioProvider {

  final _prefs = new PreferenciasUsuario();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final authData = {
      'username' : username,
      'password' : password
    };

    final headers = {
      'content-type' : 'application/json'
    };

    final resp = await http.post('http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest/api/cusuarios/loginrequest',
      body: json.encode(authData),
      headers: headers
    );

    Map<String,dynamic> decodeResp = json.decode(resp.body);

    if(resp.statusCode == 200 || resp.statusCode == 201){
      _prefs.idUsuario = decodeResp["idusuario"];
      _prefs.usuarioNombre = decodeResp["user"];
      return {'res': true, 'usuario': decodeResp['user'], 'idusuario': decodeResp['idusuario']};
    }else{
      return {'res': false, 'msg': 'Usuario o contraseña Incorrectas'};
    }
  }

}