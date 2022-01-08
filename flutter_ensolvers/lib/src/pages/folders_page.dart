import 'dart:html';

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
  FolderDto _newFolderDTO = FolderDto('Unnamed Folder', []);

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
    dataDBProvider.getFoldersFromDB().then((foldersDTO) {
      for (var folderDTo in foldersDTO) {
        _foldersList.add(_newFolder(context, folderDTo.getKey(),
            folderDTo.getFolderTitle(), folderDTo.getTasks()));
        _newFolderDTO = folderDTo;
        setState(() {});
      }
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
    _setUnnamedFolderIfEmpty();
    try {
      _folderTitle = _textFieldCreatorController.text;
      _newFolderDTO = FolderDto(_folderTitle, []);
      dataDBProvider.addFolderToDB(_newFolderDTO).then((id) {
        _foldersList.add(_newFolder(context, Key(id),
            _newFolderDTO.getFolderTitle(), _newFolderDTO.getTasks()));
        _textFieldCreatorController.text = '';
        _newFolderDTO.setKey(Key(id));
        setState(() {});
      });
    } catch (exception) {}
  }

  ListTile _newFolder(
      BuildContext context, Key newKey, String folderTitle, List tasks) {
    return ListTile(
      leading: Icon(Icons.folder),
      key: newKey,
      tileColor: Colors.black12,
      title: Center(child: Text(folderTitle)),
      trailing: TextButton(
          onPressed: () => _onDeleteFolderClicked(context, newKey),
          child: Icon(Icons.delete)),
      onTap: () => Navigator.pushNamed(context, 'to-do',
          arguments: {"folderId": newKey.toString()}),
      hoverColor: Colors.black12,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    );
  }

  void _onDeleteFolderClicked(BuildContext context, Key newKey) {
    setState(() {
      _foldersList.removeWhere((element) => element.key == newKey);
      dataDBProvider.deleteElement(
          newKey.toString().replaceAll(RegExp(r'[^\w\s]+'), ''), 'folders');
      dataDBProvider.deleteTasksInFolder(_newFolderDTO.getTasks());
    });
  }

  void _setUnnamedFolderIfEmpty() {
    if (_folderTitle.isEmpty) {
      _folderTitle = 'Unnamed Folder';
    }
  }
}
