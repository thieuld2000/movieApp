import 'package:equatable/equatable.dart';

abstract class WatchMovieEvent extends Equatable {
  const WatchMovieEvent();
}

class WatchMovieEventStarted extends WatchMovieEvent {
  const WatchMovieEventStarted(selectMovie);

  @override
  List<Object> get props => [];
}
