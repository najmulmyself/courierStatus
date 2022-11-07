import 'package:shared_preferences/shared_preferences.dart';

class SetToken {

  Future<void> setToken(String newToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', newToken);
  }
}

class GetToken{
  Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token!;
  }
}
