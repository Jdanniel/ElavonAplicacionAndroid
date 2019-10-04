// To parse this JSON data, do
//
//     final cmodelosModel = cmodelosModelFromJson(jsonString);

import 'dart:convert';

List<CmodelosModel> cmodelosModelFromJson(String str) => List<CmodelosModel>.from(json.decode(str).map((x) => CmodelosModel.fromJson(x)));

String cmodelosModelToJson(List<CmodelosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CmodelosModel {
    int idModelo;
    String descModelo;

    CmodelosModel({
        this.idModelo,
        this.descModelo,
    });

    factory CmodelosModel.fromJson(Map<String, dynamic> json) => CmodelosModel(
        idModelo: json["ID_MODELO"],
        descModelo: json["DESC_MODELO"],
    );

    Map<String, dynamic> toJson() => {
        "ID_MODELO": idModelo,
        "DESC_MODELO": descModelo,
    };
}
