import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:movie_app/src/model/genre.dart';
import 'package:movie_app/src/model/movie.dart';

import '../bloc/movie_info_bloc/movie_info_state.dart';
import '../model/cast_info_model.dart';

const String baseUrl = 'https://api.themoviedb.org/3';
const String apiKey = 'f472f818e137b7daf8fbe6e1e9c2df7c';

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
    // TrailerList trailersData;
    ImageBackdropList backdropsData;
    // CastInfoList castData;
    // MovieModelList similarData;
    var images = [];
    dynamic movie;
    var response =
        await http.get(Uri.parse('$baseUrl/movie/$id?api_key=$apiKey'));
    if (response.statusCode == 200) {
      movie = jsonDecode(response.body);
    } else {
      throw FetchDataError(e as FetchDataError);
    }

    movieData = MovieInfoModel.fromJson(movie);

    backdropsData = ImageBackdropList.fromJson(images);

    // castData = CastInfoList.fromJson(movie['credits']);
    // similarData = MovieModelList.fromJson(movie['similar']['results']);

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
      // trailersData.trailers,
      omdbData,
      backdropsData.backdrops,
      // castData.castList,
      // similarData.movies,
    ];
  }
}

class FetchCastInfoById {
  Future<List<dynamic>> getCastDetails(String id) async {
    CastPersonalInfo prinfo;

    ImageBackdropList backdrops;
    MovieModelList movies;

    var response = await http
        .get(Uri.parse('$baseUrl/person/$id/movie_credits?api_key=$apiKey'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      prinfo = CastPersonalInfo.fromJson(data);

      backdrops = ImageBackdropList.fromJson(data['cast']);
      movies = MovieModelList.fromJson(data['cast']);

      return [
        prinfo,
        backdrops.backdrops,
        movies.movies,
      ];
    } else {
      throw FetchDataError(e as FetchDataError);
    }
  }
}
