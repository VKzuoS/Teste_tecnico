import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocos/auth_bloc.dart';
import 'package:flutter_app/blocos/filmes_bloc.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/tmdb.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Teste Técnico'),
      ),
      drawer: StreamBuilder<User>(
          stream: usuario.currentUser,
          builder: (context, snapshot) {
            return Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Center(
                      child: Text('${snapshot.data.displayName}'),
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
                        //String result =
                        await Tmdb().search(pesquisa);
                        //if (result != null)
                        BlocProvider.of<MovieBloc>(context)
                            .inSearch
                            .add('jojo rabbit');
                        Navigator.pop(context);
                      }),
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
              ),
            );
          }),
      body: StreamBuilder(
          stream: BlocProvider.of<MovieBloc>(context).outMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                return MovieTile(snapshot.data[index]);
              });
            } else {
              return Container();
            }
          }),
    );
  }
}

class MovieTile extends StatelessWidget {
  final Movie movie;

  MovieTile(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 3.0 / 4.0,
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: [
              Text(movie.title),
            ],
          )
        ],
      ),
    );
  }
}
