import 'package:flutter/material.dart';

class FolderDto {
  String _folderTitle = 'Unnamed Folder';
  Key _key = Key('0');
  List _tasks = [];

  FolderDto(taskTitle, tasks, {key}) {
    _folderTitle = taskTitle;
    _key = key;
    _tasks = tasks;
  }

  void setKey(key) {
    _key = key;
  }

  String getFolderTitle() {
    return _folderTitle;
  }

  Key getKey() {
    return _key;
  }

  List getTasks() {
    return _tasks;
  }
}
