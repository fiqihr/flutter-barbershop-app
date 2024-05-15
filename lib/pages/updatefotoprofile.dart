import 'package:barbershop/models/userModel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:barbershop/components/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:barbershop/components/Url.dart';
import 'homepage.dart';

class UpdateFotoProfile extends StatefulWidget {
  // final String dataFoto;

  const UpdateFotoProfile({
    super.key,
  });

  @override
  State<UpdateFotoProfile> createState() => _UpdateFotoProfileState();
}

class _UpdateFotoProfileState extends State<UpdateFotoProfile> {
  TextEditingController txtFilePicker = TextEditingController();
  final SharedStorage _sharedStorage = SharedStorage();

// final String dataFoto;
  late File filePickerVal;

  List<UserModel> dataUser = [];

  Future<Map<String, dynamic>> getDataUser() async {
    try {
      var userId = await _sharedStorage.getUserId();
      print(userId);
      var getUser = await http.get(Uri.parse("$apiUrl/v1/user/$userId"));
      if (getUser.statusCode == 200) {
        var data = json.decode(getUser.body)["data"] as Map<String, dynamic>;
        return data;
      } else {
        throw (getUser.statusCode);
      }
    } catch (err) {
      throw (err);
    }
  }

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);
    if (result != null) {
      setState(() {
        txtFilePicker.text = result.files.single.name;
        filePickerVal = File(result.files.single.path.toString());
        print(filePickerVal);
      });
    } else {
      // user batal mengepick
    }
  }

  simpan() async {
    var userId = await _sharedStorage.getUserId();
    print('id user ' + userId.toString());
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$apiUrl/v1/updateFotoProfile/$userId'),
      );
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      request.files.add(http.MultipartFile('foto',
          filePickerVal.readAsBytes().asStream(), filePickerVal.lengthSync(),
          filename: filePickerVal.path.split("/").last));

      var res = await request.send();
      var responseBytes = await res.stream.toBytes();
      var responseString = utf8.decode(responseBytes);

      Map<String, dynamic> data = json.decode(responseString);
      print(data['message']);

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Center(
                child: Text(
                  "Foto Profil berhasil diperbarui.",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: 10,
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
            builder: (context) => HomePage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Periksa formulir anda, terdapat kesalahan !"),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.white,
          padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ));
      }
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d1d1d),
      appBar: AppBar(
        title: Text("Update Foto"),
        centerTitle: true,
        backgroundColor: Color(0xFF131311),
        leading: BackButton(color: Colors.white),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          children: [
            SizedBox(
              height: 7,
            ),
            Center(
              child: Column(
                children: [
                  FutureBuilder(
                    future: getDataUser(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SizedBox(
                            height: 170,
                            width: 170,
                            child: CircularProgressIndicator(
                              color: Colors.grey,
                              strokeWidth: 10,
                            ),
                          ),
                        );
                      } else {
                        var foto = snapshot.data?["foto"];
                        return Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(90),
                            image: DecorationImage(
                                image: NetworkImage(
                                    '$apiUrl/image/public/images/foto_user/$foto'),
                                fit: BoxFit.cover),
                          ),
                        );
                      }
                    }),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Foto Profile",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Upload Foto Profile Baru",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                          controller: txtFilePicker,
                          readOnly: true,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'File harus diupload';
                            } else {
                              return null;
                            }
                          },
                          // controller: txtFilePicker,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2),
                            ),
                            hintText: 'Upload File',
                            contentPadding: EdgeInsets.all(10.0),
                          ),
                          style: const TextStyle(fontSize: 16.0)),
                    ),
                    const SizedBox(width: 5),
                    ElevatedButton.icon(
                      icon: const Icon(
                        Icons.upload_file_rounded,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      label: const Text('Pilih File',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                          )),
                      onPressed: () {
                        selectFile();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFF96652B),
                        minimumSize: const Size(122, 48),
                        maximumSize: const Size(122, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  simpan();
                });
              },
              child: Text(
                "Simpan",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Color(0xFF96652B),
                  padding: EdgeInsets.all(15)),
            ),
          ],
        ),
      ),
    );
  }
}
