import 'dart:convert';

Diseases diseasesFromJson(String str) => Diseases.fromJson(json.decode(str));

String diseasesToJson(Diseases data) => json.encode(data.toJson());

class Diseases {
  final String name;
  final String title;
  final List<DiseasesDatum> diseasesData;

  Diseases({
    required this.name,
    required this.title,
    required this.diseasesData,
  });

  factory Diseases.fromJson(Map<String, dynamic> json) => Diseases(
        name: json["name"],
        title: json["title"],
        diseasesData: List<DiseasesDatum>.from(
            json["diseasesData"].map((x) => DiseasesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "diseasesData": List<dynamic>.from(diseasesData.map((x) => x.toJson())),
      };
}

class DiseasesDatum {
  final int id;
  final String name;
  final List<Datum> data;

  DiseasesDatum({
    required this.id,
    required this.name,
    required this.data,
  });

  factory DiseasesDatum.fromJson(Map<String, dynamic> json) => DiseasesDatum(
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
