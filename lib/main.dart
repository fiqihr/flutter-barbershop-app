import 'package:flutter/material.dart';
import './widgets/mainmenu.dart';
import './pages/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import './pages/login.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: Login(),
    );
  }
}
