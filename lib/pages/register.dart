import 'dart:convert';

import 'package:barbershop/components/Url.dart';
import 'package:barbershop/pages/login.dart';
import 'package:flutter/material.dart';
import '../models/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:barbershop/components/data_holder.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // String time =
  //     DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10);
  bool hiddenPassword = true;
  // Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate);

  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  TextEditingController teleponC = TextEditingController();
  TextEditingController alamatC = TextEditingController();
  TextEditingController jenisKelaminC = TextEditingController();

  List<UserModel> dataUser = [];

  Future register() async {
    try {
      var response = await http.post(
        Uri.parse("$apiUrl/v1/register"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          <String, String>{
            "name": nameC.text,
            "email": emailC.text,
            "password": passwordC.text,
            "telepon": teleponC.text,
            "alamat": alamatC.text,
            "jenis_kelamin": jenisKelaminC.text,
            "foto": "default.jpg"
            // "created_at": ,
            // "updated_at": time,
          },
        ),
      );
      print(response.body);
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131311),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 30, right: 30),
          children: [
            Center(
              child: Text(
                "Register",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 40),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: nameC,
              autocorrect: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                labelText: "nama",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: emailC,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                labelText: "email",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: passwordC,
              autocorrect: false,
              obscureText: hiddenPassword,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                labelText: "password",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                // prefixIcon: Icon(
                //   Icons.key,
                //   color: Colors.grey,
                // ),
                suffixIcon: IconButton(
                  onPressed: () {
                    if (hiddenPassword == true) {
                      hiddenPassword = false;
                    } else {
                      hiddenPassword = true;
                    }
                    // untuk merubah agar kolom password bisa tersembunyi dan dibuka
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: teleponC,
              autocorrect: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                labelText: "telepon",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: alamatC,
              autocorrect: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                labelText: "alamat",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 25),
            TextField(
              style: TextStyle(color: Colors.white),
              controller: jenisKelaminC,
              autocorrect: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                labelText: "jenis kelamin",
                labelStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                register();
                // print("berhasil");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                      child: Text(
                        'Register berhasil, silahkan melakukan login',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    duration: Duration(seconds: 3),
                    backgroundColor: Colors.grey[300],
                    padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                );
                Navigator.of(context).pop(
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: Text(
                "Daftar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF96652B),
                padding: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sudah memiliki akun? ",
                  style: TextStyle(color: Colors.grey),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  child: new Text(
                    "Masuk",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
