// To parse this JSON data, do
//
//     final updatesModel = updatesModelFromJson(jsonString);

import 'dart:convert';

UpdatesModel updatesModelFromJson(String str) => UpdatesModel.fromJson(json.decode(str));

String updatesModelToJson(UpdatesModel data) => json.encode(data.toJson());

class UpdatesModel {
    String fecha;

    UpdatesModel({
        this.fecha = '',
    });

    factory UpdatesModel.fromJson(Map<String, dynamic> json) => UpdatesModel(
        fecha: json["FECHA"],
    );

    Map<String, dynamic> toJson() => {
        "FECHA": fecha,
    };
}
