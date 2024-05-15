import 'package:flutter/material.dart';

class helpCenter extends StatelessWidget {
  const helpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    var styleone = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    var styletwo = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return Scaffold(
      backgroundColor: Color(0xFF1d1d1d),
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Pusat Bantuan",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF131311),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'Pusat Bantuan BarberMate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '\nSelamat datang di Help & Center BarberMate! Temukan jawaban cepat untuk pertanyaan umum Anda atau hubungi tim dukungan kami.',
            style: styletwo,
          ),
          Text(
            '\nPertanyaan Umum (FAQ)',
            style: styleone,
          ),
          Text(
            '\n1. Bagaimana cara melakukan booking layanan?',
            style: styletwo,
          ),
          Text(
            'Untuk melakukan booking, buka aplikasi dan pilih halaman menu booking. Pilih jenis layanan, barberman,tanggal dan waktu yang tersedia, lalu konfirmasi booking Anda.',
            style: styletwo,
          ),
          Text(
            '\n2. Bagaimana metode pembayaran yang tersedia?',
            style: styletwo,
          ),
          Text(
            'Saat ini, kami hanya menerima pembayaran tunai di tempat setelah layanan selesai.',
            style: styletwo,
          ),
          Text(
            '\n3. Bagaimana cara mengubah informasi profile?',
            style: styletwo,
          ),
          Text(
            'Anda dapat mengubah informasi profil anda pada menu edit profile, kemudian anda juga bisa mengedit foto profil anda pada menu edit foto profile',
            style: styletwo,
          ),
          Text(
            '\nPusat Bantuan',
            style: styleone,
          ),
          Text(
            'Temukan panduan langkah-demi-langkah dan solusi untuk masalah umum.',
            style: styletwo,
          ),
          Text(
            '\nHubungi Kami',
            style: styleone,
          ),
          Text(
            'Butuh bantuan lebih lanjut? Email kami di support@barbermate.com untuk petunjuk yang lebih jelas.',
            style: styletwo,
          ),
          Text(
            '\nTerima kasih telah memilih BarberMate!',
            style: styletwo,
          ),
        ],
      ),
    );
  }
}
