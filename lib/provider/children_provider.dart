import 'package:baby/models/child.dart';
import 'package:flutter/foundation.dart';

class ChildrenProvider extends ChangeNotifier {
  final List<Child> _children = [];

  List<Child> get children => _children;

  void addChild(Child child) {
    _children.add(child);
    notifyListeners();
  }

  void editChild(int index, Child child) {
    _children[index] = child;
    notifyListeners();
  }

  void removeChild(int index) {
    _children.removeAt(index);
    notifyListeners();
  }
}
