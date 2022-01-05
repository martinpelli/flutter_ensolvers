import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

class _DataProvider {
  List<dynamic> _dataObjects = [];
  _DataProvider() {}

  Future<List<dynamic>> loadData() async {
    final response = await rootBundle.loadString('data/folders.json');
    Map dataMap = json.decode(response);
    _dataObjects = dataMap['folders'];
    return _dataObjects;
  }
}

final dataProvider = _DataProvider();
