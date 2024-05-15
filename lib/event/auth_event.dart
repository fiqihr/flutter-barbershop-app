import 'package:equatable/equatable.dart';

// event = saat aplikasi pertama kali dijalankan
abstract class AuthEvent extends Equatable{
  @override
  List<Object> get props => [];
}

// saat apk pertama kalo dijalankan
class AppStarted extends AuthEvent{}

// untuk mengecek di local storagenya, punya token atau tidak
class AuthCheck extends AuthEvent{}

// mengambil data ketika sudah mempunyai token
class GetDataWithToken extends AuthEvent{
  final String token;
  GetDataWithToken({required this.token});

  @override
  List<Object> get props => [token];
}

// saat logout (menghapus tokennya)
class LoggedOut extends AuthEvent{}

// login proses
class LoginProcess extends AuthEvent{
  final String email;
  final String password;

  LoginProcess({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email,password];
}


