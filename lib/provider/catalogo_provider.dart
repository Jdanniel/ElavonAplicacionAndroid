import 'package:dio/dio.dart';
import 'package:elavonappmovil/models/ccausas_model.dart';
import 'package:elavonappmovil/models/movimientoInventarioServicioFalla_model.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:elavonappmovil/models/software_model.dart';
import 'package:elavonappmovil/models/unidades_model.dart';
import 'package:elavonappmovil/models/conectividad_model.dart';
import 'package:elavonappmovil/models/marcas_model.dart';
import 'package:elavonappmovil/models/servicios_model.dart';
import 'package:elavonappmovil/models/cmodelos_model.dart';
import '../preferencias_usuario/preferencias_usuario.dart';

class CatalogoProvider {
  final String _url =
      'http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest2/api/catalogos';
  final _prefs = new PreferenciasUsuario();
  final headerJson = {'content-type': 'application/json'};
  final _contentTypeJson = 'application/json';

  Future<List<CmodelosModel>> getModelos() async {
    final url = '$_url/modelos';
    var dio = Dio();
    final resp =
        await dio.get(url, options: Options(contentType: _contentTypeJson));

    final decodeData = resp.data as List;
    final modelosList =
        decodeData.map((map) => CmodelosModel.fromJson(map)).toList();
    if (decodeData == null) return [];
    return modelosList;
  }

  Future<List<MarcasModel>> getMarcas() async {
    final url = '$_url/marcas';
    var dio = Dio();
    final resp =
        await dio.get(url, options: Options(contentType: _contentTypeJson));
    final decodeData = resp.data as List;
    final marcasList =
        decodeData.map((map) => MarcasModel.fromJson(map)).toList();
    if (decodeData == null) return [];
    return marcasList;
  }

  Future<List<ServiciosModel>> getServicios() async {
    final url = '$_url/servicios';
    var dio = Dio();
    final resp =
        await dio.get(url, options: Options(contentType: _contentTypeJson));
    final decodeData = resp.data as List;
    final servicioList =
        decodeData.map((map) => ServiciosModel.fromJson(map)).toList();
    if (decodeData == null) return [];
    return servicioList;
  }

  Future<List<ConectividadModel>> getConectividades() async {
    final url = '$_url/conectividades';
    var dio = Dio();
    final resp =
        await dio.get(url, options: Options(contentType: _contentTypeJson));
    final decodeData = resp.data as List;
    final conectividadList =
        decodeData.map((map) => ConectividadModel.fromJson(map)).toList();
    if (decodeData == null) return [];
    return conectividadList;
  }

  Future<List<Softwaremodel>> getSoftwares() async {
    final url = '$_url/softwares';
    var dio = Dio();
    final resp =
        await dio.get(url, options: Options(contentType: _contentTypeJson));
    final decodeData = resp.data as List;
    final softwareList =
        decodeData.map((map) => Softwaremodel.fromJson(map)).toList();
    if (decodeData == null) return [];
    return softwareList;
  }

  Future<List<UnidadesModel>> getUnidades() async {
    final url = '$_url/unidades/${_prefs.idUsuario}';
    var dio = Dio();
    final resp =
        await dio.get(url, options: Options(contentType: _contentTypeJson));
    final decodeData = resp.data as List;
    final unidadesList =
        decodeData.map((map) => UnidadesModel.fromJson(map)).toList();
    if (decodeData == null) return [];
    return unidadesList;
  }

  Future<List<Odtmodel>> getOdts() async {
    final url = '$_url/getodtstecnico/${_prefs.idUsuario}';
    var dio = Dio();
    final resp =
        await dio.get(url, options: Options(contentType: _contentTypeJson));
    final decodeData = resp.data as List;
    final odtList = decodeData.map((map) => Odtmodel.fromJson(map)).toList();
    if (decodeData == null) return [];
    return odtList;
  }

  Future<List<MovimientoInventarioSF>> getMovInventarioSF() async {
    final url = '$_url/movinventariosf';
    var dio = Dio();
    final resp =
        await dio.get(url, options: Options(contentType: _contentTypeJson));
    final decodeData = resp.data as List;
    final movsList =
        decodeData.map((map) => MovimientoInventarioSF.fromJson(map)).toList();
    if (decodeData == null) return [];
    return movsList;
  }

  Future<List<CCausasModel>> getCausas() async {
    final url = '$_url/causas';
    var dio = Dio();
    final resp = await dio.get(url, options: Options(contentType: _contentTypeJson));
    final decodeData = resp.data as List;
    final causasList = decodeData.map((map) => CCausasModel.fromJson(map)).toList();
    if(decodeData == null) return [];
    return causasList;
  }
}
