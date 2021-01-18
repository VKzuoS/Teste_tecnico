import 'dart:convert';

class Movie {
  final int id;
  final String title;
  final String posterPath;

  Movie({this.id, this.title, this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    if(json.containsKey("id"))
    return Movie(
      id: json["id"],
      title: json["title"],
      posterPath: json["poster_path"],
    );
    else
    return Movie(
      id: json["id"],
      title: json["title"],
      posterPath: json["poster_path"]
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "id": id,
      "title": title,
      "posterPath": posterPath
    };
  }
}