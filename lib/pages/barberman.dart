import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/Url.dart';
import '../models/service.dart';
import '../models/barbermanModel.dart';
import '../pages/detailservicebismillah.dart';

class Barberman extends StatelessWidget {
  List<BarbermanModel> allBarberman = [];

  Future getAllBarberman() async {
    try {
      var response = await http.get(
        Uri.parse("$apiUrl/v1/barberman"),
      );
      List data = (json.decode(response.body) as Map<String, dynamic>)["data"];
      data.forEach(
        (element) {
          allBarberman.add(
            // didapat dari user.dart agar tdk terjadi kesalahan penulisan
            BarbermanModel.fromJson(element),
          );
        },
      );
      print(allBarberman);
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
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          "Barberman",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: FutureBuilder(
        future: getAllBarberman(),
        //snapshot digunakan untuk mengecek apakah sedang loading atau tidak
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          } else {
            if (allBarberman.length == 0) {
              return Center(
                child: Text("Tidak Ada Data"),
              );
            }
            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: allBarberman.length,
              itemBuilder: (context, index) => Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: 395,
                      height: 480,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Align(
                              child: Container(
                                width: 395,
                                height: 395,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    "$apiUrl/image/public/images/foto_barberman/${allBarberman[index].foto}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 8,
                            top: 340,
                            child: Align(
                              child: SizedBox(
                                width: 380,
                                height: 128,
                                // height: 128,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff96652b),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 29,
                            top: 365,
                            child: Align(
                              child: SizedBox(
                                width: 80,
                                height: 31,
                                child: Text(
                                  "${allBarberman[index].nama}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.2125,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 300,
                            top: 372,
                            child: Align(
                              child: SizedBox(
                                width: 65,
                                height: 14,
                                child: Text(
                                  "${allBarberman[index].umur}" + " tahun",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2125,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 29,
                            top: 405,
                            child: Align(
                              child: SizedBox(
                                width: 338,
                                height: 100,
                                child: Text(
                                  "${allBarberman[index].deskripsi}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Column(
              //   children: [
              //     Text("${allService[index].nama}"),
              //     Image(
              //       image: NetworkImage(
              //           "http://10.113.114.192:8000/api/image/public/images/foto_barberman/${allService[index].foto}"),
              //     ),
              //   ],
              // ),
            );
          }
        },
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 395,
              height: 480,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[800],
                        ),
                        width: 395,
                        height: 395,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 340,
                    child: Align(
                      child: SizedBox(
                        width: 380,
                        height: 128,
                        // height: 128,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              width: 395,
              height: 480,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[800],
                        ),
                        width: 395,
                        height: 395,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 340,
                    child: Align(
                      child: SizedBox(
                        width: 380,
                        height: 128,
                        // height: 128,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // CircularProgressIndicator(
          //   color: Colors.grey[400],
          // ),
        ),
      ),
    );
  }
}
