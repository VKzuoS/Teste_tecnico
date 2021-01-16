import 'dart:convert';

import 'package:flutter_app/model/movie.dart';
import 'package:http/http.dart' as http;

const API_KEY = "2b5c8832392378b659640eaeef5cd6c6";

class Tmdb{
  search(String search) async{
    http.Response response = await http.get('https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&query=$search');
    decode(response);
  }

  decode(http.Response response){
    if(response.statusCode == 200){
      var decoded = json.decode(response.body);

      List<Movie> filmes = decoded["results"].map<Movie>(
        (map){
          return Movie.fromJson(map);
        }
      ).toList();

      return filmes;
    }
  }
}