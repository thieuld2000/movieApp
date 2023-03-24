class Movie {
  final String? backdropPath;
  final int? id;
  final String? originalLanguage;
  final String? orifinalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final int? voteCount;
  final String? voteAverage;

  String? error;

  Movie({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.orifinalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteCount,
    this.voteAverage,
  });

  factory Movie.fromjson(dynamic json) {
    if (json == null) {
      return Movie();
    }

    return Movie(
        backdropPath: json['backdropPath'],
        id: json['id'],
        originalLanguage: json['originalLanguage'],
        orifinalTitle: json['orifinalTitle'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['posterPath'],
        releaseDate: json['releaseDate'],
        title: json['title'],
        video: json['video'],
        voteCount: json['voteCount'],
        voteAverage: json['voteAverage'].toString());
  }
}
