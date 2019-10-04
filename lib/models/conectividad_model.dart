// To parse this JSON data, do
//
//     final conectividadModel = conectividadModelFromJson(jsonString);

import 'dart:convert';

List<ConectividadModel> conectividadModelFromJson(String str) => List<ConectividadModel>.from(json.decode(str).map((x) => ConectividadModel.fromJson(x)));

String conectividadModelToJson(List<ConectividadModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ConectividadModel {
    int idConectividad;
    String descConectividad;

    ConectividadModel({
        this.idConectividad,
        this.descConectividad,
    });

    factory ConectividadModel.fromJson(Map<String, dynamic> json) => ConectividadModel(
        idConectividad: json["ID_CONECTIVIDAD"],
        descConectividad: json["DESC_CONECTIVIDAD"],
    );

    Map<String, dynamic> toJson() => {
        "ID_CONECTIVIDAD": idConectividad,
        "DESC_CONECTIVIDAD": descConectividad,
    };
}
