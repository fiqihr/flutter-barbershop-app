import 'dart:convert';
// import 'dart:js';
import 'package:barbershop/components/Url.dart';
import 'package:barbershop/pages/app_version.dart';
import 'package:barbershop/pages/editprofile.dart';
import 'package:barbershop/pages/help_center.dart';
import 'package:barbershop/pages/terms_condition.dart';
import 'package:barbershop/pages/privacy_policy.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import '../components/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'login.dart';
import 'editprofile.dart';
import 'updatefotoprofile.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // const Profile({super.key});
  bool isLogin = true;
  bool isLoading = false;

  final SharedStorage _sharedStorage = SharedStorage();

  Future<Map<String, dynamic>> user() async {
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

  Future logout() async {
    print('logout');
    try {
      _sharedStorage.deleteId();
      setState(() {
        Navigator.of(this.context)
            .pushNamedAndRemoveUntil('/', (route) => false);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF131311),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF131311),
      ),
      body: FutureBuilder(
        future: user(),
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
            print(snapshot.data?["name"]);
            print(snapshot.data?["foto"]);
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: ListView(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              alignment: Alignment.topCenter,
                              child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(
                                        '$apiUrl/image/public/images/foto_user/${snapshot.data?["foto"]}'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: IconButton(
                                        onPressed: () {
                                          var dataFoto =
                                              "${snapshot.data?['foto']}";
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateFotoProfile(),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.add_a_photo),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                            "${snapshot.data?['name']}",
                                            style: TextStyle(
                                                fontSize: 30,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "${snapshot.data?['email']}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              var dataName =
                                                  "${snapshot.data?['name']}";
                                              var dataEmail =
                                                  "${snapshot.data?['email']}";
                                              var dataTelepon =
                                                  "${snapshot.data?['telepon']}";
                                              var dataAlamat =
                                                  "${snapshot.data?['alamat']}";
                                              var dataJenisKelamin =
                                                  "${snapshot.data?['jenis_kelamin']}";
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditProfile(
                                                    dataName: dataName,
                                                    dataEmail: dataEmail,
                                                    dataTelepon: dataTelepon,
                                                    dataAlamat: dataAlamat,
                                                    dataJenisKelamin:
                                                        dataJenisKelamin,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, right: 20),
                                              child: Text(
                                                "Edit Profile",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15),
                                                ),
                                              ),
                                              primary: Color(0xFF96652B),
                                              // primary: Color(0xFF96652B),
                                              onPrimary: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Card(
                        color: Color(0xFF1d1d1d),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SizedBox(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => helpCenter(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.help,
                                                color: Colors.white,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '  Pusat Bantuan',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Divider(),
                                  SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              termsCondition(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.book_online_rounded,
                                                color: Colors.white,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '  Syarat & Ketentuan Pengguna',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Divider(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => privacyPolicy(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.privacy_tip,
                                                color: Colors.white,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '  Kebijakan Privasi',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Divider(),
                                  SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => appVersion(),
                                        ),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.phone_android_rounded,
                                                color: Colors.white,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '  Versi Aplikasi',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Color(0xFF1d1d1d),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SizedBox(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          backgroundColor: Color(0xFF1d1d1d),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          content: SizedBox(
                                            height: 100,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Apakah yakin keluar?",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Flexible(
                                                child: Text(
                                                  "Tidak",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFF96652B),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () async {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                await Future.delayed(
                                                  const Duration(seconds: 3),
                                                );
                                                setState(() {
                                                  logout();
                                                  isLoading = false;
                                                });
                                                // Navigator.of(context).push(
                                                //   MaterialPageRoute(
                                                //     builder: (context) => loginPage(),
                                                //   ),
                                                // );
                                              },
                                              child: Flexible(
                                                child: Text(
                                                  "Ya",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Color(0xFF96652B),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    // () async {
                                    //   setState(() {
                                    //     isLoading = true;
                                    //   });
                                    //   await Future.delayed(
                                    //     const Duration(seconds: 3),
                                    //   );
                                    //   setState(() {
                                    //     logout();
                                    //     isLoading = false;
                                    //   });
                                    // },
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => helpCenter(),
                                    //   ),
                                    // );

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.logout,
                                                color: Colors.white,
                                              ),
                                              Flexible(
                                                child: Text(
                                                  '  Logout',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // disini letak info profilnya
                      // Center(
                      //   child: Card(
                      //     color: Color(0xFF1d1d1d),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(30.0),
                      //     ),
                      //     margin: EdgeInsets.only(top: 25),
                      //     child: Padding(
                      //       padding: EdgeInsets.all(30),
                      // child: Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Icon(
                      //           Icons.help,
                      //           color: Color(0xFF96652B),
                      //         ),
                      //         SizedBox(width: 30),
                      //         Text(
                      //           "Help & Center",
                      //           // "${snapshot.data?['email']}",
                      //           style: TextStyle(
                      //               fontSize: 13, color: Colors.white),
                      //         ),
                      //       ],
                      //     ),
                      //     Divider(
                      //       color: Colors.black,
                      //       height: 50,
                      //     ),
                      //     Row(
                      //       children: [
                      //         ImageIcon(
                      //           AssetImage("icons/telephone.png"),
                      //           size: 30,
                      //           color: Color(0xFF96652B),
                      //         ),
                      //         SizedBox(width: 30),
                      //         Text(
                      //           "${snapshot.data?['telepon']}",
                      //           style: TextStyle(
                      //               fontSize: 13, color: Colors.white),
                      //         ),
                      //       ],
                      //     ),
                      //     Divider(
                      //       color: Colors.black,
                      //       height: 50,
                      //     ),
                      //     Row(
                      //       children: [
                      //         ImageIcon(
                      //           AssetImage("icons/gender.png"),
                      //           size: 30,
                      //           color: Color(0xFF96652B),
                      //         ),
                      //         SizedBox(width: 30),
                      //         Text(
                      //           "${snapshot.data?['jenis_kelamin']}",
                      //           style: TextStyle(
                      //               fontSize: 13, color: Colors.white),
                      //         ),
                      //       ],
                      //     ),
                      //     Divider(
                      //       color: Colors.black,
                      //       height: 50,
                      //     ),
                      //     Row(
                      //       children: [
                      //         ImageIcon(
                      //           AssetImage("icons/home-address.png"),
                      //           size: 30,
                      //           color: Color(0xFF96652B),
                      //         ),
                      //         SizedBox(width: 30),
                      //         Text(
                      //           "${snapshot.data?['alamat']}",
                      //           style: TextStyle(
                      //               fontSize: 13, color: Colors.white),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ],
            );

            // Center(
            //   child: Text(
            //     "${snapshot.data?['name']}",
            //   ),
            // );
          }
        },
      ),
    );
  }
}
