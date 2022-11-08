class TestData {
  List<Data>? data;

  TestData({this.data});

  TestData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  Country? country;
  String? name;
  String? key;

  Data({this.id, this.country, this.name, this.key});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    name = json['name'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    data['name'] = this.name;
    data['key'] = this.key;
    return data;
  }
}

class Country {
  int? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
