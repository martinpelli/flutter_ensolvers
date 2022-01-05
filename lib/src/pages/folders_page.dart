import 'package:flutter/material.dart';

import 'package:flutter_ensolvers/src/DTOs/folder_dto.dart';
import 'package:flutter_ensolvers/src/providers/data_provider.dart';

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
    dataProvider.loadData("folders").then((data) {
      data.forEach((property) {
        FolderDto _newFolderDto = FolderDto(
            property['title'], Key(property['key']), property['tasks']);
        List<dynamic> tasks = _newFolderDto.getTasks();
        _foldersList.add(_newFolder(context, _newFolderDto.getKey(),
            _newFolderDto.getFolderTitle(), tasks));
        setState(() {});
      });
      _index = data.length;
    });
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
      _foldersList.add(_newFolder(context, newKey, _folderTitle, []));
      _textFieldCreatorController.text = '';
    });
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
