// To parse this JSON data, do
//
//     final updateStatus = updateStatusFromJson(jsonString);

import 'dart:convert';

UpdateStatus updateStatusFromJson(String str) => UpdateStatus.fromJson(json.decode(str));

String updateStatusToJson(UpdateStatus data) => json.encode(data.toJson());

class UpdateStatus {
    UpdateStatus({
        this.url,
        this.dateTime,
        this.method,
        this.data,
    });

    List<String>? url;
    DateTime? dateTime;
    String? method;
    Data? data;

    factory UpdateStatus.fromJson(Map<String, dynamic> json) => UpdateStatus(
        url: List<String>.from(json["url"].map((x) => x)),
        dateTime: DateTime.parse(json["date-time"]),
        method: json["method"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "url": List<dynamic>.from(url!.map((x) => x)),
        "date-time": dateTime!.toIso8601String(),
        "method": method,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.booking,
        this.locationStatus,
        this.branch,
        this.reference,
    });

    int? id;
    String? booking;
    String? locationStatus;
    String? branch;
    String? reference;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        booking: json["booking"],
        locationStatus: json["location_status"],
        branch: json["branch"],
        reference: json["reference"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "booking": booking,
        "location_status": locationStatus,
        "branch": branch,
        "reference": reference,
    };
}
