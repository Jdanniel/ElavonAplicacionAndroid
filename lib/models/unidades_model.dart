// To parse this JSON data, do
//
//     final unidadesModel = unidadesModelFromJson(jsonString);

import 'dart:convert';

List<UnidadesModel> unidadesModelFromJson(String str) => List<UnidadesModel>.from(json.decode(str).map((x) => UnidadesModel.fromJson(x)));

String unidadesModelToJson(List<UnidadesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnidadesModel {
    int idUnidad;
    String noSerie;
    int idMarca;
    int idModelo;
    int idConectividad;
    int idAplicativo;

    UnidadesModel({
        this.idUnidad,
        this.noSerie,
        this.idMarca,
        this.idModelo,
        this.idConectividad,
        this.idAplicativo,
    });

    factory UnidadesModel.fromJson(Map<String, dynamic> json) => UnidadesModel(
        idUnidad: json["ID_UNIDAD"],
        noSerie: json["NO_SERIE"],
        idMarca: json["ID_MARCA"],
        idModelo: json["ID_MODELO"],
        idConectividad: json["ID_CONECTIVIDAD"],
        idAplicativo: json["ID_APLICATIVO"],
    );

    Map<String, dynamic> toJson() => {
        "ID_UNIDAD": idUnidad,
        "NO_SERIE": noSerie,
        "ID_MARCA": idMarca,
        "ID_MODELO": idModelo,
        "ID_CONECTIVIDAD": idConectividad,
        "ID_APLICATIVO": idAplicativo,
    };
}
