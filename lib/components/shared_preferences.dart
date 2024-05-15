import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  addUserId(int idUSer) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('idUser', idUSer);
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idUser = prefs.getInt('idUser');
    return idUser;
  }

  isUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool CheckValue = prefs.containsKey('idUser');
    return CheckValue;
  }

  deleteId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("idUser");
  }
}
