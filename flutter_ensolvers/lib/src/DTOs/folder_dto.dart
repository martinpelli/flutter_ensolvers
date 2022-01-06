import 'package:flutter/material.dart';

import 'package:flutter_ensolvers/src/DTOs/task_dto.dart';

class FolderDto {
  String _folderTitle = 'Unnamed Folder';
  Key _key = Key('0');
  List<dynamic> _tasks = [];

  FolderDto(taskTitle, tasks, {key}) {
    _folderTitle = taskTitle;
    _key = key;
    _tasks = tasks;
  }

  void seFolderDto(folderTitle, key, tasks) {
    _folderTitle = folderTitle;
    _key = key;
    _tasks = tasks;
  }

  String getFolderTitle() {
    return _folderTitle;
  }

  Key getKey() {
    return _key;
  }

  List<dynamic> getTasks() {
    return _tasks;
  }
}
