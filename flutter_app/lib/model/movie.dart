class Movie {
  final int id;
  final String title;
  final String posterPath;

  Movie({this.id, this.title, this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"],
      title: json["title"],
      posterPath: json["poster_path"],
    );
  }
}