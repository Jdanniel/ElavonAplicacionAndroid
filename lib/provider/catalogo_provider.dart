import 'dart:convert';
import 'package:elavonappmovil/models/negocios_model.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:http/http.dart' as http;
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/models/unidades_model.dart';
import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/marcas_model.dart';
import 'package:elavonappmovil/models/servicios_model.dart';
import 'package:elavonappmovil/models/cmodelos_model.dart';
import '../preferencias_usuario/preferencias_usuario.dart';

class CatalogoProvider{

  final String _url = 'http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest2/api/catalogos';
  final _prefs  = new PreferenciasUsuario();
  final headerJson = {
    'content-type' : 'application/json'
  };

  Future<List<CmodelosModel>> getModelos() async {
    final url = '$_url/modelos';
    final resp = await http.get(url,
      headers: headerJson
    );
    final decodeData = json.decode(resp.body) as List;
    final modelosList = decodeData.map((map) => CmodelosModel.fromJson(map)).toList();
    if(decodeData == null) return[];
    return modelosList;
  }

  Future<List<MarcasModel>> getMarcas() async{
    final url = '$_url/marcas';
    final resp = await http.get(url,
      headers: headerJson
    );
    final decodeData = json.decode(resp.body) as List;
    final marcasList = decodeData.map((map) => MarcasModel.fromJson(map)).toList();
    if(decodeData == null) return[];
    return marcasList;
  }

  Future<List<ServiciosModel>> getServicios() async{
    final url = '$_url/servicios';
    final resp = await http.get(url,
      headers: headerJson
    );
    final decodeData = json.decode(resp.body) as List;
    final servicioList = decodeData.map((map) => ServiciosModel.fromJson(map)).toList();
    if(decodeData == null) return[];
    return servicioList;
  }

  Future<List<ConectividadModel>> getConectividades() async{
    final url = '$_url/conectividades';
    final resp = await http.get(url,
      headers: headerJson
    );
    final decodeData = json.decode(resp.body) as List;
    final conectividadList = decodeData.map((map) => ConectividadModel.fromJson(map)).toList();
    if(decodeData == null) return[];
    return conectividadList;
  }  

  Future<List<Softwaremodel>> getSoftwares() async{
    final url = '$_url/softwares';
    final resp = await http.get(url,
      headers: headerJson
    );
    final decodeData = json.decode(resp.body) as List;
    final softwareList = decodeData.map((map) => Softwaremodel.fromJson(map)).toList();
    if(decodeData == null) return[];
    return softwareList;
  } 

  Future<List<UnidadesModel>> getUnidades() async{
    final url = '$_url/unidades/${_prefs.idUsuario}';
    final resp = await http.get(url,
      headers: headerJson
    );
    final decodeData = json.decode(resp.body) as List;
    final unidadesList = decodeData.map((map) => UnidadesModel.fromJson(map)).toList();
    if(decodeData == null) return[];
    return unidadesList;
  } 
  
  Future<List<Odtmodel>> getOdts() async {
    final url = '$_url/getodtstecnico/${_prefs.idUsuario}';
    final resp = await http.get(url,
      headers: headerJson
    );
    final decodeData = json.decode(resp.body) as List;
    final odtList = decodeData.map((map) => Odtmodel.fromJson(map)).toList(); 
    if(decodeData == null) return [];
    return odtList;
  }
}