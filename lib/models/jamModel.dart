// To parse this JSON data, do
//
//     final barbermanModel = barbermanModelFromJson(jsonString);

import 'dart:convert';

JamModel jamModelFromJson(String str) => JamModel.fromJson(json.decode(str));

String jamModelToJson(JamModel data) => json.encode(data.toJson());

class JamModel {
  JamModel({
    required this.id,
    required this.jam,
  });

  int id;
  String jam;

  factory JamModel.fromJson(Map<String, dynamic> json) => JamModel(
        id: json["id"],
        jam: json["jam"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jam": jam,
      };
}
