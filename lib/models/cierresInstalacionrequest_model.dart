// To parse this JSON data, do
//
//     final cierresInstalacionModel = cierresInstalacionModelFromJson(jsonString);

import 'dart:convert';

CierresInstalacionModel cierresInstalacionModelFromJson(String str) => CierresInstalacionModel.fromJson(json.decode(str));

String cierresInstalacionModelToJson(CierresInstalacionModel data) => json.encode(data.toJson());

class CierresInstalacionModel {
    String noSerie;
    String conectividad;
    String aplicativo;
    String version;
    bool bateria;
    bool eliminador;
    bool tapa;
    bool cableAc;
    bool base;
    bool isAmex;
    String idAmex;
    String afiliacionAmex;
    String conclusionesAmex;
    bool notificado;
    bool promociones;
    bool descargaApp;
    String telefono1;
    String telefono2;
    DateTime fechaCierre;
    String atiende;
    String otorganteVobo;
    String tipoAtencion;
    int rollos;
    int discover;
    int caja;
    String comentario;

    CierresInstalacionModel({
        this.noSerie,
        this.conectividad,
        this.aplicativo,
        this.version,
        this.bateria,
        this.eliminador,
        this.tapa,
        this.cableAc,
        this.base,
        this.isAmex,
        this.idAmex,
        this.afiliacionAmex,
        this.conclusionesAmex,
        this.notificado,
        this.promociones,
        this.descargaApp,
        this.telefono1,
        this.telefono2,
        this.fechaCierre,
        this.atiende,
        this.otorganteVobo,
        this.tipoAtencion,
        this.rollos,
        this.discover,
        this.caja,
        this.comentario,
    });

    factory CierresInstalacionModel.fromJson(Map<String, dynamic> json) => CierresInstalacionModel(
        noSerie: json["NO_SERIE"],
        conectividad: json["CONECTIVIDAD"],
        aplicativo: json["APLICATIVO"],
        version: json["VERSION"],
        bateria: json["BATERIA"],
        eliminador: json["ELIMINADOR"],
        tapa: json["TAPA"],
        cableAc: json["CABLE_AC"],
        base: json["BASE"],
        isAmex: json["IS_AMEX"],
        idAmex: json["ID_AMEX"],
        afiliacionAmex: json["AFILIACION_AMEX"],
        conclusionesAmex: json["CONCLUSIONES_AMEX"],
        notificado: json["NOTIFICADO"],
        promociones: json["PROMOCIONES"],
        descargaApp: json["DESCARGA_APP"],
        telefono1: json["TELEFONO_1"],
        telefono2: json["TELEFONO_2"],
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
        "CONECTIVIDAD": conectividad,
        "APLICATIVO": aplicativo,
        "VERSION": version,
        "BATERIA": bateria,
        "ELIMINADOR": eliminador,
        "TAPA": tapa,
        "CABLE_AC": cableAc,
        "BASE": base,
        "IS_AMEX": isAmex,
        "ID_AMEX": idAmex,
        "AFILIACION_AMEX": afiliacionAmex,
        "CONCLUSIONES_AMEX": conclusionesAmex,
        "NOTIFICADO": notificado,
        "PROMOCIONES": promociones,
        "DESCARGA_APP": descargaApp,
        "TELEFONO_1": telefono1,
        "TELEFONO_2": telefono2,
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
