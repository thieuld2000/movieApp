import 'package:equatable/equatable.dart';
import 'package:movie_app/src/model/movie.dart';

abstract class WatchListState extends Equatable {
  const WatchListState();

  @override
  List<Object> get props => [];
}

class WatchListLoading extends WatchListState {}

class WatchListLoaded extends WatchListState {
  final List<MovieInfoModel> movieWatchList;

  const WatchListLoaded(
    this.movieWatchList,
  );

  @override
  List<Object> get props => [
        movieWatchList,
      ];
}

class MovieError extends WatchListState {
  const MovieError(Exception e);
}
