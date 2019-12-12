// To parse this JSON data, do
//
//     final bdCambioStatusArModel = bdCambioStatusArModelFromJson(jsonString);

import 'dart:convert';

BdCambioStatusArModel bdCambioStatusArModelFromJson(String str) => BdCambioStatusArModel.fromJson(json.decode(str));

String bdCambioStatusArModelToJson(BdCambioStatusArModel data) => json.encode(data.toJson());

class BdCambioStatusArModel {
    int idCambioStatusAr;
    int idStatusArIni;
    int idStatusArFin;

    BdCambioStatusArModel({
        this.idCambioStatusAr = 0,
        this.idStatusArIni = 0,
        this.idStatusArFin = 0,
    });

    factory BdCambioStatusArModel.fromJson(Map<String, dynamic> json) => BdCambioStatusArModel(
        idCambioStatusAr: json["ID_CAMBIO_STATUS_AR"],
        idStatusArIni: json["ID_STATUS_AR_INI"],
        idStatusArFin: json["ID_STATUS_AR_FIN"],
    );

    Map<String, dynamic> toJson() => {
        "ID_CAMBIO_STATUS_AR": idCambioStatusAr,
        "ID_STATUS_AR_INI": idStatusArIni,
        "ID_STATUS_AR_FIN": idStatusArFin,
    };
}
