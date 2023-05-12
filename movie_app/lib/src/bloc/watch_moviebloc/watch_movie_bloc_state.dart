import 'package:equatable/equatable.dart';
import 'package:movie_app/src/model/movie.dart';

abstract class WatchMovieState extends Equatable {
  const WatchMovieState();

  @override
  List<Object> get props => [];
}

class WatchMovieLoading extends WatchMovieState {}

class WatchMovieLoaded extends WatchMovieState {
  final List<Movie> movieUpcomingList;
  final List<Movie> movieTopRateList;
  final List<Movie> moviePopularList;
  final List<Movie> movieNowPlayingList;
  const WatchMovieLoaded(
    this.movieUpcomingList,
    this.movieTopRateList,
    this.moviePopularList,
    this.movieNowPlayingList,
  );

  @override
  List<Object> get props => [
        movieUpcomingList,
        movieTopRateList,
        moviePopularList,
        movieNowPlayingList
      ];
}

class MovieError extends WatchMovieState {
  const MovieError(Exception e);
}
