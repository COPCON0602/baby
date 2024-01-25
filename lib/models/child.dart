//child
import 'package:baby/models/growth/growth_info.dart';

class Child {
  final String name;
  final String? nicknName;
  final String dob;
  final bool gender;
  final String? avatar;
  late List<GrowthInforRecord>? records;

  Child(
      {required this.name,
      required this.dob,
      required this.gender,
      this.avatar,
      this.nicknName,
      this.records});
}
