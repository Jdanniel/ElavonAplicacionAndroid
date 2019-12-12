// To parse this JSON data, do
//
//     final statusCambioResponseModel = statusCambioResponseModelFromJson(jsonString);

import 'dart:convert';

StatusCambioResponseModel statusCambioResponseModelFromJson(String str) => StatusCambioResponseModel.fromJson(json.decode(str));

String statusCambioResponseModelToJson(StatusCambioResponseModel data) => json.encode(data.toJson());

class StatusCambioResponseModel {
    int idStatusAr;
    String descStatusAr;

    StatusCambioResponseModel({
        this.idStatusAr,
        this.descStatusAr,
    });

    factory StatusCambioResponseModel.fromJson(Map<String, dynamic> json) => StatusCambioResponseModel(
        idStatusAr: json["ID_STATUS_AR"],
        descStatusAr: json["DESC_STATUS_AR"],
    );

    Map<String, dynamic> toJson() => {
        "ID_STATUS_AR": idStatusAr,
        "DESC_STATUS_AR": descStatusAr,
    };
}
