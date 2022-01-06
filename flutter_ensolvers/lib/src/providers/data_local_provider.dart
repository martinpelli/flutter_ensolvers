import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

class _DataLocalProvider {
  List<dynamic> _dataObjects = [];
  _DataLocalProvider() {}

  Future<List<dynamic>> loadData() async {
    final response = await rootBundle.loadString('data/folders.json');
    Map dataMap = json.decode(response);
    _dataObjects = dataMap['folders'];
    return _dataObjects;
  }
}

final dataLocalProvider = _DataLocalProvider();
