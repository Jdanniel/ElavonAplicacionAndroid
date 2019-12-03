// To parse this JSON data, do
//
//     final MovimientoInventarioSF = MovimientoInventarioSFFromJson(jsonString);

import 'dart:convert';

MovimientoInventarioSF movimientoInventarioSFFromJson(String str) => MovimientoInventarioSF.fromJson(json.decode(str));

String movimientoInventarioSFToJson(MovimientoInventarioSF data) => json.encode(data.toJson());

class MovimientoInventarioSF {
    int idValMovimientosInvServicioFalla;
    int idServicio;
    int idFalla;
    int idMovInventario;
    String status;

    MovimientoInventarioSF({
        this.idValMovimientosInvServicioFalla,
        this.idServicio,
        this.idFalla,
        this.idMovInventario,
        this.status,
    });

    factory MovimientoInventarioSF.fromJson(Map<String, dynamic> json) => MovimientoInventarioSF(
        idValMovimientosInvServicioFalla: json["ID_VAL_MOVIMIENTOS_INV_SERVICIO_FALLA"],
        idServicio: json["ID_SERVICIO"],
        idFalla: json["ID_FALLA"],
        idMovInventario: json["ID_MOV_INVENTARIO"],
        status: json["STATUS"],
    );

    Map<String, dynamic> toJson() => {
        "ID_VAL_MOVIMIENTOS_INV_SERVICIO_FALLA": idValMovimientosInvServicioFalla,
        "ID_SERVICIO": idServicio,
        "ID_FALLA": idFalla,
        "ID_MOV_INVENTARIO": idMovInventario,
        "STATUS": status,
    };
}
