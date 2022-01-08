import 'package:flutter/material.dart';
import 'package:flutter_ensolvers/src/DTOs/task_dto.dart';

class TaskMapper {
  static List<TaskDto> fromTaskModelToTaskDTO(Map data) {
    List<dynamic> _dataObjects = data['tasks'];
    final List<TaskDto> _tasksDTO = [];

    for (var taskObject in _dataObjects) {
      TaskDto _newTaskDto = TaskDto(taskObject['title'], taskObject['checked'],
          key: Key(taskObject['_id']));
      _tasksDTO.add(_newTaskDto);
    }

    return _tasksDTO;
  }
}
