import 'package:bloc/bloc.dart';

import '../../service/api_service.dart';
import 'movie_info_event.dart';
import 'movie_info_state.dart';

class MovieInfoBloc extends Bloc<MovieInfoEvent, MovieInfoState> {
  final repo = FetchMovieDataById();

  MovieInfoBloc() : super(MovieInfoInitial()) {
    on<MovieInfoEvent>((event, emit) async {
      if (event is LoadMoviesInfo) {
        try {
          emit(MovieInfoLoading());
          final List<dynamic> info = await repo.getDetails(event.id);
          emit(MovieInfoLoaded(
            imdbData: info[1],
            backdrops: info[2],
            tmdbData: info[0],
            cast: info[3],
          ));
        } on FetchDataError catch (e) {
          emit(MovieInfoError(error: e));
        } catch (e) {
          emit(MovieInfoError(
              error: FetchDataError(e.toString() as FetchDataError)));
        }
      }
    });
  }
}
