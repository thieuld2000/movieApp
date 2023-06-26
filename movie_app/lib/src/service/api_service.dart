import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:movie_app/src/model/genre.dart';
import 'package:movie_app/src/model/movie.dart';

import '../bloc/movie_info_bloc/movie_info_state.dart';
import '../model/cast_info_model.dart';
import '../model/people_model.dart';

const String baseUrl = 'https://api.themoviedb.org/3';
const String apiKey = 'f472f818e137b7daf8fbe6e1e9c2df7c';
const String accountId = '18490744';
const String _token =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNDcyZjgxOGUxMzdiN2RhZjhmYmU2ZTFlOWMyZGY3YyIsInN1YiI6IjY0MWM2NTc2OTVjMGFmMDBjNWFmNmEwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jytnQ1YkH2BCWTp57f3vYF-5qJoEks31CFHcPEoIF-w';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Movie>> getTrendingMovie() async {
    try {
      const url =
          '$baseUrl/trending/all/day?api_key=$apiKey&language=en-US&page=1';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieTrendingList =
          movies.map((m) => Movie.fromJson(m)).toList();
      return movieTrendingList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      const url =
          '$baseUrl/movie/now_playing?api_key=$apiKey&language=en-US&page=1';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getUpComingMovie() async {
    try {
      final response = await _dio
          .get('$baseUrl/movie/upcoming?api_key=$apiKey&language=en-US&page=1');
      var movies = response.data['results'] as List;
      List<Movie> movieUpComingList =
          movies.map((m) => Movie.fromJson(m)).toList();
      return movieUpComingList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getTopRateMovie() async {
    try {
      final response = await _dio.get(
          '$baseUrl/movie/top_rated?api_key=$apiKey&language=en-US&page=1');
      var movies = response.data['results'] as List;
      List<Movie> movieTopRateList =
          movies.map((m) => Movie.fromJson(m)).toList();
      return movieTopRateList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getPopularMovie() async {
    try {
      final response = await _dio
          .get('$baseUrl/movie/popular?api_key=$apiKey&language=en-US&page=1');
      var movies = response.data['results'] as List;
      List<Movie> moviePopularList =
          movies.map((m) => Movie.fromJson(m)).toList();
      return moviePopularList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Movie>> getMovieByGenre(int movieId) async {
    try {
      final response = await _dio
          .get('$baseUrl/discover/movie?with_genres=$movieId&$apiKey');
      var movies = response.data['results'] as List;
      List<Movie> genreList = movies.map((m) => Movie.fromJson(m)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  Future<List<Genre>> getGenreList() async {
    try {
      final response = await _dio
          .get('$baseUrl/genre/movie/list?api_key=$apiKey&language=en-US');
      var genres = response.data['genres'] as List;
      List<Genre> genreList = genres.map((g) => Genre.fromjson(g)).toList();
      return genreList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  getMovieDetail(int id) {}
}

class FetchMovieDataById {
  Future<List<dynamic>> getDetails(String id) async {
    MovieInfoModel movieData;
    MovieInfoImdb omdbData;
    ImageBackdropList backdropsData;
    CastInfoList castData;
    var images = [];
    dynamic movie;
    dynamic cast;
    var response =
        await http.get(Uri.parse('$baseUrl/movie/$id?api_key=$apiKey'));
    if (response.statusCode == 200) {
      movie = jsonDecode(response.body);
    } else {
      throw FetchDataError(e as FetchDataError);
    }
    movieData = MovieInfoModel.fromJson(movie);
    backdropsData = ImageBackdropList.fromJson(images);

    var repo =
        await http.get(Uri.parse('$baseUrl/movie/$id/credits?api_key=$apiKey'));
    if (repo.statusCode == 200) {
      cast = jsonDecode(repo.body);
    } else {
      throw FetchDataError(e as FetchDataError);
    }
    castData = CastInfoList.fromJson(cast);

    var imdbId = movieData.imdbid;
    final omdbResponse =
        await http.get(Uri.parse('$baseUrl/movie/$imdbId?api_key=$apiKey'));
    if (omdbResponse.statusCode == 200) {
      omdbData = MovieInfoImdb.fromJson(jsonDecode(omdbResponse.body));
    } else {
      throw FetchDataError(e as FetchDataError);
    }
    return [
      movieData,
      omdbData,
      backdropsData.backdrops,
      castData.castList,
    ];
  }
}

class FetchCastInfoById {
  Future<List<dynamic>> getCastDetails(String id) async {
    CastPersonalInfo prinfo;
    ImageBackdropList backdrops;

    var response =
        await http.get(Uri.parse('$baseUrl/person/$id?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      prinfo = CastPersonalInfo.fromJson(data);

      var repo = await http
          .get(Uri.parse('$baseUrl/person/$id/images?api_key=$apiKey'));
      var data2 = jsonDecode(repo.body);
      backdrops = ImageBackdropList.fromJson(data2['profiles']);

      return [
        prinfo,
        backdrops.backdrops,
      ];
    } else {
      throw FetchDataError(e as FetchDataError);
    }
  }
}

class SearchResultsRepo {
  Future<List<dynamic>> getmovies(String query, int page) async {
    var res = await http.get(Uri.parse(
        '$baseUrl/search/movie?query=$query&page=${page.toString()}&api_key=$apiKey'));
    if (res.statusCode == 200) {
      return [
        (jsonDecode(res.body)['results'] as List)
            .map((list) => Movie.fromJson(list))
            .toList(),
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw FetchDataError("Something went wrong!" as FetchDataError);
    }
  }

  Future<List<dynamic>> getPersons(String query, int page) async {
    var res = await http.get(Uri.parse(
        '$baseUrl/search/person?query=$query&page=${page.toString()}&api_key=$apiKey'));
    if (res.statusCode == 200) {
      return [
        (jsonDecode(res.body)['results'] as List)
            .map((list) => PeopleModel.fromJson(list))
            .toList(),
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw FetchDataError("Something went wrong!" as FetchDataError);
    }
  }
}

class GenreResultsRepo {
  Future<List<dynamic>> getmovies(String query, int page) async {
    var res = await http.get(Uri.parse(
        '$baseUrl/discover/movie?with_genres=$query&page=${page.toString()}&api_key=$apiKey'));
    if (res.statusCode == 200) {
      return [
        (jsonDecode(res.body)['results'] as List)
            .map((list) => Movie.fromJson(list))
            .toList(),
        jsonDecode(res.body)['total_pages'],
      ];
    } else {
      throw FetchDataError("Something went wrong!" as FetchDataError);
    }
  }
}

class FetchWatchList {
  Future<List<MovieInfoModel>> getWatchList() async {
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $_token",
    };
    var response = await http.get(
        Uri.parse(
            'https://api.themoviedb.org/3/account/$accountId/watchlist/movies?language=en-US&sort_by=created_at.asc'),
        headers: headers);
    if (response.statusCode == 200) {
      return (jsonDecode(response.body)['results'] as List)
          .map((list) => MovieInfoModel.fromJson(list))
          .toList();
    } else {
      throw FetchDataError("Something went wrong!" as FetchDataError);
    }
  }
}

class WatchLitsPost {
  Future postwatchlist(
    String mediaid,
  ) async {
    Map<String, dynamic> body = {
      'media_type': 'movie',
      'media_id': mediaid,
      'watchlist': true,
    };
    String jsonBody = json.encode(body);
    var res = await http.post(
      Uri.parse(
        '$baseUrl/account/$accountId/watchlist',
      ),
      headers: <String, String>{
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmNDcyZjgxOGUxMzdiN2RhZjhmYmU2ZTFlOWMyZGY3YyIsInN1YiI6IjY0MWM2NTc2OTVjMGFmMDBjNWFmNmEwMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jytnQ1YkH2BCWTp57f3vYF-5qJoEks31CFHcPEoIF-w',
        'accept': 'application/json',
        'content-type': 'application/json',
      },
      body: jsonBody,
    );
    if (res.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to create movie.');
    }
  }
}
