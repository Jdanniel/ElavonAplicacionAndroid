// To parse this JSON data, do
//
//     final serviciosModel = serviciosModelFromJson(jsonString);

import 'dart:convert';

List<ServiciosModel> serviciosModelFromJson(String str) => List<ServiciosModel>.from(json.decode(str).map((x) => ServiciosModel.fromJson(x)));

String serviciosModelToJson(List<ServiciosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiciosModel {
    int idServicio;
    String descServicio;

    ServiciosModel({
        this.idServicio,
        this.descServicio,
    });

    factory ServiciosModel.fromJson(Map<String, dynamic> json) => ServiciosModel(
        idServicio: json["ID_SERVICIO"],
        descServicio: json["DESC_SERVICIO"],
    );

    Map<String, dynamic> toJson() => {
        "ID_SERVICIO": idServicio,
        "DESC_SERVICIO": descServicio,
    };
}
