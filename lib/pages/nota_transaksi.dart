import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:barbershop/components/Url.dart';
import 'dart:convert';

class NotaTransaksi extends StatelessWidget {
  final String idTransaksi;
  const NotaTransaksi({super.key, required this.idTransaksi});

  Future<Map<String, dynamic>> ambilData() async {
    try {
      var hasilGet =
          await http.get(Uri.parse("$apiUrl/v1/transaksi/${idTransaksi}"));
      if (hasilGet.statusCode >= 200 && hasilGet.statusCode < 300) {
        var data = json.decode(hasilGet.body) as Map<String, dynamic>;
        String statusPembayaran = data["status_pembayaran"];
        Widget statusWidget;
        if (statusPembayaran == "Lunas") {
          print('selesai');
          statusWidget = Card(
            child: ListTile(
              title: Text("Status pembayaran: Lunas"),
            ),
          );
        } else {
          print('belum');
          statusWidget = Card(
            child: ListTile(
              title: Text("Status pembayaran: Belum"),
            ),
          );
        }
        return data;
      } else {
        throw (hasilGet.statusCode);
      }
    } catch (err) {
      throw (err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF1d1d1d),
        appBar: AppBar(
          backgroundColor: Color(0xFF131311),
          centerTitle: true,
          title: Text(
            'Detail Transaksi',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: ambilData(),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              String statusPembayaran = snapshot.data!['status_pembayaran'];
              Widget statusWidget;
              if (statusPembayaran == 'Lunas') {
                statusWidget = Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Color(0xFF96652B),
                          size: 60,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Card(
                          child: Container(
                            height: 350,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ListView(
                                children: [
                                  Center(
                                    child: Text(
                                      'Manson Barbershop',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: Center(
                                      child: Text(
                                        'nota transaksi - ${snapshot.data?["name"]}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Tanggal :',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        ' ${snapshot.data?["tanggal"]}',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Jam :',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        ' ${snapshot.data?["jam"]} WIB',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Barberman :'),
                                      Text(
                                        '${snapshot.data?["nama_barberman"]}',
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Jenis Layanan :'),
                                      Text(
                                        '${snapshot.data?["jenis_pelayanan"]}',
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Pembayaran :'),
                                      Text(
                                        'Rp. ${snapshot.data?["total_pembayaran"]}',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                statusWidget = Center(
                  child: Text(
                    'Status Pembayaran Anda Belum Selesai',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                );
              }
              return Center(
                child: statusWidget,
              );
            }
          },
        )

        // (context, snapshot) {
        //   if (snapshot.error != null) {
        //     print('${snapshot.error}');
        //     return Center(
        //       child: Text(
        //         "${snapshot.error}",
        //       ),
        //     );
        //   }
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return Center(
        //       child: CircularProgressIndicator(color: Colors.grey),
        //     );
        //   } else {
        //     return ListView(
        //       children: [
        //         Text(
        //           '${snapshot.data?["total_pembayaran"]}',
        //         ),
        //       ],
        //     );
        //   }
        // }
        );
  }
}

class Lunas extends StatelessWidget {
  const Lunas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
