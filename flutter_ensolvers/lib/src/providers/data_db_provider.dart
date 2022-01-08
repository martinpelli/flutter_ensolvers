import 'dart:convert';
import 'package:flutter_ensolvers/src/DTOs/folder_dto.dart';
import 'package:flutter_ensolvers/src/DTOs/task_dto.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_ensolvers/src/mappers/folder_mapper.dart';
import 'package:flutter_ensolvers/src/mappers/task_mapper.dart';

class _DataDBProvider {
  String apiAddress = 'http://localhost:4000/api/';

  Future<List<FolderDto>> getFoldersFromDB() async {
    Uri url = Uri.parse('${apiAddress}folders');
    final http.Response _response = await http.get(url);
    Map dataMap = json.decode(_response.body);
    return FolderMapper.fromFolderModelToFolderDTO(dataMap);
  }

  Future<List<TaskDto>> getTasksFromDB(String folderKey) async {
    final String folderId = folderKey.replaceAll(RegExp(r'[^\w\s]+'), '');
    Uri url = Uri.parse('${apiAddress}folders/gettasks/$folderId');
    final http.Response _response = await http.get(url);
    Map dataMap = json.decode(_response.body);
    return TaskMapper.fromTaskModelToTaskDTO(dataMap);
  }

  Future<String> addFolderToDB(FolderDto folderDto) async {
    Uri url = Uri.parse('${apiAddress}folders/create');
    var _body = json.encode({
      'title': folderDto.getFolderTitle(),
      'tasks': [],
    });
    final http.Response _response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: _body);
    if (_response.statusCode == 200) {
      Map dataMap = json.decode(_response.body);
      return (dataMap['folder']['_id']);
    } else {
      throw Exception('Error while trying to add folder to database');
    }
  }

  Future<String> addTaskToDB(TaskDto taskDto, String folderKey) async {
    final String folderId = folderKey.replaceAll(RegExp(r'[^\w\s]+'), '');
    Uri url = Uri.parse('${apiAddress}tasks/create/$folderId');
    var _body = json.encode({
      'title': taskDto.getTaskTitle(),
      'checked': '${taskDto.getIsChecked()}'
    });
    final http.Response _response = await http.post(url,
        headers: {'Content-Type': 'application/json'}, body: _body);
    if (_response.statusCode == 200) {
      Map dataMap = json.decode(_response.body);
      return (dataMap['task']['_id']);
    } else {
      throw Exception('Error while trying to add task to database');
    }
  }

  Future<void> updateTask(TaskDto task) async {
    Uri url = Uri.parse('${apiAddress}tasks/modify');
    var _body = json.encode({
      '_id': task.getKey().toString().replaceAll(RegExp(r'[^\w\s]+'), ''),
      'title': task.getTaskTitle(),
      'checked': task.getIsChecked()
    });
    final http.Response _response = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: _body);
    if (_response.statusCode != 200) {
      throw Exception('Error while trying to update task to database');
    }
  }

  Future<void> deleteFolder(String folderId) async {
    Uri url = Uri.parse('${apiAddress}folders/delete/$folderId');
    final http.Response _response =
        await http.delete(url, headers: {'Content-Type': 'application/json'});
    if (_response.statusCode != 200) {
      throw Exception('Error while trying to delete task to database');
    }
  }

  Future<void> deleteTask(String taskId, String folderId) async {
    taskId = taskId.replaceAll(RegExp(r'[^\w\s]+'), '');
    folderId = folderId.replaceAll(RegExp(r'[^\w\s]+'), '');
    Uri url = Uri.parse('${apiAddress}tasks/delete/$taskId/$folderId');
    final http.Response _response =
        await http.delete(url, headers: {'Content-Type': 'application/json'});
    if (_response.statusCode != 200) {
      throw Exception('Error while trying to delete task to database');
    }
  }
}

final dataDBProvider = _DataDBProvider();
