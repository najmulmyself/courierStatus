// To parse this JSON data, do
//
//     final shipmentLotViewModel = shipmentLotViewModelFromJson(jsonString);

import 'dart:convert';

ShipmentLotViewModel shipmentLotViewModelFromJson(String str) => ShipmentLotViewModel.fromJson(json.decode(str));

String shipmentLotViewModelToJson(ShipmentLotViewModel data) => json.encode(data.toJson());

class ShipmentLotViewModel {
    ShipmentLotViewModel({
        this.url,
        this.dateTime,
        this.method,
        this.data,
    });

    List<String>? url;
    DateTime? dateTime;
    String ?method;
    Data ?data;

    factory ShipmentLotViewModel.fromJson(Map<String, dynamic> json) => ShipmentLotViewModel(
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
        this.toCountry,
        this.startDate,
        this.endDate,
        this.freightCategory,
        this.shipmentNumber,
        this.locationStatus,
        this.lots,
    });

    int ?id;
    String ?toCountry;
    DateTime? startDate;
    DateTime? endDate;
    String? freightCategory;
    String? shipmentNumber;
    String ?locationStatus;
    List<Lot> ?lots;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        toCountry: json["to_country"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        freightCategory: json["freight_category"],
        shipmentNumber: json["shipment_number"],
        locationStatus: json["location_status"],
        lots: List<Lot>.from(json["lots"].map((x) => Lot.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "to_country": toCountry,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "freight_category": freightCategory,
        "shipment_number": shipmentNumber,
        "location_status": locationStatus,
        "lots": List<dynamic>.from(lots!.map((x) => x.toJson())),
    };
}

class Lot {
    Lot({
        this.id,
        this.booking,
        this.locationStatus,
        this.branch,
        this.reference,
    });

    int ? id;
    String? booking;
    String? locationStatus;
    String? branch;
    String? reference;

    factory Lot.fromJson(Map<String, dynamic> json) => Lot(
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
