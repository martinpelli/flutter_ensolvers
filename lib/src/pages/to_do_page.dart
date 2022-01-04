import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  bool _isChecked = false;
  TextStyle _cancelStyle = TextStyle(color: Colors.red);
  String _taskTitle = 'Unnamed Task';
  List<Widget> _tasksList = [];
  final textFieldController = TextEditingController();

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
          controller: textFieldController,
          decoration: InputDecoration(labelText: 'New Task'),
        ),
        trailing: TextButton(
            onPressed: () => _createNewTask(), child: Text('Add Task')));
  }

  void _createNewTask() {
    _taskTitle = textFieldController.text;
    if (_taskTitle.isEmpty) {
      _taskTitle = 'Unnamed Task';
    }
    setState(() {
      _tasksList.add(_newTask());
      _tasksList.add(Padding(padding: EdgeInsets.all(5)));
      textFieldController.text = '';
      _taskTitle = 'Unnamed Task';
    });
  }

  ListTile _newTask() {
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
        onPressed: () => _showAlert(context),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Editing Task'),
              content:
                  Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                TextField(),
                Padding(padding: EdgeInsets.all(10.0)),
                Row(
                  children: <TextButton>[
                    TextButton(onPressed: () {}, child: Text('Confirm')),
                    TextButton(
                        onPressed: () => _onCancelClicked(context),
                        child: Text(
                          'Cancel',
                          style: _cancelStyle,
                        ))
                  ],
                )
              ]));
        });
  }

  void _onCancelClicked(BuildContext context) {
    Navigator.of(context).pop();
  }
}
