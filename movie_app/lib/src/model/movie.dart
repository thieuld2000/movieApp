import 'formated_time_genrator.dart';

class Movie {
  final String? tmdbId;
  final String? imdbid;
  late final String? backdropPath;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final num? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final int? voteCount;
  final double? voteAverage;
  final List? genres;

  String? error;

  Movie(
      {this.imdbid,
      this.tmdbId,
      this.backdropPath,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteCount,
      this.voteAverage,
      this.genres});

  factory Movie.fromJson(dynamic json) {
    if (json == null) {
      return Movie();
    }

    return Movie(
      backdropPath: json['backdrop_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['backdrop_path']}"
          : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'],
      posterPath: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['poster_path']}"
          : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
      releaseDate: json['release_date'],
      title: json['title'],
      video: json['video'],
      voteCount: json['vote_count'],
      voteAverage: json['vote_average'].toDouble() ?? 0.0,
      genres: (json['genres'] ?? []).map((laung) => laung['name']).toList(),
    );
  }
}

class MovieModelList {
  final List<Movie> movies;
  MovieModelList({
    required this.movies,
  });
  factory MovieModelList.fromJson(List<dynamic> json) {
    return MovieModelList(
        movies: (json).map((list) => Movie.fromJson(list)).toList());
  }
}

class TrailerModel {
  final String id;
  final String site;
  final String name;
  final String key;
  TrailerModel({
    required this.id,
    required this.site,
    required this.name,
    required this.key,
  });
  factory TrailerModel.fromJson(json) {
    return TrailerModel(
      key: json['key'] ?? '',
      id: json['id'] ?? '',
      site: json['site'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class ImageBackdrop {
  final String image;
  ImageBackdrop({
    required this.image,
  });
  factory ImageBackdrop.fromJson(json) {
    return ImageBackdrop(
      image: "https://image.tmdb.org/t/p/original${json['file_path']}",
    );
  }
}

class ImageBackdropList {
  final List<ImageBackdrop> backdrops;

  ImageBackdropList({
    required this.backdrops,
  });

  factory ImageBackdropList.fromJson(backdrops) {
    return ImageBackdropList(
      backdrops: (backdrops as List)
          .map((backdrop) => ImageBackdrop.fromJson(backdrop))
          .toList(),
    );
  }
}

class CastInfo {
  final String name;
  final String character;
  final String image;
  final String id;
  CastInfo({
    required this.name,
    required this.character,
    required this.image,
    required this.id,
  });
  factory CastInfo.fromJson(json) {
    return CastInfo(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      character: json['character'] ?? '',
      image: json['profile_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['profile_path']}"
          : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
    );
  }
}

class CastInfoList {
  final List<CastInfo> castList;
  CastInfoList({
    required this.castList,
  });
  factory CastInfoList.fromJson(json) {
    return CastInfoList(
      castList: ((json['cast'] ?? []) as List)
          .map((cast) => CastInfo.fromJson(cast))
          .toList(),
    );
  }
}

class MovieInfoImdb {
  final String genre;
  final String runtime;
  final String director;
  final String writer;
  final String actors;
  final String language;
  final String awards;
  final String released;
  final String country;
  final String boxOffice;
  final String year;
  final String rated;
  final String plot;
  final String production;
  MovieInfoImdb({
    required this.genre,
    required this.runtime,
    required this.director,
    required this.writer,
    required this.actors,
    required this.language,
    required this.awards,
    required this.released,
    required this.country,
    required this.boxOffice,
    required this.year,
    required this.rated,
    required this.plot,
    required this.production,
  });
  factory MovieInfoImdb.fromJson(json) {
    return MovieInfoImdb(
      actors: json['Actors'] ?? '',
      rated: json['Rated'] ?? '',
      production: json['Production'] ?? '',
      plot: json['Plot'] ?? '',
      awards: json['Awards'] ?? '',
      director: json['Director'] ?? '',
      genre: (json['genres'] as List).map((laung) => laung['name']).toString(),
      language: json['Language'] ?? '',
      released: json['release_date'] ?? '',
      runtime: json['runtime'].toString(),
      writer: json['Writer'].toString(),
      year: json['Year'].toString(),
      boxOffice: json['BoxOffice'].toString(),
      country: json['Country'] ?? '',
    );
  }
}

class MovieInfoModel {
  final String tmdbId;
  final String overview;
  final String title;
  final List languages;
  final String backdrops;
  final String poster;
  final int budget;
  final String tagline;
  final double rateing;
  final String dateByMonth;
  final int runtime;
  final String homepage;
  final String imdbid;
  final List genres;
  final String releaseDate;
  MovieInfoModel({
    required this.tmdbId,
    required this.overview,
    required this.title,
    required this.languages,
    required this.backdrops,
    required this.poster,
    required this.budget,
    required this.tagline,
    required this.rateing,
    required this.dateByMonth,
    required this.runtime,
    required this.homepage,
    required this.imdbid,
    required this.genres,
    required this.releaseDate,
  });
  factory MovieInfoModel.fromJson(json) {
    var string = "";
    getString() {
      try {
        string =
            "${monthgenrater(json['release_date'].split("-")[1])} ${json['release_date'].split("-")[2]}, ${json['release_date'].split("-")[0]}";

        // ignore: empty_catches
      } catch (e) {}
    }

    getString();
    return MovieInfoModel(
      budget: json['budget'] ?? 0,
      title: json['title'] ?? '',
      homepage: json['homepage'] ?? "",
      imdbid: json['imdb_id'] ?? json['id'].toString(),
      languages: (json['spoken_languages'] ?? [])
          .map((laung) => laung['english_name'])
          .toList(),
      genres: (json['genres'] ?? []).map((laung) => laung['name']).toList(),
      overview: json['overview'] ?? json['actors'] ?? '',
      backdrops: json['backdrop_path'] != null
          ? "https://image.tmdb.org/t/p/original${json['backdrop_path']}"
          : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
      poster: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['poster_path']}"
          : "https://images.pexels.com/photos/4089658/pexels-photo-4089658.jpeg?cs=srgb&dl=pexels-victoria-borodinova-4089658.jpg&fm=jpg",
      rateing: json['vote_average'].toDouble() ?? 0.0,
      runtime: json['runtime'] ?? 0,
      tagline: json['tagline'] ?? json['actors'] ?? '',
      tmdbId: json['id'].toString(),
      releaseDate: json['release_date'] ?? '',
      dateByMonth: string,
    );
  }
}
