// To parse this JSON data, do
//
//     final notFound = notFoundFromJson(jsonString);

import 'dart:convert';

NotFound notFoundFromJson(String str) => NotFound.fromJson(json.decode(str));

String notFoundToJson(NotFound data) => json.encode(data.toJson());

class NotFound {
  NotFound({
    this.url,
    this.dateTime,
    this.method,
    this.statusCode,
    this.errors,
  });

  String? url;
  DateTime? dateTime;
  String? method;
  int? statusCode;
  List<Error>? errors;

  factory NotFound.fromJson(Map<String, dynamic> json) => NotFound(
        url: json["url"],
        dateTime: DateTime.parse(json["date-time"]),
        method: json["method"],
        statusCode: json["status_code"],
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "date-time": dateTime!.toIso8601String(),
        "method": method,
        "status_code": statusCode,
        "errors": List<dynamic>.from(errors!.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    this.api,
    this.fieldErrors,
    this.nonFieldErrors,
  });

  String? api;
  FieldErrors? fieldErrors;
  NonFieldErrors? nonFieldErrors;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        api: json["api"],
        fieldErrors: FieldErrors.fromJson(json["field_errors"]),
        nonFieldErrors: NonFieldErrors.fromJson(json["non_field_errors"]),
      );

  Map<String, dynamic> toJson() => {
        "api": api,
        "field_errors": fieldErrors!.toJson(),
        "non_field_errors": nonFieldErrors!.toJson(),
      };
}

class FieldErrors {
  FieldErrors();

  factory FieldErrors.fromJson(Map<String, dynamic> json) => FieldErrors();

  Map<String, dynamic> toJson() => {};
}

class NonFieldErrors {
  NonFieldErrors({
    this.message,
  });

  String? message;

  factory NonFieldErrors.fromJson(Map<String, dynamic> json) => NonFieldErrors(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
