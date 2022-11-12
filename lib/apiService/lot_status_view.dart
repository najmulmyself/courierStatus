// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:courier_status/Model/not_found_model.dart';
import 'package:courier_status/Model/testData.dart';
import 'package:courier_status/Model/update_lot_model.dart';
import 'package:courier_status/Model/update_status_model.dart';
import 'package:courier_status/apiService/setToken.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  String baseUrl = "http://13.214.104.111:1337/api/";

  Future<UpdateLotModel?> getUpdateStatusView() async {
    final token = await GetToken().getToken();
    final url = Uri.parse(baseUrl + "update-lot-status/");
    print(token);
    final response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    print("Get Update Status View Happend${response.statusCode} ");
    UpdateLotModel? datares;
    if (response.statusCode == 200) {
      // print(data);
      // print(data['data'][0]['id']);
      // List<dynamic> json = jsonDecode(response.body)['data'];
      // return json.map((dynamic item) => Data.fromJson(item)).toList();
      var data = jsonDecode(response.body);
      // print(data['data']);
      // for (var element in data['data']) {
      //   datares.add(TestData.fromJson(element));
      //   print(element);
      // }
      // print(datares.data![0].country!.name);
      datares = UpdateLotModel.fromJson(data);
      // print(datares.data![0].name);
    } else {
      print("Error");
    }
    return datares;
  }

  Future updateStatus(id, refCode, Function onFail) async {
    final token = await GetToken().getToken();
    print("id is : ${id}");
    print("ref is : ${refCode}");
    final url = Uri.parse(
        baseUrl + "update-lot-status/" + id.toString() + "/" + refCode + "/");
    print(url);

    final response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      print("Update Status Happend");

      return UpdateStatus.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 500 || response.statusCode == 501) {
      return ScaffoldMessenger(child: Text('Hello'));
    } else {
      // return NotFound.fromJson(jsonDecode(response.body));
      // throw NotFound.fromJson(jsonDecode(response.body));
      var message = jsonDecode(response.body)["errors"][0]["non_field_errors"];
      throw onFail(message);
    }
  }
}
