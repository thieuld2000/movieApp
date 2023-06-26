part of 'genre_results_cubit.dart';

enum MovieStatus {
  initial,
  loading,
  loaded,
  adding,
  error,
  allfetched,
}

enum TvStatus {
  initial,
  loading,
  loaded,
  adding,

  allfetched,
  error,
}

class GenreResultsState {
  final int moviePage;

  final bool moviesFull;

  final String query;
  final MovieStatus movieStatus;

  final List<Movie> movies;

  GenreResultsState({
    required this.moviePage,
    required this.moviesFull,
    required this.query,
    required this.movieStatus,
    required this.movies,
  });
  factory GenreResultsState.initial() => GenreResultsState(
        moviePage: 1,
        movieStatus: MovieStatus.initial,
        moviesFull: false,
        movies: [],
        query: '',
      );

  GenreResultsState copyWith({
    int? moviePage,
    int? tvPage,
    bool? moviesFull,
    bool? tvFull,
    String? query,
    MovieStatus? movieStatus,
    TvStatus? tvStatus,
    List<Movie>? movies,
  }) {
    return GenreResultsState(
      moviePage: moviePage ?? this.moviePage,
      moviesFull: moviesFull ?? this.moviesFull,
      query: query ?? this.query,
      movieStatus: movieStatus ?? this.movieStatus,
      movies: movies ?? this.movies,
    );
  }
}
