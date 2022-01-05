import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  final List<Widget> _tasksList = [];

  ToDoPage(_tasksLits, {Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState(_tasksList);
}

class _ToDoPageState extends State<ToDoPage> {
  String _taskTitle = 'Unnamed Task';
  final List<Widget> _tasksList;
  int _index = 0;
  bool _isChecked = false;
  bool _wasEdited = false;
  final _textFieldCreatorController = TextEditingController();
  final _textFieldEditorController = TextEditingController();

  _ToDoPageState(this._tasksList);

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
    _index++;
    Key newKey = Key(_index.toString());
    _setUnnamedTaskIfEmpty();
    setState(() {
      _taskTitle = _textFieldCreatorController.text;
      _tasksList.add(_newTask(newKey, _taskTitle));
      _textFieldCreatorController.text = '';
      _isChecked = false;
    });
  }

  StatefulBuilder _newTask(Key newkey, String taskTitle) {
    return StatefulBuilder(
        key: newkey,
        builder: (BuildContext context, StateSetter setState) {
          return ListTile(
            tileColor: Colors.white,
            title: Text(_taskTitle),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            leading: Checkbox(
              value: _isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  _isChecked = newValue!;
                  _taskTitle = taskTitle;
                });
              },
            ),
            trailing: TextButton(
              child: Icon(Icons.edit),
              onPressed: () async {
                await _editTask(context, newkey, taskTitle);
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

  Future _editTask(BuildContext context, Key newKey, String taskTitle) =>
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
              title: Text('Editing Task "${taskTitle}"'),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Edit Task'),
                  controller: _textFieldEditorController,
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Row(
                  children: <Widget>[
                    TextButton(
                        onPressed: () => _onConfirmEditTaskClicked(context),
                        child: Text('Confirm')),
                    Padding(padding: EdgeInsetsDirectional.only(start: 120)),
                    TextButton(
                        onPressed: () =>
                            _onDeleteEditTaskClicked(context, newKey),
                        child: Icon(Icons.delete, color: Colors.red))
                  ],
                )
              ])));

  void _onDeleteEditTaskClicked(BuildContext context, Key newKey) {
    setState(() {
      _tasksList.removeWhere((element) => element.key == newKey);
      Navigator.of(context).pop();
    });
  }

  void _onConfirmEditTaskClicked(BuildContext context) {
    _wasEdited = true;
    setState(() {
      _taskTitle = _textFieldEditorController.text;
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
