import 'dart:convert';
import 'package:http/http.dart' as http;

class _DataDBProvider {
  List<dynamic> _dataObjects = [];
  _DataLocalProvider() {}
  Future<List<dynamic>> loadData() async {
    final http.Response response =
        await http.get(Uri.parse('http://localhost:4000/api/folders'));
    Map dataMap = json.decode(response.body);
    _dataObjects = dataMap['folders'];
    return _dataObjects;
  }
}

final dataDBProvider = _DataDBProvider();
