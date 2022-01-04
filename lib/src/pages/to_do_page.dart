import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  String _taskTitle = 'Unnamed Task';
  List<Widget> _tasksList = [];
  int indexToRemove = -1;
  bool _isChecked = false;
  final _textFieldCreatorController = TextEditingController();
  final _textFieldEditorController = TextEditingController();

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
                  padding: const EdgeInsets.only(right: 300),
                  child: Text('To-Do List'),
                )
              ])),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500),
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(children: [
              Column(children: _tasksList),
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
    _taskTitle = _textFieldCreatorController.text;
    _setUnnamedTaskIfEmpty();
    setState(() {
      _tasksList.add(_newTask());
      _tasksList.add(Padding(padding: EdgeInsets.all(5)));
      _textFieldCreatorController.text = '';
      _isChecked = false;
    });
  }

  StatefulBuilder _newTask() {
    return StatefulBuilder(
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
            });
          },
        ),
        trailing: TextButton(
          child: Icon(Icons.edit),
          onPressed: () async {
            await _editTask(context, _tasksList.length - 2);
            setState(() {});
          },
        ),
      );
    });
  }

  Future _editTask(BuildContext context, int index) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Editing Task "${_taskTitle}"'),
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
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
                    onPressed: () => _onDeleteEditTaskClicked(context, index),
                    child: Icon(Icons.delete, color: Colors.red))
              ],
            )
          ])));

  void _onDeleteEditTaskClicked(BuildContext context, int index) {
    setState(() {
      _tasksList.removeAt(index);
      Navigator.of(context).pop();
    });
  }

  void _onConfirmEditTaskClicked(BuildContext context) {
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
