// To parse this JSON data, do
//
//     final CierreRetiroModel = CierreRetiroModelFromJson(jsonString);

import 'dart:convert';

CierreRetiroModel cierreRetiroModelFromJson(String str) => CierreRetiroModel.fromJson(json.decode(str));

String cierreRetiroModelToJson(CierreRetiroModel data) => json.encode(data.toJson());

class CierreRetiroModel {
    String noSerie;
    String marca;
    String modelo;
    String conectividad;
    String aplicativo;
    String version;
    bool bateria;
    bool eliminador;
    bool tapa;
    bool cableAc;
    bool base;
    DateTime fechaCierre;
    String atiende;
    String otorganteVobo;
    String tipoAtencion;
    int rollos;
    int discover;
    int caja;
    String comentario;

    CierreRetiroModel({
        this.noSerie,
        this.marca,
        this.modelo,
        this.conectividad,
        this.aplicativo,
        this.version,
        this.bateria,
        this.eliminador,
        this.tapa,
        this.cableAc,
        this.base,
        this.fechaCierre,
        this.atiende,
        this.otorganteVobo,
        this.tipoAtencion,
        this.rollos,
        this.discover,
        this.caja,
        this.comentario,
    });

    factory CierreRetiroModel.fromJson(Map<String, dynamic> json) => CierreRetiroModel(
        noSerie: json["NO_SERIE"],
        marca: json["MARCA"],
        modelo: json["MODELO"],
        conectividad: json["CONECTIVIDAD"],
        aplicativo: json["APLICATIVO"],
        version: json["VERSION"],
        bateria: json["BATERIA"],
        eliminador: json["ELIMINADOR"],
        tapa: json["TAPA"],
        cableAc: json["CABLE_AC"],
        base: json["BASE"],
        fechaCierre: json["FECHA_CIERRE"],
        atiende: json["ATIENDE"],
        otorganteVobo: json["OTORGANTE_VOBO"],
        tipoAtencion: json["TIPO_ATENCION"],
        rollos: json["ROLLOS"],
        discover: json["DISCOVER"],
        caja: json["CAJA"],
        comentario: json["COMENTARIO"],
    );

    Map<String, dynamic> toJson() => {
        "NO_SERIE": noSerie,
        "MARCA": marca,
        "MODELO": modelo,
        "CONECTIVIDAD": conectividad,
        "APLICATIVO": aplicativo,
        "VERSION": version,
        "BATERIA": bateria,
        "ELIMINADOR": eliminador,
        "TAPA": tapa,
        "CABLE_AC": cableAc,
        "BASE": base,
        "FECHA_CIERRE": fechaCierre,
        "ATIENDE": atiende,
        "OTORGANTE_VOBO": otorganteVobo,
        "TIPO_ATENCION": tipoAtencion,
        "ROLLOS": rollos,
        "DISCOVER": discover,
        "CAJA": caja,
        "COMENTARIO": comentario,
    };
}
