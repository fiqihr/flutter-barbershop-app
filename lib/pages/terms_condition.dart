import 'package:flutter/material.dart';

class termsCondition extends StatelessWidget {
  const termsCondition({super.key});

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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF131311),
        title: Text(
          'Syarat & Ketentuan',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'Syarat & Ketentuan Penggunaan BarberMate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '\nPendaftaran dan Akun:',
            style: styleone,
          ),
          Text(
            'Dengan mendaftar, Anda setuju untuk memberikan informasi yang akurat dan menjaga keamanan akun BarberMate Anda.',
            style: styletwo,
          ),
          Text(
            '\nPenggunaan Aplikasi:',
            style: styleone,
          ),
          Text(
            'Aplikasi BarberMate hanya boleh digunakan untuk tujuan yang sah dan sesuai dengan ketentuan hukum yang berlaku.',
            style: styletwo,
          ),
          Text(
            '\nKeamanan Informasi:',
            style: styleone,
          ),
          Text(
            'Kami berkomitmen menjaga keamanan data Anda. Namun, pengguna juga bertanggung jawab untuk melindungi informasi akun mereka.',
            style: styletwo,
          ),
          Text(
            '\nPembayaran:',
            style: styleone,
          ),
          Text(
            'Pembayaran harus dilakukan sesuai dengan tagihan yang dihasilkan oleh BarberMate. Kesalahan pembayaran harus segera dilaporkan.',
            style: styletwo,
          ),
          Text(
            '\nPembaruan Aplikasi:',
            style: styleone,
          ),
          Text(
            'Pastikan untuk selalu memperbarui aplikasi BouquetBills agar dapat mengakses fitur terbaru dan perbaikan keamanan.',
            style: styletwo,
          ),
          Text(
            '\nPerubahan Syarat dan Ketentuan:',
            style: styleone,
          ),
          Text(
            'BarberMate berhak untuk mengubah syarat dan ketentuan ini. Pemberitahuan akan diberikan melalui aplikasi.',
            style: styletwo,
          ),
          Text(
            '\nDengan menggunakan BarberMate, Anda menyetujui dan tunduk pada semua syarat dan ketentuan ini. Harap baca dengan seksama sebelum menggunakan layanan kami.',
            style: styletwo,
          ),
        ],
      ),
    );
  }
}
