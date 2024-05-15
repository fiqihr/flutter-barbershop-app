import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/dataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  Future loginUser(String _email, String _password) async {
    String baseUrl = "http://10.113.66.150/api/v1/login";

    try {
      var response = await http.post(
        Uri.parse(baseUrl),
        body: {
          'email': _email,
          'password': _password,
        },
      );
      var jsonResponse = json.decode(response.body);
      return LoginAuth.fromJson(jsonResponse);
    } catch (e) {
      return e;
    }
  }

  Future userLogout(String token) async {
    String baseUrl = "http://10.113.66.150/api/v1/logout";
    try {
      var response = await http.post(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      var resbody = json.decode(response.body);
      return Logout.fromJson(resbody);
    } catch (e) {
      return e;
    }
  }

  Future getData(String token) async {
    String baseUrl = "http://10.113.66.150/api/v1/logout";

    try {
      var response = await http.get(Uri.parse(baseUrl), headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      var body = json.decode(response.body);
      return User.fromJson(body);
    } catch (e) {
      return e;
    }
  }

  Future hasToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    final token = local.getString("token_sanctum") ?? null;
    if (token != null) return token;
    return null;
  }

  Future setLocalToken(String token) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    local.setString("token_sanctum", token);
  }

  // coba jadi atau tidak pas logout
  Future unsetLocalToken() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences local = await _prefs;
    var value = null;
    local.setString("token_sanctum", value);
  }
}
