import 'dart:convert';

WonderWeeks wonderWeeksFromJson(String str) =>
    WonderWeeks.fromJson(json.decode(str));

String wonderWeeksToJson(WonderWeeks data) => json.encode(data.toJson());

class WonderWeeks {
  String name;
  String title;
  List<WonderWeeksDatum> wonderWeeksData;

  WonderWeeks({
    required this.name,
    required this.title,
    required this.wonderWeeksData,
  });

  factory WonderWeeks.fromJson(Map<String, dynamic> json) => WonderWeeks(
        name: json["name"],
        title: json["title"],
        wonderWeeksData: List<WonderWeeksDatum>.from(
            json["wonderWeeksData"].map((x) => WonderWeeksDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "wonderWeeksData":
            List<dynamic>.from(wonderWeeksData.map((x) => x.toJson())),
      };
}

class WonderWeeksDatum {
  int id;
  String name;
  List<Datum> data;

  WonderWeeksDatum({
    required this.id,
    required this.name,
    required this.data,
  });

  factory WonderWeeksDatum.fromJson(Map<String, dynamic> json) =>
      WonderWeeksDatum(
        id: json["id"],
        name: json["name"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int contentId;
  String contentName;
  String content;
  String? image;

  Datum({
    required this.contentId,
    required this.contentName,
    required this.content,
    this.image,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        contentId: json["contentId"],
        contentName: json["contentName"],
        content: json["content"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "contentId": contentId,
        "contentName": contentName,
        "content": content,
        "image": image,
      };
}
