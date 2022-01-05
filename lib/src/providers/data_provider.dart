import 'package:flutter/services.dart' show rootBundle;

import 'dart:convert';

class _DataProvider {
  List<dynamic> _dataObjects = [];
  _DataProvider() {}

  Future<List<dynamic>> loadData(String dataFileName) async {
    final response = await rootBundle.loadString('data/${dataFileName}.json');
    Map dataMap = json.decode(response);
    _dataObjects = dataMap[dataFileName];
    return _dataObjects;
  }
}

final dataProvider = _DataProvider();
