import 'package:barbershop/components/Url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailServiceBismillah extends StatelessWidget {
  final String dataId;
  const DetailServiceBismillah({super.key, required this.dataId});

  Future<Map<String, dynamic>> ambilData() async {
    try {
      var hasilGet =
          await http.get(Uri.parse("$apiUrl/v1/pelayanan/${dataId}"));
      if (hasilGet.statusCode >= 200 && hasilGet.statusCode < 300) {
        var data = json.decode(hasilGet.body)["data"] as Map<String, dynamic>;
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
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Detail Layanan",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        future: ambilData(),
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
            print(snapshot.data?["jenis"]);
            var foto = snapshot.data?["foto"];
            print(foto);
            return Container(
              margin: EdgeInsets.all(20),
              // color: Colors.amber,
              child: ListView(
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        "$apiUrl/image/public/images/foto_pelayanan/${foto}",
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${snapshot.data?["jenis"]}",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(
                    "${snapshot.data?["deskripsi"]}",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff131311),
                        ),
                        child: Center(
                          child: Text(
                            "Rp. ${snapshot.data?["harga"]}",
                            style: TextStyle(
                              color: Color(0xFF96652B),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Card(
                      //   color: Color(0xff131311),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: SizedBox(
                      //     width: 120,
                      //     height: 50,
                      //     child: Center(
                      //       child: Text(
                      //         "Rp. ${snapshot.data?["harga"]}",
                      //         style: TextStyle(
                      //           color: Color(0xFF96652B),
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // Container(
                  //   height: 50,
                  //   width: 150,
                  //   decoration: BoxDecoration(
                  //     color: Color(0xFF131311),
                  //   ),
                  //   child: Stack(
                  //     children: [
                  //       Text(
                  //         "Rp. ${snapshot.data?["harga"]}",
                  //         style: TextStyle(
                  //           color: Color(0xFF96652B),
                  //           fontSize: 20,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            );
            // Column(
            //   children: [
            //     Image(
            //       image: NetworkImage(
            //           "$apiUrl/image/public/images/foto_pelayanan/${foto}"),
            //     ),
            //     Text(
            //       "${snapshot.data?["jenis"]}",
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //     Text(
            //       "${snapshot.data?["harga"]}",
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //     Text(
            //       "${snapshot.data?["deskripsi"]}",
            //       style: TextStyle(
            //         color: Colors.white,
            //       ),
            //     ),
            //   ],
            // );
          }
        },
      ),
    );
  }
}
