import 'package:flutter/material.dart';

import 'package:flutter_ensolvers/src/DTOs/folder_dto.dart';
import 'package:flutter_ensolvers/src/providers/data_db_provider.dart';
//import 'package:flutter_ensolvers/src/providers/data_local_provider.dart';

class FoldersPage extends StatefulWidget {
  @override
  State<FoldersPage> createState() => _FoldersPageState();
}

class _FoldersPageState extends State<FoldersPage> {
  final List<Widget> _foldersList = [];
  String _folderTitle = 'Unnamed Folder';
  int _index = 0;

  final _textFieldCreatorController = TextEditingController();

  _FoldersPageState() {
    _addSavedFolders();
  }

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

  void _addSavedFolders() {
    dataDBProvider.loadData().then((foldersDTO) {
      for (var folderDTo in foldersDTO) {
        List<dynamic> tasks = folderDTo.getTasks();
        _foldersList.add(_newFolder(
            context, folderDTo.getKey(), folderDTo.getFolderTitle(), tasks));
        setState(() {});
      }
      _index = foldersDTO.length;
    });
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
    try {
      setState(() {
        _folderTitle = _textFieldCreatorController.text;
        FolderDto _newFolderDTO = FolderDto(_folderTitle, []);
        dataDBProvider.addFolderToDB(_newFolderDTO);
        _foldersList.add(_newFolder(context, newKey,
            _newFolderDTO.getFolderTitle(), _newFolderDTO.getTasks()));
        _textFieldCreatorController.text = '';
      });
    } catch (exception) {
      print(exception);
    }
  }

  ListTile _newFolder(BuildContext context, Key newKey, String folderTitle,
      List<dynamic> tasks) {
    return ListTile(
      leading: Icon(Icons.folder),
      key: newKey,
      tileColor: Colors.black12,
      title: Center(child: Text(folderTitle)),
      trailing: TextButton(onPressed: () {}, child: Icon(Icons.delete)),
      onTap: () => Navigator.pushNamed(context, 'to-do', arguments: tasks),
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
