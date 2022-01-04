import 'package:flutter/material.dart';

import 'package:flutter_ensolvers/src/pages/home_page.dart';
import 'package:flutter_ensolvers/src/pages/to_do_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'to-do': (BuildContext context) => ToDoPage()
  };
}
