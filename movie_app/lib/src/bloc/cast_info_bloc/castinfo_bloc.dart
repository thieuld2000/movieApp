import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/cast_info_model.dart';
import '../../model/movie.dart';
import '../../service/api_service.dart';
import '../movie_info_bloc/movie_info_state.dart';

part 'castinfo_event.dart';
part 'castinfo_state.dart';

class CastinfoBloc extends Bloc<CastinfoEvent, CastinfoState> {
  final FetchCastInfoById repo = FetchCastInfoById();

  CastinfoBloc() : super(CastinfoInitial()) {
    on<CastinfoEvent>((event, emit) async {
      if (event is LoadCastInfo) {
        try {
          emit(CastinfoLoading());
          final data = await repo.getCastDetails(event.id);

          emit(CastinfoLoaded(
            info: data[0],
            images: data[1],
          ));
        } on FetchDataError catch (e) {
          emit(CastinfoError(error: e));
        } catch (e) {
          emit(CastinfoError(
              error: FetchDataError(e.toString() as FetchDataError)));
        }
      }
    });
  }
}
