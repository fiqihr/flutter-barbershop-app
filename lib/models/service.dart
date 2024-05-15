// To parse this JSON data, do
//
//     final services = servicesFromJson(jsonString);

import 'dart:convert';

Services servicesFromJson(String str) => Services.fromJson(json.decode(str));

String servicesToJson(Services data) => json.encode(data.toJson());

class Services {
    Services({
        required this.id,
        required this.jenis,
        required this.harga,
        required this.deskripsi,
    });

    int id;
    String jenis;
    int harga;
    String deskripsi;

    factory Services.fromJson(Map<String, dynamic> json) => Services(
        id: json["id"],
        jenis: json["jenis"],
        harga: json["harga"],
        deskripsi: json["deskripsi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "jenis": jenis,
        "harga": harga,
        "deskripsi": deskripsi,
    };
}
