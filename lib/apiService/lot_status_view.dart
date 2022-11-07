// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:courier_status/apiService/setToken.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = "http://13.214.104.111:1337/api/";

  Future getUpdateStatusView() async {
    final token = await GetToken().getToken();
    final url = Uri.parse(baseUrl + "update-lot-status/");
    print(token);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    print("Get Update Status View Happend${response.statusCode} ");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data['data'][0]['id']);

      return data['data'];
    } else {
      print("Error");
    }
  }
}
