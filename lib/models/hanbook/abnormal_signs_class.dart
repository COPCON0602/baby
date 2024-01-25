import 'dart:convert';

AbnormalSigns abnormalSignsFromJson(String str) =>
    AbnormalSigns.fromJson(json.decode(str));

String abnormalSignsToJson(AbnormalSigns data) => json.encode(data.toJson());

class AbnormalSigns {
  String name;
  String title;
  List<AbnormalSignsDatum> abnormalSignsData;

  AbnormalSigns({
    required this.name,
    required this.title,
    required this.abnormalSignsData,
  });

  factory AbnormalSigns.fromJson(Map<String, dynamic> json) => AbnormalSigns(
        name: json["name"],
        title: json["title"],
        abnormalSignsData: List<AbnormalSignsDatum>.from(
            json["abnormalSignsData"]
                .map((x) => AbnormalSignsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "abnormalSignsData":
            List<dynamic>.from(abnormalSignsData.map((x) => x.toJson())),
      };
}

class AbnormalSignsDatum {
  int id;
  String name;
  List<Datum> data;

  AbnormalSignsDatum({
    required this.id,
    required this.name,
    required this.data,
  });

  factory AbnormalSignsDatum.fromJson(Map<String, dynamic> json) =>
      AbnormalSignsDatum(
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
