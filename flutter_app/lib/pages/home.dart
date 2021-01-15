import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste Técnico'),
      ),
      drawer: Drawer(
        child: ListView(

          children: [
            DrawerHeader(
              child: Text('Header'),
              decoration: BoxDecoration(
                color: Colors.blueAccent
              ),
              margin: EdgeInsets.only(bottom: 0),
            ),
            ListTile(
              leading: Icon(Icons.auto_awesome),
              title: Text('Para Assistir'),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Buscar Filme'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              tileColor: Colors.redAccent,
              title: Text('Logout'),
              onTap: () =>
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Login(),
              )),
            ),
          ],
        ),
      ),
      //body: ListView.builder(itemBuilder: ),
    );
  }
}
