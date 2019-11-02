import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:elavonappmovil/models/odts_model.dart';
import 'package:elavonappmovil/models/totalodts_model.dart';
import 'package:elavonappmovil/preferencias_usuario/preferencias_usuario.dart';

class OdtProvider{

  final String _url = 'http://sgse.microformas.com.mx/ELAVON_TEST/apimoviltest2/api/odts';
  final String _urlphotos = 'http://sgse.microformas.com.mx/ELAVON_TEST/WebApiFotosTest/api/files/odt';
  final _prefs  = new PreferenciasUsuario();
  final headerJson = {
    'content-type' : 'application/json'
  };

  Future sendPhoto(File imagen, String noar) async {

    final mimeTypeData = lookupMimeType(imagen.path, headerBytes: [0xFF,0xD8]).split('/');
    print(mimeTypeData);
    final imageUploadRequest = http.MultipartRequest('POST', Uri.parse(_urlphotos));
    //final file = await http.MultipartFile.fromPath('imagen', imagen.path, contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    String base64Image = base64Encode(imagen.readAsBytesSync());
/*
    final resp = await http.post(_urlphotos,
    body:{
      "archivos" : base64Image,
      "noar": noar
    });
    print(resp.body);*/
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
    final url = '$_url/getodtstecnico/${_prefs.idUsuario}';
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
    final resp = await http.put(url,
      headers: headerJson,
      body: '{"ID_STATUS_AR_A":$idstatusara,"ID_STATUS_AR_P":$idstatusarp,"ID_USUARIO":$idusuario,"ID_AR":$idar}'
    );

    return int.parse(resp.body);
  }

}