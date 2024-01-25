// ignore_for_file: file_names

import 'package:baby/models/parent.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class ParentProvider extends ChangeNotifier {
  Parent? _parent;

  Parent? get parent => _parent;

  // Hàm để thiết lập thông tin Parent
  void setParent(Parent parent) {
    _parent = parent;
    notifyListeners();
  }
}
