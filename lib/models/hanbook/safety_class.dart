import 'dart:convert';

Safety safetyFromJson(String str) => Safety.fromJson(json.decode(str));

String safetyToJson(Safety data) => json.encode(data.toJson());

class Safety {
  final String name;
  final String title;
  final List<SafetyDatum> safetyData;

  Safety({
    required this.name,
    required this.title,
    required this.safetyData,
  });

  factory Safety.fromJson(Map<String, dynamic> json) => Safety(
        name: json["name"],
        title: json["title"],
        safetyData: List<SafetyDatum>.from(
            json["safetyData"].map((x) => SafetyDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "safetyData": List<dynamic>.from(safetyData.map((x) => x.toJson())),
      };
}

class SafetyDatum {
  final int id;
  final String name;
  final List<Datum> data;

  SafetyDatum({
    required this.id,
    required this.name,
    required this.data,
  });

  factory SafetyDatum.fromJson(Map<String, dynamic> json) => SafetyDatum(
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
  final int contentId;
  final String contentName;
  final String content;
  final String? image;

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
