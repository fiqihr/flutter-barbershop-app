import 'package:flutter/material.dart';

class privacyPolicy extends StatelessWidget {
  const privacyPolicy({super.key});

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
          'Kebijakan Privasi',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text(
            'Kebijakan Privasi BarberMate',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Terakhir diperbarui: 20 Maret 2024',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'BarberMate adalah aplikasi yang bertujuan menyediakan layanan pemesanan untuk layanan perawatan pria di Manson Barbershop. Kebijakan Privasi ini menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi pribadi Anda saat Anda menggunakan aplikasi kami.',
            style: styletwo,
          ),
          Text(
            '\n1. Informasi yang Kami Kumpulkan',
            style: styleone,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Kami dapat mengumpulkan informasi pribadi yang Anda berikan saat: \n - Membuat akun pengguna di aplikasi.\n - Melakukan proses pemesanan layanan.\n - Mengirimkan pertanyaan atau umpan balik kepada kami.',
            style: styletwo,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Informasi yang mungkin kami kumpulkan meliputi: \n - Nama dan alamat email\n - Nomor telepon dan Jenis Kelamin.\n - Alamat rumah.',
            style: styletwo,
          ),
          Text(
            '\n2. Bagaimana Kami Melindungi Informasi Anda',
            style: styleone,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Kami mengambil langkah-langkah keamanan yang sesuai untuk melindungi informasi pribadi Anda dari akses, penggunaan, atau pengungkapan yang tidak sah. Ini termasuk penggunaan enkripsi data, kontrol akses yang ketat, dan prosedur keamanan lainnya.',
            style: styletwo,
          ),
          Text(
            '\n3. Berbagi Informasi dengan Pihak Ketiga',
            style: styleone,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Kami tidak akan menjual, menyewakan, atau menukar informasi pribadi Anda dengan pihak ketiga tanpa izin Anda, kecuali seperti yang dijelaskan dalam Kebijakan Privasi ini atau sesuai dengan hukum yang berlaku.',
            style: styletwo,
          ),
          Text(
            '\n4. Perubahan Kebijakan Privasi',
            style: styleone,
          ),
          Text(
            'Kami dapat memperbarui Kebijakan Privasi ini dari waktu ke waktu sesuai dengan perubahan dalam praktik kami atau persyaratan hukum yang berlaku. Versi yang diperbarui akan diumumkan dalam aplikasi atau melalui email yang terkait dengan akun Anda.',
            style: styletwo,
          ),
          Text(
            '\n5. Hubungi Kami',
            style: styleone,
          ),
          Text(
            'Jika Anda memiliki pertanyaan atau kekhawatiran tentang Kebijakan Privasi kami atau penggunaan informasi pribadi Anda, jangan ragu untuk menghubungi kami di alamat email support@barbermate.com.',
            style: styletwo,
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'Menandatangani',
            style: styletwo,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Tim BarberMate',
            style: styletwo,
          ),
        ],
      ),
    );
  }
}
