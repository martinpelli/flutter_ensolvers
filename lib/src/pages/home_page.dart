import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Ensolvers App'))),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <ListTile>[
            ListTile(
              tileColor: Colors.black12,
              title: Text('To-Do List'),
              trailing: Icon(Icons.list),
              onTap: () => Navigator.pushNamed(context, 'to-do'),
              hoverColor: Colors.black12,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
            )
          ],
        ),
      ),
    );
  }
}
