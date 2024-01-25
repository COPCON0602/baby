import 'dart:convert';

MedicineAndVaccination medicineAndVaccinationFromJson(String str) =>
    MedicineAndVaccination.fromJson(json.decode(str));

String medicineAndVaccinationToJson(MedicineAndVaccination data) =>
    json.encode(data.toJson());

class MedicineAndVaccination {
  String name;
  String title;
  List<MedicineAndVaccinationDatum> medicineAndVaccinationData;

  MedicineAndVaccination({
    required this.name,
    required this.title,
    required this.medicineAndVaccinationData,
  });

  factory MedicineAndVaccination.fromJson(Map<String, dynamic> json) =>
      MedicineAndVaccination(
        name: json["name"],
        title: json["title"],
        medicineAndVaccinationData: List<MedicineAndVaccinationDatum>.from(
            json["medicineAndVaccinationData"]
                .map((x) => MedicineAndVaccinationDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "medicineAndVaccinationData": List<dynamic>.from(
            medicineAndVaccinationData.map((x) => x.toJson())),
      };
}

class MedicineAndVaccinationDatum {
  int id;
  String name;
  List<Datum> data;

  MedicineAndVaccinationDatum({
    required this.id,
    required this.name,
    required this.data,
  });

  factory MedicineAndVaccinationDatum.fromJson(Map<String, dynamic> json) =>
      MedicineAndVaccinationDatum(
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
