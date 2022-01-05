import 'package:flutter/material.dart';

import 'package:flutter_ensolvers/src/pages/folders_page.dart';
import 'package:flutter_ensolvers/src/pages/to_do_page.dart';

Map<String, WidgetBuilder> getRoutes(tasksList) {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => FoldersPage(),
    'to-do': (BuildContext context) => ToDoPage(tasksList)
  };
}
