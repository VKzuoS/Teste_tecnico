import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/blocos/assistir_bloc.dart';
import 'package:flutter_app/blocos/filmes_bloc.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/movietile.dart';

class Assistir extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Para Assistir'),),
      body:StreamBuilder(
        stream: BlocProvider.of<AssistirBloc>(context).outAssistir,
        initialData: {},
        builder: (context, snapshot){
          return ListView(
            children: snapshot.data.values.map((v){
              return Column(children: [
                Container(
                  height: 400,
                  child: Image.network(v.posterPath),
                ),
                Text(v.title),
              ]);
            })
          );
        },
        ), 
    );
  }
}