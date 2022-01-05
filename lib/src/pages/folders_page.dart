import 'package:flutter/material.dart';

class FoldersPage extends StatefulWidget {
  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  List<Widget> _foldersList = [];
  String _folderTitle = 'Unnamed Folder';
  int _index = 0;

  final _textFieldCreatorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Folders'))),
      body: Center(
        child: Container(
            padding: EdgeInsets.only(top: 10),
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(children: <Widget>[
              Column(children: [
                Wrap(runSpacing: 10, children: _foldersList),
                _newFolderCreatorTile()
              ])
            ])),
      ),
    );
  }

  ListTile _newFolderCreatorTile() {
    return ListTile(
        title: TextField(
          controller: _textFieldCreatorController,
          decoration: InputDecoration(labelText: 'New Folder'),
        ),
        trailing: TextButton(
            onPressed: () => _createNewFolder(context),
            child: Text('Add Folder')));
  }

  void _createNewFolder(BuildContext context) {
    _index++;
    Key newKey = Key(_index.toString());
    _setUnnamedFolderIfEmpty();
    setState(() {
      _folderTitle = _textFieldCreatorController.text;
      _foldersList.add(_newFolder(context, newKey));
      _textFieldCreatorController.text = '';
    });
  }

  ListTile _newFolder(BuildContext context, Key newKey) {
    return ListTile(
      key: newKey,
      tileColor: Colors.black12,
      title: Text(_folderTitle),
      trailing: Icon(Icons.folder),
      onTap: () => Navigator.pushNamed(context, 'to-do'),
      hoverColor: Colors.black12,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }

  void _setUnnamedFolderIfEmpty() {
    if (_folderTitle.isEmpty) {
      _folderTitle = 'Unnamed Folder';
    }
  }
}
