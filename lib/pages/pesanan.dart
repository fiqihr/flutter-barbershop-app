import 'package:barbershop/pages/nota_transaksi.dart';
import 'package:flutter/material.dart';
import '../components/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../components/Url.dart';
import 'dart:convert';
import '../models/transaksiModel.dart';
// import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class Pesanan extends StatefulWidget {
  @override
  State<Pesanan> createState() => _PesananState();
}

class _PesananState extends State<Pesanan> {
  final SharedStorage _sharedStorage = SharedStorage();

  List<TransaksiModel> allTransaksi = [];

  String? result;

  var myFormat = DateFormat('yyyy-MM-d');

  String? condition;

  String variable = 'anjay';
  // bool _showButton = false;

  // Future<void> fetchData() async {
  //   try {
  //     var userId = await _sharedStorage.getUserId();
  //     var response =
  //         await http.get(Uri.parse("$apiUrl/v1/transaksi?user_id[eq]=$userId"));
  //     if (response.statusCode == 200) {
  //       List<dynamic> data = json.decode(response.body)["data"];
  //       for (var item in data) {
  //         if (item["status_transaksi"] == "Selesai") {
  //           setState(() {
  //             _showButton = true;
  //           });
  //           break;
  //         }
  //       }
  //     } else {
  //       throw Exception('Failed to load data');
  //     }
  //   } catch (e) {
  //     print("An error occurred: $e");
  //   }
  // }

  Future getTransaksi() async {
    try {
      var userId = await _sharedStorage.getUserId();
      var response = await http.get(
        Uri.parse("$apiUrl/v1/transaksi?user_id[eq]=$userId"),
      );
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      bool _showButton = false;

      data.forEach(
        (element) {
          allTransaksi.add(
            TransaksiModel.fromJson(element),
          );
        },
      );
      data.forEach((item) {
        condition = item["status_transaksi"];
        print(condition);
      });
    } catch (e) {
      print("terjadi salah");
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d1d1d),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Pesanan",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        // future: getTransaksi(),
        future: getTransaksi(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            return Center(
              child: Text(
                "${snapshot.error}",
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.grey),
            );
          } else {
            if (allTransaksi.length == 0) {
              return Center(
                child: Text(
                  "Kamu belum memiliki pesanan",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(20),
              physics: BouncingScrollPhysics(),
              itemCount: allTransaksi.length,
              itemBuilder: (context, index) => Container(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.only(top: 10, bottom: 5),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          top: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                    "${allTransaksi[index].tanggal.day.toString().padLeft(2, '0')}-${allTransaksi[index].tanggal.month.toString().padLeft(2, '0')}-${allTransaksi[index].tanggal.year} | ${allTransaksi[index].jam} WIB"),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                var idTransaksi = "${allTransaksi[index].id}";
                                print(idTransaksi);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NotaTransaksi(idTransaksi: idTransaksi),
                                  ),
                                );
                              },
                              child: Text('Nota Transaksi'),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black),
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${allTransaksi[index].jenisPelayanan}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    "Barberman: ${allTransaksi[index].namaBarberman}"),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "${allTransaksi[index].statusTransaksi}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateColor.resolveWith(
                                  (states) => Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
