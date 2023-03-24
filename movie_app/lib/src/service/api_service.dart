import 'package:dio/dio.dart';
import 'package:movie_app/src/model/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https://api.themoviedb.org/3';
  final String apiKey = 'f472f818e137b7daf8fbe6e1e9c2df7c';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final url = '$baseUrl/movie/now_playing?api_key=$apiKey';
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromjson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }

  getMovieByGenre(int movieId) {}
}
