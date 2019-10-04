// To parse this JSON data, do
//
//     final softwaremodel = softwaremodelFromJson(jsonString);

import 'dart:convert';

List<Softwaremodel> softwaremodelFromJson(String str) => List<Softwaremodel>.from(json.decode(str).map((x) => Softwaremodel.fromJson(x)));

String softwaremodelToJson(List<Softwaremodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Softwaremodel {
    int idSoftware;
    String descSoftware;

    Softwaremodel({
        this.idSoftware,
        this.descSoftware,
    });

    factory Softwaremodel.fromJson(Map<String, dynamic> json) => Softwaremodel(
        idSoftware: json["ID_SOFTWARE"],
        descSoftware: json["DESC_SOFTWARE"],
    );

    Map<String, dynamic> toJson() => {
        "ID_SOFTWARE": idSoftware,
        "DESC_SOFTWARE": descSoftware,
    };
}
