import 'package:barbershop/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:barbershop/components/Url.dart';
import 'package:http/http.dart' as http;
import 'profile.dart';
import 'dart:convert';
import '../components/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final dataName;
  final dataEmail;
  final dataTelepon;
  final dataAlamat;
  final dataJenisKelamin;

  EditProfile(
      {super.key,
      required this.dataName,
      required this.dataEmail,
      required this.dataAlamat,
      required this.dataTelepon,
      required this.dataJenisKelamin});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _nameController = new TextEditingController();
  final _emailController = new TextEditingController();
  final _teleponController = new TextEditingController();
  final _alamatController = new TextEditingController();
  final _jenisKelaminController = new TextEditingController();
  final SharedStorage _sharedStorage = SharedStorage();
  bool isLoading = false;

  Future updateProfile() async {
    try {
      var userId = await _sharedStorage.getUserId();
      var response = await http.put(
        Uri.parse("$apiUrl/v1/user/$userId"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          <String, String>{
            "name": _nameController.text.toString(),
            "email": _emailController.text.toString(),
            "telepon": _teleponController.text.toString(),
            "alamat": _alamatController.text.toString(),
            "jenis_kelamin": _jenisKelaminController.text.toString(),
            "foto": "default.jpg"
          },
        ),
      );

      // Map<String, dynamic> data = json.decode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              "Berhasil melakukan update profile",
              style: TextStyle(color: Colors.black),
            ),
          ),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: ((context) {
            return HomePage();
          }),
        ),
      );

      // print(response.body);
    } catch (err) {
      print(err);
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.dataName;
    _emailController.text = widget.dataEmail;
    _teleponController.text = widget.dataTelepon;
    _alamatController.text = widget.dataAlamat;
    _jenisKelaminController.text = widget.dataJenisKelamin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d1d1d),
      appBar: AppBar(
        title: Text("Edit Profil"),
        centerTitle: true,
        backgroundColor: Color(0xFF131311),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 30, right: 30, top: 30),
        children: [
          TextField(
            controller: _nameController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'nama',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: _emailController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'email',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: _teleponController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'telepon',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            controller: _alamatController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'alamat',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'jenis kelamin',
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            controller: _jenisKelaminController,
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              primary: Color(0xFF96652B),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              await Future.delayed(const Duration(seconds: 1));
              setState(() {
                isLoading = false;
                updateProfile();
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
                    'Update Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
