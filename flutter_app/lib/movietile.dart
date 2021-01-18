import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocos/assistir_bloc.dart';
import 'package:flutter_app/model/movie.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  MovieTile(this.movie);

  @override
  Widget build(BuildContext context) {
    String imagem;
    String chave;
    if (movie.posterPath != null) {
      imagem = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
    } else {
      imagem = 'https://image.flaticon.com/icons/png/512/122/122130.png';
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        children: [
          Image.network(
            imagem,
            height: 400,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(movie.title),
              StreamBuilder<Map<String, Movie>>(
                stream: BlocProvider.of<AssistirBloc>(context).outAssistir,
                initialData: {},
                builder: (context, snapshot) {
                  dynamic chave = movie.id;
                  return RaisedButton(
                    child: snapshot.data.containsKey('$chave') ? Text('Remover Para Assistir', style: TextStyle(color: Colors.red),) : Text('Adicionar Para Assistir', style: TextStyle(color: Colors.green)),
                      onPressed:() {
                        BlocProvider.of<AssistirBloc>(context)
                            .toggleAssistir(movie);
                      });
                },
              )
            ],
          ),
          Divider()
        ],
      ),
    );
  }
}
