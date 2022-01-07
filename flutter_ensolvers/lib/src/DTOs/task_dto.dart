import 'package:flutter/material.dart';

class TaskDto {
  String _taskTitle = 'Unnamed Task';
  bool _isChecked = false;
  Key _key = Key('0');

  TaskDto(taskTitle, isChecked, {key}) {
    _taskTitle = taskTitle;
    _isChecked = isChecked;
    _key = key;
  }

  void setKey(key) {
    _key = key;
  }

  String getTaskTitle() {
    return _taskTitle;
  }

  bool getIsChecked() {
    return _isChecked;
  }

  Key getKey() {
    return _key;
  }

  void setTitle(String title) {
    _taskTitle = title;
  }
}
