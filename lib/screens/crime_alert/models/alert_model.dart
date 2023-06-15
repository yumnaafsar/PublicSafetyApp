// To parse this JSON data, do
//
//     final alerts = alertsFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

Alerts alertsFromJson(String str) => Alerts.fromJson(json.decode(str));

String alertsToJson(Alerts data) => json.encode(data.toJson());

class Alerts {
  String city;
  String description;
  String district;
  String reporter;
  String time;
  String date;
  String title;
  String LocationComp;
  String image;

  Alerts({
    required this.city,
    required this.description,
    required this.district,
    required this.reporter,
    required this.time,
    required this.title,
    required this.date,
    required this.LocationComp,
    required this.image,
  });

  factory Alerts.fromJson(Map<String, dynamic> json) => Alerts(
    city: json["city"],
    description: json["description"],
    district: json["district"],
    reporter: json["reporter"],
    time: json["time"],
    title: json["title"],
    date: json["date"],
    LocationComp: json["LocationComp"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "description": description,
    "district": district,

    "reporter": reporter,
    "time": time,
    "title": title,
    "date":date,
    "LocationComp":LocationComp,
    "image": image,
  };
}
