// To parse this JSON data, do
//
//     final negociosModel = negociosModelFromJson(jsonString);

import 'dart:convert';

List<NegociosModel> negociosModelFromJson(String str) => List<NegociosModel>.from(json.decode(str).map((x) => NegociosModel.fromJson(x)));

String negociosModelToJson(List<NegociosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NegociosModel {
    double latitud;
    double longitud;
    int idNegocio;
    String descNegocio;
    String noAfiliacion;
    String telefono;
    String direccion;
    String colonia;
    String poblacion;
    String estado;
    String cp;

    NegociosModel({
        this.latitud,
        this.longitud,
        this.idNegocio,
        this.descNegocio,
        this.noAfiliacion,
        this.telefono,
        this.direccion,
        this.colonia,
        this.poblacion,
        this.estado,
        this.cp,
    });

    factory NegociosModel.fromJson(Map<String, dynamic> json) => NegociosModel(
        latitud: json["LATITUD"].toDouble(),
        longitud: json["LONGITUD"].toDouble(),
        idNegocio: json["ID_NEGOCIO"],
        descNegocio: json["DESC_NEGOCIO"],
        noAfiliacion: json["NO_AFILIACION"],
        telefono: json["TELEFONO"],
        direccion: json["DIRECCION"],
        colonia: json["COLONIA"],
        poblacion: json["POBLACION"],
        estado: json["ESTADO"],
        cp: json["CP"],
    );

    Map<String, dynamic> toJson() => {
        "LATITUD": latitud,
        "LONGITUD": longitud,
        "ID_NEGOCIO": idNegocio,
        "DESC_NEGOCIO": descNegocio,
        "NO_AFILIACION": noAfiliacion,
        "TELEFONO": telefono,
        "DIRECCION": direccion,
        "COLONIA": colonia,
        "POBLACION": poblacion,
        "ESTADO": estado,
        "CP": cp,
    };
}
