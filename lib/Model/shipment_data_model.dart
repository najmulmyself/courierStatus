// To parse this JSON data, do
//
//     final shipmentData = shipmentDataFromJson(jsonString);

import 'dart:convert';

ShipmentData shipmentDataFromJson(String str) => ShipmentData.fromJson(json.decode(str));

String shipmentDataToJson(ShipmentData data) => json.encode(data.toJson());

class ShipmentData {
    ShipmentData({
        this.url,
        this.dateTime,
        this.method,
        this.page,
        this.data,
    });

    String? url;
    DateTime? dateTime;
    String? method;
    Page? page;
    List<Datum>? data;

    factory ShipmentData.fromJson(Map<String, dynamic> json) => ShipmentData(
        url: json["url"],
        dateTime: DateTime.parse(json["date-time"]),
        method: json["method"],
        page: Page.fromJson(json["page"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "date-time": dateTime!.toIso8601String(),
        "method": method,
        "page": page!.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.createdAt,
        this.updatedAt,
        this.isActive,
        this.startDate,
        this.endDate,
        this.freightCategory,
        this.shipmentNumber,
        this.createdBy,
        this.updatedBy,
        this.toCountry,
        this.locationStatus,
    });

    int ?id;
    DateTime? createdAt;
    DateTime? updatedAt;
    bool? isActive;
    DateTime? startDate;
    DateTime? endDate;
    FreightCategory? freightCategory;
    String? shipmentNumber;
    int? createdBy;
    int? updatedBy;
    int? toCountry;
    int? locationStatus;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        isActive: json["is_active"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        freightCategory: freightCategoryValues.map![json["freight_category"]],
        shipmentNumber: json["shipment_number"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        toCountry: json["to_country"],
        locationStatus: json["location_status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "is_active": isActive,
        "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "freight_category": freightCategoryValues.reverse[freightCategory],
        "shipment_number": shipmentNumber,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "to_country": toCountry,
        "location_status": locationStatus,
    };
}

enum FreightCategory { SEA_FREIGHT, WEAREHOUSE, AIR_FREIGHT }

final freightCategoryValues = EnumValues({
    "AIR_FREIGHT": FreightCategory.AIR_FREIGHT,
    "SEA_FREIGHT": FreightCategory.SEA_FREIGHT,
    "WEAREHOUSE": FreightCategory.WEAREHOUSE
});

class Page {
    Page({
        this.previousPage,
        this.page,
        this.nextPage,
        this.total,
        this.limit,
    });

    dynamic? previousPage;
    int ?page;
    int? nextPage;
    int? total;
    int ?limit;

    factory Page.fromJson(Map<String, dynamic> json) => Page(
        previousPage: json["previous_page"],
        page: json["page"],
        nextPage: json["next_page"],
        total: json["total"],
        limit: json["limit"],
    );

    Map<String, dynamic> toJson() => {
        "previous_page": previousPage,
        "page": page,
        "next_page": nextPage,
        "total": total,
        "limit": limit,
    };
}

class EnumValues<T> {
    Map<String, T> ? map;
    Map<T, String>? reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map!.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap!;
    }
}
