import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ensolvers/src/DTOs/folder_dto.dart';
import 'package:http/http.dart' as http;

class _DataDBProvider {
  String apiAddress = 'http://localhost:4000/api/';

  Future<List<FolderDto>> loadData() async {
    Uri url = Uri.parse('${apiAddress}folders');
    List<dynamic> _dataObjects = [];
    final List<FolderDto> _foldersDTO = [];
    final http.Response _response = await http.get(url);
    Map dataMap = json.decode(_response.body);
    _dataObjects = dataMap['folders'];
    for (var folderObject in _dataObjects) {
      FolderDto _newFolderDto = FolderDto(
          folderObject['title'], folderObject['tasks'],
          key: Key(folderObject['_id']));
      _foldersDTO.add(_newFolderDto);
    }
    return _foldersDTO;
  }

  void addFolderToDB(FolderDto folderDto) async {
    Uri url = Uri.parse('${apiAddress}folders/create');
    var _body = json.encode({
      'title': '${folderDto.getFolderTitle()}',
      'tasks': '${folderDto.getTasks()}'
    });
    final http.Response _response = await http.post(url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: _body);
    if (_response.statusCode == 200) {
      print("Folder added");
    } else {
      throw Exception('Error while trying to add folder to database');
    }
  }
}

final dataDBProvider = _DataDBProvider();
