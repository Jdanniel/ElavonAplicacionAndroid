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
    String poblacion;
    String direccion;
    double latitud;
    double longitud;
    int days;
    int months;
    int years;
    int numbers;
    int idStatusAr;
    int idServicio;
    int idFalla;
    String estatusAr;

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
        this.poblacion = '',
        this.direccion = '',
        this.latitud = 0,
        this.longitud = 0,
        this.days = 0,
        this.months = 0,
        this.years = 0,
        this.numbers = 0,
        this.idStatusAr = 0,
        this.idServicio = 0,
        this.idFalla = 0,
        this.estatusAr = ''
    });

    factory Odtmodel.fromJson(Map<String, dynamic> json) => Odtmodel(
        odt: json["NO_AR"],
        noAfiliacion: json["NO_AFILIACION"],
        fecGarantia: json["FEC_GARANTIA"],
        negocio: json["DESC_NEGOCIO"],
        idAr: json["ID_AR"],
        idNegocio: json["ID_NEGOCIO"],
        idTipoServicio: json["ID_TIPO_SERVICIO"],
        estado: json["ESTADO"],
        colonia: json["COLONIA"],
        poblacion: json["POBLACION"],
        direccion: json["DIRECCION"],
        latitud: json["LATITUD"],
        longitud: json["LONGITUD"],
        days:  json["DAYS"],
        months: json["MONTHS"],
        years: json["YEARS"],
        numbers: json["NUMBER"],
        idStatusAr: json["ID_STATUS_AR"],
        idServicio: json["ID_SERVICIO"],
        idFalla: json["ID_FALLA"],
        estatusAr: json["DESC_STATUS_AR"]
    );

    Map<String, dynamic> toJson() => {
        "NO_AR": odt,
        "NO_AFILIACION": noAfiliacion,
        "FEC_GARANTIA": fecGarantia,
        "DESC_NEGOCIO": negocio,
        "ID_AR": idAr,
        "ID_NEGOCIO": idNegocio,
        "ID_TIPO_SERVICIO" : idTipoServicio,
        "ESTADO": estado,
        "COLONIA": colonia,
        "POBLACION": poblacion,
        "DIRECCION": direccion,
        "LATITUD" : latitud,
        "LONGITUD" : longitud, 
        "DAYS": days,
        "MONTHS": months,
        "YEARS": years,
        "NUMBER": numbers,
        "ID_STATUS_AR": idStatusAr,
        "ID_SERVICIO": idServicio,
        "ID_FALLA": idFalla,
        "DESC_STATUS_AR" : estatusAr
    };
}
