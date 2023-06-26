import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/src/bloc/watch_list_bloc/watch_list_event.dart';
import 'package:movie_app/src/bloc/watch_list_bloc/watch_list_state.dart';
import 'package:movie_app/src/service/api_service.dart';
import '../../model/movie.dart';

class WatchListBloc extends Bloc<WatchListEvent, WatchListState> {
  WatchListBloc() : super(WatchListLoading());

  @override
  Stream<WatchListState> mapEventToState(WatchListEvent event) async* {
    if (event is WatchListEventStarted) {
      yield* _mapWatchListEventStateToState();
    }
  }

  Stream<WatchListState> _mapWatchListEventStateToState() async* {
    final service = FetchWatchList();
    List<MovieInfoModel> movieWatchList;
    yield WatchListLoading();
    try {
      movieWatchList = await service.getWatchList();

      yield WatchListLoaded(movieWatchList);
    } on Exception catch (e) {
      yield MovieError(e);
    }
  }
}
