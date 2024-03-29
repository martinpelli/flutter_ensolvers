import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_ensolvers/src/DTOs/folder_dto.dart';

import 'package:flutter_ensolvers/src/DTOs/task_dto.dart';
import 'package:flutter_ensolvers/src/providers/data_db_provider.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  String _taskTitle = 'Unnamed Task';
  final List<Widget> _tasksList = [];
  bool _wasEdited = false;
  final _textFieldCreatorController = TextEditingController();
  final _textFieldEditorController = TextEditingController();
  String _folderId = '';

  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _loadTasks());
  }

  void _loadTasks() async {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    List<TaskDto> tasksDTO;
    _folderId = arguments['folderId'];
    tasksDTO = await dataDBProvider.getTasksFromDB(_folderId);
    for (var task in tasksDTO) {
      _tasksList.add(
          _newTask(task.getKey(), task.getTaskTitle(), task.getIsChecked()));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, // Don't show the leading button
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 360),
                  child: Text('To-Do List'),
                )
              ])),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(top: 10),
          constraints: BoxConstraints(maxWidth: 500),
          child: Center(
            child: Column(children: [
              Wrap(runSpacing: 10, children: _tasksList),
              _newTaskCreatorTile()
            ]),
          ),
        ),
      ),
    );
  }

  ListTile _newTaskCreatorTile() {
    return ListTile(
        title: TextField(
          controller: _textFieldCreatorController,
          decoration: InputDecoration(labelText: 'New Task'),
        ),
        trailing: TextButton(
            onPressed: () => _createNewTask(), child: Text('Add Task')));
  }

  void _createNewTask() {
    try {
      _taskTitle = _textFieldCreatorController.text;
      _setUnnamedTaskIfEmpty();
      TaskDto _newTaskDTO = TaskDto(_taskTitle, false);
      dataDBProvider.addTaskToDB(_newTaskDTO, _folderId).then((taskId) {
        _tasksList.add(_newTask(Key(taskId), _newTaskDTO.getTaskTitle(),
            _newTaskDTO.getIsChecked()));
        _textFieldCreatorController.text = '';
        _newTaskDTO.setKey(Key(taskId));
        setState(() {});
      });
    } catch (exception) {
      print(exception);
    }
  }

  StatefulBuilder _newTask(Key newkey, String taskTitle, isChecked) {
    return StatefulBuilder(
        key: newkey,
        builder: (BuildContext context, StateSetter setState) {
          return ListTile(
            tileColor: Colors.white,
            title: Text(taskTitle),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            leading: Checkbox(
              value: isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  isChecked = newValue!;
                  _taskTitle = taskTitle;
                  TaskDto taskDto = TaskDto(_taskTitle, isChecked, key: newkey);
                  dataDBProvider.updateTask(taskDto);
                });
              },
            ),
            trailing: TextButton(
              child: Icon(Icons.edit),
              onPressed: () async {
                await _editTask(
                    context, TaskDto(taskTitle, isChecked, key: newkey));
                if (_wasEdited) {
                  setState(() {
                    taskTitle = _taskTitle;
                  });
                  _wasEdited = false;
                }
              },
            ),
          );
        });
  }

  Future _editTask(BuildContext context, TaskDto taskDto) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Editing Task "${taskDto.getTaskTitle()}"'),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Edit Task'),
              controller: _textFieldEditorController,
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Row(
              children: <Widget>[
                TextButton(
                    onPressed: () =>
                        _onConfirmEditTaskClicked(context, taskDto),
                    child: Text('Confirm')),
                Padding(padding: EdgeInsetsDirectional.only(start: 120)),
                TextButton(
                    onPressed: () =>
                        _onDeleteEditTaskClicked(context, taskDto.getKey()),
                    child: Icon(Icons.delete, color: Colors.red))
              ],
            )
          ])));

  void _onDeleteEditTaskClicked(BuildContext context, Key newKey) {
    setState(() {
      _tasksList.removeWhere((element) => element.key == newKey);
      Navigator.of(context).pop();
      dataDBProvider.deleteTask(newKey.toString(), _folderId);
    });
  }

  void _onConfirmEditTaskClicked(BuildContext context, TaskDto taskDto) {
    _wasEdited = true;
    setState(() {
      _taskTitle = _textFieldEditorController.text;
      taskDto.setTitle(_taskTitle);
      dataDBProvider.updateTask(taskDto);
      _setUnnamedTaskIfEmpty();
      Navigator.of(context).pop();
    });
    _textFieldEditorController.text = '';
  }

  void _setUnnamedTaskIfEmpty() {
    if (_taskTitle.isEmpty) {
      _taskTitle = 'Unnamed Task';
    }
  }
}
