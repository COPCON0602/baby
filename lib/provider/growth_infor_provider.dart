import 'package:baby/models/child.dart';
import 'package:baby/models/growth/growth_info.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class GrowthInforProvider extends ChangeNotifier {
  final Map<Child, List<GrowthInforRecord>> _childRecords = {};

  Map<Child, List<GrowthInforRecord>> get childRecords => _childRecords;

  void addChildRecord(Child child, GrowthInforRecord record) {
    if (!_childRecords.containsKey(child)) {
      _childRecords[child] = [];
    }
    _childRecords[child]!.add(record);
    _childRecords[child]!
        .sort((a, b) => b.compareTo(a)); // Sắp xếp giảm dần (mới nhất lên đầu)
    notifyListeners();
  }

  void editChildRecord(Child child, int index, GrowthInforRecord record) {
    if (_childRecords.containsKey(child)) {
      _childRecords[child]![index] = record;
      _childRecords[child]!.sort(
          (a, b) => b.compareTo(a)); // Sắp xếp giảm dần (mới nhất lên đầu)
      notifyListeners();
    }
  }

  void removeChildRecord(Child child, int index) {
    if (_childRecords.containsKey(child)) {
      _childRecords[child]!.removeAt(index);
      notifyListeners();
    }
  }
}
