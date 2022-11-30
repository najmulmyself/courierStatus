// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:courier_status/Model/shipment_data_model.dart';
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
      var data = jsonDecode(response.body);

      datares = UpdateLotModel.fromJson(data);
    } else {
      print("Error");
    }
    return datares;
  }

  Future<UpdateStatus> updateStatus(id, refCode) async {
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

      /// Wont work from here | need to fix
    } else {
      var message =
          jsonDecode(response.body)["errors"][0]["non_field_errors"]["message"];
      return UpdateStatus.withError(message.toString(), response.statusCode);
    }

    // else if (response.statusCode == 500 || response.statusCode == 501) {
    //   return ScaffoldMessenger(child: Text('Hello'));
    // } else {
    //   var message = jsonDecode(response.body)["errors"][0]["non_field_errors"];
    //   throw onFail(message);
    // }
  }

  //getShipment Data

  Future getShipmentData() async {
    final token = await GetToken().getToken();
    final url = Uri.parse(baseUrl + "shipments/");
    final response = await http.get(url, headers: {
      "Authorization": "Bearer $token",
    });
    if (response.statusCode == 200) {
      print("Shipment Data Happend");
      return ShipmentData.fromJson(jsonDecode(response.body));
    } else {
      print("Error");
    }
  }
}
