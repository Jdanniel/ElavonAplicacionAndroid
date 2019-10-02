// To parse this JSON data, do
//
//     final totalodtsModel = totalodtsModelFromJson(jsonString);

import 'dart:convert';

TotalodtsModel totalodtsModelFromJson(String str) => TotalodtsModel.fromJson(json.decode(str));

String totalodtsModelToJson(TotalodtsModel data) => json.encode(data.toJson());

class TotalodtsModel {
    int nuevas;

    TotalodtsModel({
        this.nuevas,
    });

    factory TotalodtsModel.fromJson(Map<String, dynamic> json) => TotalodtsModel(
        nuevas: json["NUEVAS"],
    );

    Map<String, dynamic> toJson() => {
        "NUEVAS": nuevas,
    };
}
