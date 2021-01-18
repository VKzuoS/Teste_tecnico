import 'dart:async';
import 'dart:convert';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_app/model/movie.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssistirBloc extends BlocBase {

  Map<String,Movie> _assistir = {};
  String chave;

  final _assistirController = BehaviorSubject<Map<String, Movie>>();
  Stream<Map<String, Movie>> get outAssistir => _assistirController.stream;

  AssistirBloc(){
    SharedPreferences.getInstance().then((prefs){
      if(prefs.getKeys().contains("assistir")){
        _assistir = json.decode(prefs.getString("assistir")).map((k, v){
          return MapEntry(k, Movie.fromJson(v));
        }).cast<String, Movie>();
        _assistirController.add(_assistir);
      }
    });
  }

  void toggleAssistir(Movie movie) {
    if (_assistir.containsKey('$chave')){
      dynamic chave = movie.id;
      _assistir.remove('$chave');
    }
    else {
      _assistir ['${movie.id}'] = movie;
    }    
    _assistirController.sink.add(_assistir);
    _save();
  }

  void _save(){
    SharedPreferences.getInstance().then((prefs)  {
      prefs.setString("assistir", json.encode(_assistir));
    });
  }

  @override
  void dispose() {
    _assistirController.close();
  }
}
