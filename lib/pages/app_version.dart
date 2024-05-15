import 'package:flutter/material.dart';
// import 'package:project_app/resources/color.dart';

class appVersion extends StatelessWidget {
  const appVersion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1d1d1d),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF131311),
        title: Text(
          'Versi Aplikasi',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                Icon(
                  Icons.android_rounded,
                  size: 120,
                  color: Color(0xFF96652B),
                ),
                Text(
                  'Versi aplikasi saat ini adalah',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'V 0.2.6',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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
