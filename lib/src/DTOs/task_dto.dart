import 'package:flutter/material.dart';

class TaskDto {
  String _taskTitle = 'Unnamed Task';
  bool _isChecked = false;
  Key _key = Key('0');

  TaskDto(_taskTitle, _isChecked, _key);

  TaskDto _getTaskDto() {
    return TaskDto(_taskTitle, _isChecked, _key);
  }

  void _setTaskDto(_taskTitle, _isChecked, _key) {
    this._taskTitle = _taskTitle;
    this._isChecked = _isChecked;
    this._key = _key;
  }
}
