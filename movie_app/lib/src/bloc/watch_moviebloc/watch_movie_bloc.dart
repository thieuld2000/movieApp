import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/bloc/watch_moviebloc/watch_movie_bloc_event.dart';
import 'package:movie_app/src/bloc/watch_moviebloc/watch_movie_bloc_state.dart';
import 'package:movie_app/src/model/movie.dart';

import '../../service/api_service.dart';

class WatchMovieBloc extends Bloc<WatchMovieEvent, WatchMovieState> {
  WatchMovieBloc() : super(WatchMovieLoading());

  @override
  Stream<WatchMovieState> mapEventToState(WatchMovieEvent event) async* {
    if (event is WatchMovieEventStarted) {
      yield* _mapWatchMovieEventStateToState();
    }
  }

  Stream<WatchMovieState> _mapWatchMovieEventStateToState() async* {
    final service = ApiService();
    yield WatchMovieLoading();
    try {
      List<Movie> movieUpcomingList = await service.getUpComingMovie();
      List<Movie> movieTopRateList = await service.getTopRateMovie();
      List<Movie> moviePopularList = await service.getPopularMovie();
      List<Movie> movieNowPlayingList = await service.getNowPlayingMovie();

      yield WatchMovieLoaded(movieUpcomingList, movieTopRateList,
          moviePopularList, movieNowPlayingList);
    } on Exception catch (e) {
      yield MovieError(e);
    }
  }
}
