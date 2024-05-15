import 'dart:async';
import 'dart:convert';
import 'package:barbershop/models/barbermanModel.dart';
import 'package:barbershop/models/jamModel.dart';
import 'package:barbershop/models/service.dart';
import 'package:barbershop/pages/homepage.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/Url.dart';
import '../components/shared_preferences.dart';
import 'package:intl/intl.dart';

class Booking extends StatefulWidget {
  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? layananId;
  String? barbermanId;
  String? jam;
  String? pickDate;
  String? pickValue;
  final SharedStorage _sharedStorage = SharedStorage();
  TextEditingController tanggalC = TextEditingController();
  bool isLoading = false;

  DateTime _dateTime = DateTime.now();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _dateTime = value!;
        pickDate = myFormat.format(_dateTime);
        pickValue = pickDate.toString();
      });
    });
  }

  var myFormat = DateFormat('yyyy-MM-d');

  Future booking() async {
    try {
      var userId = await _sharedStorage.getUserId();
      var response = await http.post(
        Uri.parse("$apiUrl/v1/transaksi"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          <String, String>{
            "pelayanan_id": "$layananId",
            "user_id": "$userId",
            "tanggal": "$pickDate",
            "jam": "$jam",
            "barberman_id": "$barbermanId",
            "status_pembayaran": "Belum",
            "status_transaksi": "Belum",
          },
        ),
      );
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data['message'] != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data['message']),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red[400],
            padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Column(
            children: [
              Center(
                child: Text(
                  "Booking layanan berhasil, silahkan cek di Pesanan",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) {
              return HomePage();
            }),
          ),
        );
      }
      print(response.body);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d1d1d),
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          "Booking",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF131311),
      ),
      body: Center(
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "Isi form untuk melakukan booking layanan",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Pilih Tanggal",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Text(
                        myFormat.format(_dateTime).toString(),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _showDatePicker();
                      },
                      icon: Icon(Icons.date_range),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Jenis Layanan",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: DropdownSearch<Services>(
                dropdownDecoratorProps: DropDownDecoratorProps(
                  // baseStyle: TextStyle(color: Colors.black),
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                itemAsString: (Services item) => item.jenis,
                onChanged: (value) => setState(() {
                  layananId = value?.id.toString();
                  print("print id layanan");
                  print(layananId);
                }),
                asyncItems: (text) async {
                  var response = await http.get(
                    Uri.parse("$apiUrl/v1/pelayanan"),
                  );
                  if (response.statusCode != 200) {
                    return [];
                  }
                  List Layanan = (json.decode(response.body)
                      as Map<String, dynamic>)["data"];
                  List<Services> semuaLayanan = [];
                  Layanan.forEach(
                    (element) {
                      semuaLayanan.add(
                        Services(
                          id: element["id"],
                          jenis: element["jenis"],
                          harga: element["harga"],
                          deskripsi: element["deskripsi"],
                        ),
                      );
                    },
                  );
                  return semuaLayanan;
                },
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Barberman",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: DropdownSearch<BarbermanModel>(
                dropdownDecoratorProps: DropDownDecoratorProps(
                  // baseStyle: TextStyle(color: Colors.black),
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                itemAsString: (BarbermanModel item) => item.nama,
                onChanged: (value) => setState(() {
                  barbermanId = value?.id.toString();
                  print("id barberman");
                  print(barbermanId);
                }),
                asyncItems: (text) async {
                  var response = await http.get(
                    Uri.parse("$apiUrl/v1/barberman"),
                  );
                  if (response.statusCode != 200) {
                    return [];
                  }
                  List Barberman = (json.decode(response.body)
                      as Map<String, dynamic>)["data"];
                  List<BarbermanModel> semuaBarberman = [];
                  Barberman.forEach((element) {
                    semuaBarberman.add(
                      BarbermanModel(
                          id: element["id"],
                          nama: element["nama"],
                          umur: element["umur"],
                          foto: element["foto"],
                          deskripsi: element["deskripsi"]),
                    );
                  });
                  return semuaBarberman;
                },
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Jam",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: DropdownSearch<JamModel>(
                dropdownDecoratorProps: DropDownDecoratorProps(
                  // baseStyle: TextStyle(color: Colors.black),
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                itemAsString: (JamModel item) => item.jam,
                onChanged: (value) => setState(() {
                  jam = value?.jam.toString();
                  print("print id jam");
                  print(jam);
                }),
                asyncItems: (text) async {
                  var response = await http.get(
                    Uri.parse("$apiUrl/v1/jam"),
                  );
                  if (response.statusCode != 200) {
                    return [];
                  }
                  List Jam = (json.decode(response.body)
                      as Map<String, dynamic>)["data"];
                  List<JamModel> semuaJam = [];
                  Jam.forEach((element) {
                    semuaJam.add(
                      JamModel(
                        id: element["id"],
                        jam: element["jam"],
                      ),
                    );
                  });
                  return semuaJam;
                },
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              // margin: EdgeInsets.only(left: 110, right: 110),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Color(0xFF96652B),
                    padding: EdgeInsets.all(15)),
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });
                  await Future.delayed(const Duration(seconds: 1));
                  setState(() {
                    isLoading = false;
                    booking();
                  });
                },
                child: (isLoading)
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Booking',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
