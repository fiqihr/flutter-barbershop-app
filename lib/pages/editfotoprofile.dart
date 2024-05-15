import 'package:flutter/material.dart';

class EditFotoProfile extends StatefulWidget {
  const EditFotoProfile({super.key});

  @override
  State<EditFotoProfile> createState() => _EditFotoProfileState();
}

class _EditFotoProfileState extends State<EditFotoProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d1d1d),
      appBar: AppBar(
        title: Text("Edit Profil"),
        centerTitle: true,
        backgroundColor: Color(0xFF131311),
      ),
    );
  }
}
