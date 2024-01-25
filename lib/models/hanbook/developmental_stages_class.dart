import 'dart:convert';

DevelopmentalStages developmentalStagesFromJson(String str) =>
    DevelopmentalStages.fromJson(json.decode(str));

String developmentalStagesToJson(DevelopmentalStages data) =>
    json.encode(data.toJson());

class DevelopmentalStages {
  final String name;
  final String title;
  final List<DevelopmentalStagesDatum> developmentalStagesData;

  DevelopmentalStages({
    required this.name,
    required this.title,
    required this.developmentalStagesData,
  });

  factory DevelopmentalStages.fromJson(Map<String, dynamic> json) =>
      DevelopmentalStages(
        name: json["name"],
        title: json["title"],
        developmentalStagesData: List<DevelopmentalStagesDatum>.from(
            json["developmentalStagesData"]
                .map((x) => DevelopmentalStagesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "developmentalStagesData":
            List<dynamic>.from(developmentalStagesData.map((x) => x.toJson())),
      };
}

class DevelopmentalStagesDatum {
  final int id;
  final String name;
  final List<Datum> data;

  DevelopmentalStagesDatum({
    required this.id,
    required this.name,
    required this.data,
  });

  factory DevelopmentalStagesDatum.fromJson(Map<String, dynamic> json) =>
      DevelopmentalStagesDatum(
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
