import 'package:equatable/equatable.dart';

// state adl suatu data yg mengidintifikasikan sebuah status dari aplikasi yg sedang berjalan, state akan memberitahukan kondisi apk sedang apa
// state mrpkn suatu yg menjadi trigger utk merebuild ulang UI apk kita, shg menjadi interaktif reaktif
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInit extends AuthState{}

class AuthLoading extends AuthState{}

class AuthHasToken extends AuthState{
  final String token;
  AuthHasToken({required this.token});

  @override
  List<Object> get props => [token];
}

class AuthFailed extends AuthState{}

class AuthData extends AuthState{
  final String name;
  final String email;

  AuthData({required this.email, required this.name});
  @override
  List<Object> get props => [name, email];
}

class LoginInit extends AuthState{}

class LoginSuccess extends AuthState{}

class LoginFailed extends AuthState{
  final String error;
  LoginFailed({required this.error});

  @override
  List<Object> get props => [error];
}

