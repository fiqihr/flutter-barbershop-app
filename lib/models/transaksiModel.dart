// To parse this JSON data, do
//
//     final transaksiModel = transaksiModelFromJson(jsonString);

import 'dart:convert';

TransaksiModel transaksiModelFromJson(String str) => TransaksiModel.fromJson(json.decode(str));

String transaksiModelToJson(TransaksiModel data) => json.encode(data.toJson());

class TransaksiModel {
    int id;
    int pelayananId;
    String jenisPelayanan;
    int userId;
    DateTime tanggal;
    String jam;
    int barbermanId;
    String namaBarberman;
    String statusPembayaran;
    String statusTransaksi;

    TransaksiModel({
        required this.id,
        required this.pelayananId,
        required this.jenisPelayanan,
        required this.userId,
        required this.tanggal,
        required this.jam,
        required this.barbermanId,
        required this.namaBarberman,
        required this.statusPembayaran,
        required this.statusTransaksi,
    });

    factory TransaksiModel.fromJson(Map<String, dynamic> json) => TransaksiModel(
        id: json["id"],
        pelayananId: json["pelayanan_id"],
        jenisPelayanan: json["jenis_pelayanan"],
        userId: json["user_id"],
        tanggal: DateTime.parse(json["tanggal"]),
        jam: json["jam"],
        barbermanId: json["barberman_id"],
        namaBarberman: json["nama_barberman"],
        statusPembayaran: json["status_pembayaran"],
        statusTransaksi: json["status_transaksi"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pelayanan_id": pelayananId,
        "jenis_pelayanan": jenisPelayanan,
        "user_id": userId,
        "tanggal": "${tanggal.year.toString().padLeft(4, '0')}-${tanggal.month.toString().padLeft(2, '0')}-${tanggal.day.toString().padLeft(2, '0')}",
        "jam": jam,
        "barberman_id": barbermanId,
        "nama_barberman": namaBarberman,
        "status_pembayaran": statusPembayaran,
        "status_transaksi": statusTransaksi,
    };
}
