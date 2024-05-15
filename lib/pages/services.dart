import 'dart:convert';

import 'package:barbershop/components/Url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/service.dart';
import '../pages/detailservicebismillah.dart';

class Service extends StatelessWidget {
  List<Services> allService = [];

  Future getAllService() async {
    try {
      var response = await http.get(Uri.parse("$apiUrl/v1/pelayanan"));
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      data.forEach(
        (element) {
          allService.add(
            // didapat dari user.dart agar tdk terjadi kesalahan penulisan
            Services.fromJson(element),
          );
        },
      );
      print(allService);
    } catch (e) {
      print("terjadi salah");
      print(e);
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
          "Services",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF131311),
      ),
      body: FutureBuilder(
        future: getAllService(),
        //snapshot digunakan untuk mengecek apakah sedang loading atau tidak
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          } else {
            if (allService.length == 0) {
              return Center(
                child: Text("Tidak Ada Data"),
              );
            }
            return ListView.builder(
              itemCount: allService.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  var dataId = "${allService[index].id}";
                  print(dataId);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailServiceBismillah(
                        dataId: dataId,
                      ),
                    ),
                  );
                  print("${allService[index].jenis}");
                  print("${allService[index].harga}");
                  print("berhasil");
                },
                child: Card(
                  color: Color(0xFF131311),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${allService[index].jenis}",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          ">",
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ListTile(
                //     title: Text(
                //       "${allService[index].jenis}",
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //     subtitle: Text(
                //       " ${allService[index].harga}",
                //       style: TextStyle(
                //         color: Colors.white,
                //       ),
                //     ),
                //     onTap: () {
                //       var dataId = "${allService[index].id}";
                //       print(dataId);
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => DetailServiceBismillah(
                //             dataId: dataId,
                //           ),
                //         ),
                //       );
                //       print("${allService[index].jenis}");
                //       print("${allService[index].harga}");
                //       print("berhasil");
                //     }),
              ),
            );

            // ListTile(
            //   title: Text("${allService[index].harga}"),
            //   subtitle: Text(" ${allService[index].jenis}"),

            // title: Text("${allUSer[index].firstName} ${allUSer[index].lastName}"),
            // subtitle: Text("${allUSer[index].email}"),
          }
        },
      ),
    );
  }
}
