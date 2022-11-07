// To parse this JSON data, do
//
//     final updateLotModel = updateLotModelFromJson(jsonString);

import 'dart:convert';

UpdateLotModel updateLotModelFromJson(String str) => UpdateLotModel.fromJson(json.decode(str));

String updateLotModelToJson(UpdateLotModel data) => json.encode(data.toJson());

class UpdateLotModel {
    UpdateLotModel({
        this.url,
        this.dateTime,
        this.method,
        this.page,
        this.data,
    });

    String ? url;
    DateTime ? dateTime;
    String ? method;
    Page? page;
    List<Datum>? data;

    factory UpdateLotModel.fromJson(Map<String, dynamic> json) => UpdateLotModel(
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
        this.country,
        this.name,
        this.key,
    });

    int? id;
    Country? country;
    String? name;
    String? key;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        country: Country.fromJson(json["country"]),
        name: json["name"],
        key: json["key"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "country": country!.toJson(),
        "name": name,
        "key": key,
    };
}

class Country {
    Country({
        this.id,
        this.name,
    });

    int ?id;
    String? name;

    factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Page {
    Page({
        this.previousPage,
        this.page,
        this.nextPage,
        this.total,
        this.limit,
    });

    dynamic previousPage;
    int? page;
    dynamic nextPage;
    int? total;
    int? limit;

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
