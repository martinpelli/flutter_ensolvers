import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({Key? key}) : super(key: key);

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-do List')),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            children: <Widget>[
              _newTask(),
              Padding(padding: EdgeInsets.all(5.0)),
              _newTask()
            ],
          ),
        ),
      ),
    );
  }

  ListTile _newTask() {
    return ListTile(
      tileColor: Colors.white,
      title: Text('Mi primera tarea'),
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
        onPressed: () {},
      ),
    );
  }
}
