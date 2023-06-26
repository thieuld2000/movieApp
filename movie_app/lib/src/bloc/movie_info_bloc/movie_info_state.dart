import 'package:equatable/equatable.dart';

import '../../model/movie.dart';

abstract class MovieInfoState extends Equatable {
  const MovieInfoState();

  @override
  List<Object> get props => [];
}

class MovieInfoInitial extends MovieInfoState {}

class MovieInfoLoading extends MovieInfoState {}

class MovieInfoLoaded extends MovieInfoState {
  final MovieInfoModel tmdbData;
  final MovieInfoImdb imdbData;
  final List<CastInfo> cast;
  final List<ImageBackdrop> backdrops;

  const MovieInfoLoaded({
    required this.tmdbData,
    required this.imdbData,
    required this.backdrops,
    required this.cast,
  });
}

class MovieInfoError extends MovieInfoState {
  final FetchDataError error;

  const MovieInfoError({
    required this.error,
  });
}

class FetchDataError {
  late final FetchDataError error;

  FetchDataError(this.error);
}
