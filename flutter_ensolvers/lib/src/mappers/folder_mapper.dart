import 'package:flutter/material.dart';
import 'package:flutter_ensolvers/src/DTOs/folder_dto.dart';

class FolderMapper {
  static List<FolderDto> fromFolderModelToFolderDTO(Map data) {
    List<dynamic> _dataObjects = data['folders'];
    final List<FolderDto> _foldersDTO = [];

    for (var folderObject in _dataObjects) {
      FolderDto _newFolderDto = FolderDto(
          folderObject['title'], folderObject['tasks'],
          key: Key(folderObject['_id']));
      _foldersDTO.add(_newFolderDto);
    }

    return _foldersDTO;
  }
}
