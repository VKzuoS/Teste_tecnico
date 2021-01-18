import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:flutter_app/tmdb.dart';

class MovieBloc extends BlocBase {
  Tmdb api;

  List<Movie> filmes;

  final StreamController<List<Movie>> _movieController =
      StreamController<List<Movie>>.broadcast();
  Stream get outMovies => _movieController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  MovieBloc() {
    api = Tmdb();

    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    if (search != null) {
      _movieController.sink.add([]);
      filmes = await api.search(search);
    }

    _movieController.sink.add(filmes);
  }

  @override
  void dispose() {
    _movieController.close();
    _searchController.close();
  }
}
