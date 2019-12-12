// To parse this JSON data, do
//
//     final cStatusArModel = cStatusArModelFromJson(jsonString);

import 'dart:convert';

CStatusArModel cStatusArModelFromJson(String str) => CStatusArModel.fromJson(json.decode(str));

String cStatusArModelToJson(CStatusArModel data) => json.encode(data.toJson());

class CStatusArModel {
    int idStatusAr;
    String descStatusAr;

    CStatusArModel({
        this.idStatusAr = 0,
        this.descStatusAr = '',
    });

    factory CStatusArModel.fromJson(Map<String, dynamic> json) => CStatusArModel(
        idStatusAr: json["ID_STATUS_AR"],
        descStatusAr: json["DESC_STATUS_AR"],
    );

    Map<String, dynamic> toJson() => {
        "ID_STATUS_AR": idStatusAr,
        "DESC_STATUS_AR": descStatusAr,
    };
}
