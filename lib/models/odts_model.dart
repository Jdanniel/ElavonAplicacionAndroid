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
    int idTipoServicio;
    String estado;
    String colonia;
    double latitud;
    double longitud;
    int days;
    int months;
    int years;
    int numbers;

    Odtmodel({
        this.odt = '',
        this.noAfiliacion = '',
        this.fecGarantia = '',
        this.negocio = '',
        this.idAr = 0,
        this.idNegocio = 0,
        this.idTipoServicio = 0,
        this.estado = '',
        this.colonia = '',
        this.latitud = 0,
        this.longitud = 0,
        this.days = 0,
        this.months = 0,
        this.years = 0,
        this.numbers
    });

    factory Odtmodel.fromJson(Map<String, dynamic> json) => Odtmodel(
        odt: json["NO_AR"],
        noAfiliacion: json["NO_AFILIACION"],
        fecGarantia: json["FEC_GARANTIA"],
        negocio: json["NEGOCIO"],
        idAr: json["ID_AR"],
        idNegocio: json["ID_NEGOCIO"],
        idTipoServicio: json["ID_TIPO_SERVICIO"],
        estado: json["ESTADO"],
        colonia: json["COLONIA"],
        latitud: json["LATITDUD"],
        longitud: json["LONGITUD"],
        days:  json["DIA"],
        months: json["MES"],
        years: json["AA"],
        numbers: json["NUMBER"]
    );

    Map<String, dynamic> toJson() => {
        "NO_AR": odt,
        "NO_AFILIACION": noAfiliacion,
        "FEC_GARANTIA": fecGarantia,
        "NEGOCIO": negocio,
        "ID_AR": idAr,
        "ID_NEGOCIO": idNegocio,
        "ID_TIPO_SERVICIO" : idTipoServicio,
        "ESTADO": estado,
        "COLONIA": colonia,
        "LATITUD" : latitud,
        "LONGITUD" : longitud, 
        "DIA": days,
        "MES": months,
        "AA": years,
        "NUMBER": numbers  
    };
}
