// To parse this JSON data, do
//
//     final odtmodel = odtmodelFromJson(jsonString);

import 'dart:convert';

Odtmodel odtmodelFromJson(String str) => Odtmodel.fromJson(json.decode(str));

String odtmodelToJson(Odtmodel data) => json.encode(data.toJson());

class Odtmodel {
    String odt;
    String noAfiliacion;
    String fecGarantia;
    String negocio;
    int idAr;
    int idNegocio;
    String estado;
    String colonia;
    double latitud;
    double longitud;

    Odtmodel({
        this.odt = '',
        this.noAfiliacion = '',
        this.fecGarantia = '',
        this.negocio = '',
        this.idAr = 0,
        this.idNegocio = 0,
        this.estado = '',
        this.colonia = '',
        this.latitud = 0,
        this.longitud = 0
    });

    factory Odtmodel.fromJson(Map<String, dynamic> json) => Odtmodel(
        odt: json["NO_AR"],
        noAfiliacion: json["NO_AFILIACION"],
        fecGarantia: json["FEC_GARANTIA"],
        negocio: json["NEGOCIO"],
        idAr: json["ID_AR"],
        idNegocio: json["ID_NEGOCIO"],
        estado: json["ESTADO"],
        colonia: json["COLONIA"],
        latitud: json["LATITDUD"],
        longitud: json["LONGITUD"]
    );

    Map<String, dynamic> toJson() => {
        "NO_AR": odt,
        "NO_AFILIACION": noAfiliacion,
        "FEC_GARANTIA": fecGarantia,
        "NEGOCIO": negocio,
        "ID_AR": idAr,
        "ESTADO": estado,
        "COLONIA": colonia,
        "LATITUD" : latitud,
        "LONGITUD" : longitud
    };
}
