import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocos/auth_bloc.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    var usuario = Provider.of<AuthBloc>(context, listen: false).authService;
    usuario.currentUser.listen((logado) {
      if (logado == null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Login(),
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var usuario = Provider.of<AuthBloc>(context, listen: false).authService;
    String nomeConta;
    return StreamBuilder<User>(
      stream: usuario.currentUser,
      builder: (context, snapshot){
        return Scaffold(
        appBar: AppBar(
          title: Text('Teste Técnico'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(child: Text('${nomeConta}'),),
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
                    usuario.logout()
              ),
            ],
          ),
        ),
        //body: ListView.builder(itemBuilder: ),
      );}
    );
  }
}
