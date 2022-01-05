import 'package:flutter/material.dart';

class FolderDto {
  String _taskTitle = 'Unnamed Task';
  Key _key = Key('0');

  FolderDto(_taskTitle, _key);

  FolderDto _getTaskDto() {
    return FolderDto(_taskTitle, _key);
  }

  void _setTaskDto(_taskTitle, _key) {
    this._taskTitle = _taskTitle;
    this._key = _key;
  }
}
