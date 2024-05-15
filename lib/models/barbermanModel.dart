// To parse this JSON data, do
//
//     final barbermanModel = barbermanModelFromJson(jsonString);

import 'dart:convert';

BarbermanModel barbermanModelFromJson(String str) =>
    BarbermanModel.fromJson(json.decode(str));

String barbermanModelToJson(BarbermanModel data) => json.encode(data.toJson());

class BarbermanModel {
  BarbermanModel({
    required this.id,
    required this.nama,
    required this.umur,
    required this.foto,
    required this.deskripsi,
  });

  int id;
  String nama;
  String umur;
  String foto;
  String deskripsi;

  factory BarbermanModel.fromJson(Map<String, dynamic> json) => BarbermanModel(
        id: json["id"],
        nama: json["nama"],
        umur: json["umur"],
        foto: json["foto"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "umur": umur,
        "foto": foto,
        "deskripsi": deskripsi,
      };
}
