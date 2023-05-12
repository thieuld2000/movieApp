import 'package:dio/dio.dart';
import 'package:movie_app/src/model/genre.dart';
import 'package:movie_app/src/model/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'f472f818e137b7daf8fbe6e1e9c2df7c';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final url =
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
