import 'package:baby/models/child.dart';

class Parent {
  late String email;
  late String? phone;
  late String? name;
  late String? dob;
  late bool? gender;
  late String? address;
  late String? avatar;
  late List<Child>? children;

  Parent({
    required this.email,
    this.phone,
    this.name,
    this.dob,
    this.gender = true,
    this.address,
    this.avatar,
    this.children,
  });
}
