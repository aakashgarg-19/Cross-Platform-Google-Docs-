import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  void setToken(String token) async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    prefrences.setString("x-auth-token", token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefrences = await SharedPreferences.getInstance();
    String? token = prefrences.getString("x-auth-token");
    return token;
  }
}