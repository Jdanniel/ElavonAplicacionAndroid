// To parse this JSON data, do
//
//     final FallasModel = FallasModelFromJson(jsonString);

import 'dart:convert';

List<FallasModel> fallasModelFromJson(String str) => List<FallasModel>.from(json.decode(str).map((x) => FallasModel.fromJson(x)));

String fallasModelToJson(List<FallasModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FallasModel {
    int idFalla;
    String descFalla;

    FallasModel({
        this.idFalla,
        this.descFalla,
    });

    factory FallasModel.fromJson(Map<String, dynamic> json) => FallasModel(
        idFalla: json["ID_FALLA"],
        descFalla: json["DESC_FALLA"],
    );

    Map<String, dynamic> toJson() => {
        "ID_FALLA": idFalla,
        "DESC_FALLA": descFalla,
    };
}
