// To parse this JSON data, do
//
//     final cCausasModel = cCausasModelFromJson(jsonString);

import 'dart:convert';

CCausasModel cCausasModelFromJson(String str) => CCausasModel.fromJson(json.decode(str));

String cCausasModelToJson(CCausasModel data) => json.encode(data.toJson());

class CCausasModel {
    int idCausa;
    String descCausa;
    String descripcion;

    CCausasModel({
        this.idCausa,
        this.descCausa,
        this.descripcion,
    });

    factory CCausasModel.fromJson(Map<String, dynamic> json) => CCausasModel(
        idCausa: json["ID_CAUSA"],
        descCausa: json["DESC_CAUSA"],
        descripcion: json["DESCRIPCION"],
    );

    Map<String, dynamic> toJson() => {
        "ID_CAUSA": idCausa,
        "DESC_CAUSA": descCausa,
        "DESCRIPCION": descripcion,
    };
}
