import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_ensolvers/src/DTOs/folder_dto.dart';
import 'package:flutter_ensolvers/src/DTOs/task_dto.dart';
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

  Future<String> addTaskToDB(TaskDto taskDto, Key folderKey) async {
    final String folderId =
        folderKey.toString().replaceAll(RegExp(r'[^\w\s]+'), '');
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

  Future<void> updateFolderTasks(
      TaskDto task, FolderDto folder, bool isNewTask) async {
    Uri url = Uri.parse('${apiAddress}folders/modify');
    final String id =
        task.getKey().toString().replaceAll(RegExp(r'[^\w\s]+'), '');
    final List tasks = folder.getTasks();
    if (!isNewTask) {
      tasks.removeAt(tasks.indexWhere((_task) => _task['key'] == id));
    }
    tasks.add({
      'title': task.getTaskTitle(),
      'checked': task.getIsChecked(),
      'key': id
    });

    var _body = json.encode({
      '_id': folder.getKey().toString().replaceAll(RegExp(r'[^\w\s]+'), ''),
      'tasks': tasks
    });
    final http.Response _response = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: _body);
    if (_response.statusCode != 200) {
      throw Exception('Error while trying to upadate folder to database');
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

  Future<void> deleteElement(String id, String element) async {
    Uri url = Uri.parse('${apiAddress}' + element + '/delete/$id');
    final http.Response _response =
        await http.delete(url, headers: {'Content-Type': 'application/json'});
    if (_response.statusCode != 200) {
      throw Exception('Error while trying to delete task to database');
    }
  }

  Future<void> deleteTasksInFolder(List tasks) async {
    Uri url = Uri.parse('${apiAddress}tasks/delete/');
    final List tasksIds = [];
    for (var task in tasks) {
      tasksIds.add(task['key']);
    }
    var _body = json.encode({'tasksIds': tasksIds});
    final http.Response _response = await http.delete(url,
        headers: {'Content-Type': 'application/json'}, body: _body);
    if (_response.statusCode != 200) {
      throw Exception('Error while trying to update task to database');
    }
  }

  Future<void> addIdTaskToFolder(String taskId, Key folderKey) async {
    final String folderId =
        folderKey.toString().replaceAll(RegExp(r'[^\w\s]+'), '');
    Uri url = Uri.parse('${apiAddress}folders/addtask/$folderId');
    var _body = json.encode({'taskId': taskId});
    final http.Response _response = await http.put(url,
        headers: {'Content-Type': 'application/json'}, body: _body);
    if (_response.statusCode != 200) {
      throw Exception('Error while trying to add task to folder in database');
    }
  }
}

final dataDBProvider = _DataDBProvider();
