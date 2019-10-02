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
    String estado;
    String colonia;

    Odtmodel({
        this.odt = '',
        this.noAfiliacion = '',
        this.fecGarantia = '',
        this.negocio = '',
        this.idAr = 0,
        this.estado = '',
        this.colonia = '',
    });

    factory Odtmodel.fromJson(Map<String, dynamic> json) => Odtmodel(
        odt: json["NO_AR"],
        noAfiliacion: json["NO_AFILIACION"],
        fecGarantia: json["FEC_GARANTIA"],
        negocio: json["NEGOCIO"],
        idAr: json["ID_AR"],
        estado: json["ESTADO"],
        colonia: json["COLONIA"],
    );

    Map<String, dynamic> toJson() => {
        "NO_AR": odt,
        "NO_AFILIACION": noAfiliacion,
        "FEC_GARANTIA": fecGarantia,
        "NEGOCIO": negocio,
        "ID_AR": idAr,
        "ESTADO": estado,
        "COLONIA": colonia,
    };
}
