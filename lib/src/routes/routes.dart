import 'package:flutter/material.dart';

import 'package:flutter_ensolvers/src/pages/home_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{'/': (BuildContext context) => HomePage()};
}
