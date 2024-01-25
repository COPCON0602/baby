// ignore_for_file: constant_identifier_names

import 'package:flutter/widgets.dart';

class MyFlutterApp {
  MyFlutterApp._();

  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData user =
      IconData(0xf007, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData chart_line =
      IconData(0xf201, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData calendar_check =
      IconData(0xf274, fontFamily: _kFontFam, fontPackage: _kFontPkg);
  static const IconData book_reader =
      IconData(0xf5da, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}
