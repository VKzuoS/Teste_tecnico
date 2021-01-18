import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_app/model/movie.dart';

class AssistirBloc extends BlocBase {

  Map<String,Movie> _assistir = {};
  String chave;

  final StreamController<Map<String, Movie>> _assistirController =
      StreamController<Map<String, Movie>>.broadcast();
  Stream<Map<String, Movie>> get outAssistir => _assistirController.stream;

  void toggleAssistir(Movie movie) {
    if (_assistir.containsValue(movie)){
      dynamic chave = movie.id;
      _assistir.remove('$chave');
    }
    else {
      _assistir ['${movie.id}'] = movie;
    }    
    _assistirController.sink.add(_assistir);
  }

  @override
  void dispose() {
    _assistirController.close();
  }
}
