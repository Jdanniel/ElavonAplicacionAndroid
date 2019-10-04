// To parse this JSON data, do
//
//     final marcasModel = marcasModelFromJson(jsonString);

import 'dart:convert';

List<MarcasModel> marcasModelFromJson(String str) => List<MarcasModel>.from(json.decode(str).map((x) => MarcasModel.fromJson(x)));

String marcasModelToJson(List<MarcasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MarcasModel {
    int idMarca;
    String descMarca;

    MarcasModel({
        this.idMarca,
        this.descMarca,
    });

    factory MarcasModel.fromJson(Map<String, dynamic> json) => MarcasModel(
        idMarca: json["ID_MARCA"],
        descMarca: json["DESC_MARCA"],
    );

    Map<String, dynamic> toJson() => {
        "ID_MARCA": idMarca,
        "DESC_MARCA": descMarca,
    };
}
