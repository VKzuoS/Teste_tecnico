import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocos/assistir_bloc.dart';
import 'package:flutter_app/blocos/auth_bloc.dart';
import 'package:flutter_app/blocos/filmes_bloc.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/movietile.dart';
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
    String pesquisa;

    var usuario = Provider.of<AuthBloc>(context, listen: false).authService;
    return BlocProvider(
        bloc: MovieBloc(),
        child: BlocProvider(
            bloc: AssistirBloc(),
            child: StreamBuilder<User>(
                stream: usuario.currentUser,
                builder: (context, snapshot1) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text('Teste Técnico'),
                    ),
                    drawer: Drawer(
                      child: ListView(
                        children: [
                          DrawerHeader(
                            child: Center(
                              child: Text('${snapshot1.data.displayName}'),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Buscar Filme',
                              prefixIcon: Icon(Icons.search)),
                              onChanged: (String value) {
                                pesquisa = value;
                              },
                              onEditingComplete: () async {
                                BlocProvider.of<MovieBloc>(context).inSearch.add(pesquisa);
                                Navigator.pop(context);
                          }),
                          Align(
                            alignment: Alignment.center,
                            child: StreamBuilder<Map<String, Movie>>(
                          stream: BlocProvider.of<AssistirBloc>(context).outAssistir,
                          initialData: {},
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Text(
                                '${snapshot.data.length}',
                                style: TextStyle(color: Colors.black),
                              );
                            else
                              return Text(
                                "Jera",
                                style: TextStyle(color: Colors.black),
                              );
                          },
                        ),
                          ),
                        ListTile(
                          leading: Icon(Icons.auto_awesome),
                          title: Text('Para Assistir'),
                        ),
                        ListTile(
                            leading: Icon(Icons.logout),
                            tileColor: Colors.redAccent,
                            title: Text('Logout'),
                            onTap: () => usuario.logout()),
                      ],
                    )),
                    body: StreamBuilder(
                        stream: BlocProvider.of<MovieBloc>(context).outMovies,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                return MovieTile(snapshot.data[index]);
                              },
                              itemCount: snapshot.data.length,
                            );
                          } else {
                            return Container();
                          }
                        }),
                  );
                })));
  }
}
