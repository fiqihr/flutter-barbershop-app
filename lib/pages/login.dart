// import 'package:barbershop/blocs/auth_bloc.dart';
import 'dart:convert';
import '../models/userModel.dart';
import 'package:barbershop/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/Url.dart';
import '../components/shared_preferences.dart';
import './homepage.dart';
import './register.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool hiddenPassword = true;
  bool isLogin = false;

  final SharedStorage _sharedStorage = SharedStorage();

  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();

  List<UserModel> dataUser = [];

  Future login() async {
    try {
      var response = await http.post(
        Uri.parse("$apiUrl/v1/login"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(
          <String, dynamic>{
            "email": emailC.text,
            "password": passC.text,
          },
        ),
      );

      print(response.body);

      if (response.statusCode == 201) {
        Map<String, dynamic> data =
            jsonDecode(response.body) as Map<String, dynamic>;
        data.forEach((key, value) {
          dataUser.add(UserModel.fromJson(data));
        });
        _sharedStorage.addUserId(dataUser.first.user.id);
        print(dataUser.first.user.id);

        setState(() {
          isLogin = true;
          checkLogin();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Email atau Password salah'),
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red[400],
            padding: EdgeInsets.only(top: 25, bottom: 25, left: 20),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        );
      }
      ;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
    print('Init Login');
  }

  void checkLogin() async {
    var isUser = await _sharedStorage.isUser();
    print("Check login");
    print(isUser);
    if (isUser) {
      setState(() {
        isLogin = true;
      });
    } else {
      isLogin = isUser;
    }
  }

  // Map<String, dynamic> data =
  // Map<String, dynamic>.from(json.decode(response.body));
  // loginResponse.add(LoginResponseModel)

  @override
  Widget build(BuildContext context) {
    if (isLogin == false) {
      return Scaffold(
        backgroundColor: Color(0xFF131311),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 30, right: 30),
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  radius: 90,
                  backgroundImage: NetworkImage(
                    '$apiUrl/image/public/images/barbermaterev2.png',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: emailC,
                autocorrect: false,
                // agar tipenya email
                keyboardType: TextInputType.emailAddress,
                //ini agar saat user menginputkan teks akan muncul tombol next di keyboard, dan akan lanjut mengisi form bawahnya
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

                  // border:
                  // OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(50),
                  // ),
                  // perbedaan prefix dgn prefixIcon, kalo prefix itu buat icon manual dari awal, kalo prefixIcon sudah otomatis mengikuti layoutnya
                  prefixIcon: Icon(Icons.email, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: passC,
                autocorrect: false,
                // ini agar password menjadi bintang-bintang
                obscureText: hiddenPassword,
                textInputAction: TextInputAction.done,
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
                  prefixIcon: Icon(
                    Icons.key,
                    color: Colors.grey,
                  ),
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
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  login();
                  print(
                    "Login dengan email: (${emailC.text}) dan password: (${passC.text})",
                  );
                },
                child: Text(
                  "Masuk",
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
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Pengguna baru? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    child: new Text(
                      "Buat Akun",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return HomePage();
    }
  }
}
